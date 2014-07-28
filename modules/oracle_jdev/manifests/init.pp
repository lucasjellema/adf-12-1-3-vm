class oracle_jdev::config {
	$group			= "dba"
	$mdwHome		= "/u01/app/oracle/product/12.1.3/jdeveloper"
	$oraInventory	= "/u01/app/oracle/oraInventory"
	$hrPassword 	= "hr"
	$sysPassword 	= "oracle"
}

class oracle_jdev::install inherits oracle_jdev::config { 
	
	include oracle_jdev::config

	file { "silent_jdeveloper.xml":
		path    => "/tmp/silent.xml",
		ensure  => present,
		replace => 'yes',
		content => template("oracle_jdev/silent_jdeveloper_1213.xml.erb"),
	}
	
	 file { "/etc/oraInst.loc":
		ensure	=> present,
		content	=> template("oracle_jdev/oraInst.loc.erb"),
		group	=> "dba",
		mode	=> 0664,
		require	=> Service["oracle-xe"],
	 }
	 file { "/usr/share/applications/jdeveloper.desktop":
		ensure	=> present,
		content	=> template("oracle_jdev/jdeveloper.desktop.erb"),
		require	=> Package["ubuntu-desktop"],
	 }
	 file { "/usr/share/pixmaps/jdeveloper.png":
		ensure	=> present,
		source	=> "puppet:///modules/oracle_jdev/jdeveloper.png",
	 }
	 file { ["/u01/app/oracle/product"]:
		ensure  => directory,
		owner	=> "oracle",
		group	=> "dba",
		require	=> Service["oracle-xe"],
	}
	 file { ["/u01/app/oracle/product/12.1.3", "/u01/app/oracle/product/12.1.3/jdeveloper"]:
		ensure  => directory,
		owner	=> "oracle",
		group	=> "dba",
		require	=> Service["oracle-xe"],
	}

	exec { "installjdev":
		command	=> "/etc/puppet/files/jdev_suite_121300_linux64.bin -silent -responseFile /tmp/silent.xml -invPtrLoc /etc/oraInst.loc -ignoreSysPrereqs",
		user	=> "oracle",
		require	=> [File["/etc/oraInst.loc"], File["/u01/app/oracle/product/12.1.3/jdeveloper"]],
		creates	=> "/u01/app/oracle/product/12.1.3/jdeveloper/jdeveloper/",
		timeout	=> 0,
	}

	exec { "change_directory_permissions":
		command	=> "/bin/chmod -R 777 /u01/app/oracle/product/12.1.3",
		user	=> "oracle",
		require	=> Exec["installjdev"],
		timeout	=> 0,
	}

}

class oracle_jdev::connections inherits oracle_jdev::config {

	include oracle_jdev::config
	

	file { ["/u01/app/oracle/.jdeveloper", 
			"/home/vagrant/.jdeveloper/system12.1.3.0.41.140521.1008", 
			"/home/vagrant/.jdeveloper/system12.1.3.0.41.140521.1008/o.jdeveloper.rescat2.model", 
			"/home/vagrant/.jdeveloper/system12.1.3.0.41.140521.1008/o.jdeveloper.rescat2.model/connections"]:
		ensure  => directory,
		owner	=> "oracle",
		group	=> "dba",
		require	=> [Service["oracle-xe"],Exec["installjdev"], Exec["change_directory_permissions"]],
	}
	file { "/home/vagrant/.jdeveloper/system12.1.3.0.41.140521.1008/o.jdeveloper.rescat2.model/connections/connections.xml":
		ensure	=> present,
		content	=> template("oracle_jdev/connections.xml.erb"),
		owner	=> "oracle",
		group	=> "dba",
		require	=> Service["oracle-xe"],
	}
}