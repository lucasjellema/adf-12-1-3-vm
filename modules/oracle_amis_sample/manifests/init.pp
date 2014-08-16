class oracle_amis_sample::clone_git_repos  { 

file { '/home/vagrant/adfdvt12_1_3-handson' :
        ensure  => directory,
        group   => 'vagrant',
        owner   => 'vagrant',
        mode    => 0777,
    }

vcsrepo { "/home/vagrant/adfdvt12_1_3-handson":
  ensure   => present,
  provider => git,
  require  => [ Package["git"] ],
  source   => "git://github.com/lucasjellema/adf_dvt_12_1_3_handson.git",
}

	exec { "change_directory_permissions_cloned_repos":
		command	=> "/bin/chmod -R 777 /home/vagrant/adfdvt12_1_3-handson",
		user	=> "root",
		require		=> [Vcsrepo["/home/vagrant/adfdvt12_1_3-handson"]],
		timeout	=> 0,
	}

}

class oracle_amis_sample::install  { 
# the resource populate_wc_schema has a dependency on the (creation of the) github clone; henced this include  
	include oracle_amis_sample::clone_git_repos

	 file { "/u01/app/oracle/scripts/sys-ddl.sql":
		ensure	=> present,
		source	=> "puppet:///modules/oracle_amis_sample/sys-ddl.sql",
		owner	=> "oracle",
		group	=> "dba",
		require	=> Service["oracle-xe"],
	}	 
/*	file { "/u01/app/oracle/scripts/ddl.sql":
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
*/
	exec { "create_wc_schema":
		command		=> "/u01/app/oracle/product/11.2.0/xe/bin/sqlplus -S -L \"sys/$sysPassword as sysdba\" @/u01/app/oracle/scripts/sys-ddl.sql",
		user		=> "oracle",
		logoutput => true,
		environment	=> ["ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe", "ORACLE_SID=XE", "ORACLE_BASE=/u01/app/oracle"],
		require		=> [File["/u01/app/oracle/scripts/sys-ddl.sql"], Service["oracle-xe"]],
	}

    # create database objects and load data using the scripts that were cloned from GitHub 
	exec { "populate_wc_schema":
		command		=> "/u01/app/oracle/product/11.2.0/xe/bin/sqlplus -S -L \"wc/wc \" @/home/vagrant/adfdvt12_1_3-handson/database/demo_db_schema_worldcup2014.sql",
		user		=> "oracle",
		logoutput => true,
		environment	=> ["ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe", "ORACLE_SID=XE", "ORACLE_BASE=/u01/app/oracle"],
		require		=> [Exec["create_wc_schema"],Vcsrepo["/home/vagrant/adfdvt12_1_3-handson"]]
	}

/*
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
*/

}
