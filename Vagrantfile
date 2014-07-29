# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "precise64"
  # this VM is based on the predefined box precise64 that is available from the following URL 
  # note: the box will be downloaded (330 MB) from that URL if Vagrant cannot not find it locally (in the Vagrant home - by default: HOME/.vagrant.d/boxes))
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.hostname = "adf12-1-3.amis.sandbox"

  # any network request on the host made to the specified port (8888 or 1521) should be forwarded into the VM and handled there
  config.vm.network :forwarded_port, guest: 8080, host: 8888
  config.vm.network :forwarded_port, guest: 1521, host: 1521
  # also forward requests to port 7101 in the VM - that is where the JDeveloper Integrated WebLogic Server is typically running
  config.vm.network :forwarded_port, guest: 7101, host: 7501
  config.vm.network :forwarded_port, guest: 7102, host: 7502


  config.vm.synced_folder "files", "/etc/puppet/files"
  config.vm.synced_folder "files", "/vagrant", :mount_options => ["dmode=777","fmode=777"]
  # the next line is supported from Vagrant 1.6 onwards; it displays a message on the command line after "vagrant up" has brought up the VM
  # config.vm.post_up_message = "Virtual Box is running. You can connect using username vagrant with password vagrant."
  config.ssh.forward_agent = true

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "4096"]	
    vb.gui = true
    vb.name = "JDeveloper 12.1.3 with Oracle Database XE 11gR2 on Ubuntu"
	# unfortunately, the description of a VirtualBox VM cannot be set at the present; this next line would not work
	# vb.description = "Handy little VM for hands-on with the latest JDeveloper and ADF or for simple Database experiments"
  end

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.module_path    = "modules"
    puppet.manifest_file  = "base.pp"
  end

end
