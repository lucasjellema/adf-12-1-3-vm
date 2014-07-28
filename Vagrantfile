# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "adf-12_1_3-environment"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.hostname = "adf12-1-3.amis.sandbox"

  config.vm.network :forwarded_port, guest: 8080, host: 8080
  config.vm.network :forwarded_port, guest: 1521, host: 1521

  config.vm.synced_folder "files", "/etc/puppet/files"
  config.vm.synced_folder "files", "/vagrant", :mount_options => ["dmode=777","fmode=777"]

  config.ssh.forward_agent = true

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "4096"]
  vb.gui = true
  end




  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.module_path    = "modules"
    puppet.manifest_file  = "base.pp"
  end

end
