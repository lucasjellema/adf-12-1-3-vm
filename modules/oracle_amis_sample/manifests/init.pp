
class oracle_amis_sample::install  { 
	
	 file { "/u01/app/oracle/scripts/sys-ddl.sql":
		ensure	=> present,
		source	=> "puppet:///modules/oracle_amis_sample/sys-ddl.sql",
		owner	=> "oracle",
		group	=> "dba",
		require	=> Service["oracle-xe"],
	}	 
	file { "/u01/app/oracle/scripts/ddl.sql":
		ensure	=> present,
		source	=> "puppet:///modules/oracle_amis_sample/ddl.sql",
		owner	=> "oracle",
		group	=> "dba",
		require	=> Service["oracle-xe"],
	}
	file { "/u01/app/oracle/scripts/dml.sql":
		ensure	=> present,
		source	=> "puppet:///modules/oracle_amis_sample/dml.sql",
		owner	=> "oracle",
		group	=> "dba",
		require	=> Service["oracle-xe"],
	}
	exec { "create_wc_schema":
		command		=> "/u01/app/oracle/product/11.2.0/xe/bin/sqlplus -S -L \"sys/$sysPassword as sysdba\" @/u01/app/oracle/scripts/sys-ddl.sql",
		user		=> "oracle",
		logoutput => true,
		environment	=> ["ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe", "ORACLE_SID=XE", "ORACLE_BASE=/u01/app/oracle"],
		require		=> [File["/u01/app/oracle/scripts/sys-ddl.sql"], Service["oracle-xe"]],
	}
	exec { "ddl_in_wc_schema":
		command		=> "/u01/app/oracle/product/11.2.0/xe/bin/sqlplus -S -L \"wc/wc \" @/u01/app/oracle/scripts/ddl.sql",
		user		=> "oracle",
		logoutput => true,
		environment	=> ["ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe", "ORACLE_SID=XE", "ORACLE_BASE=/u01/app/oracle"],
		require		=> [Exec["create_wc_schema"]],
	}
	exec { "dml_in_wc_schema":
		command		=> "/u01/app/oracle/product/11.2.0/xe/bin/sqlplus -S -L \"wc/wc \" @/u01/app/oracle/scripts/dml.sql",
		user		=> "oracle",
		logoutput => true,
		environment	=> ["ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe", "ORACLE_SID=XE", "ORACLE_BASE=/u01/app/oracle"],
		require		=> [Exec["ddl_in_wc_schema"]],
	}

}
