# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

    config.vm.box = "scotch/box"
    config.vm.network "private_network", ip: "192.168.16.11"
    config.vm.hostname = "info.scotchbox"
    config.vm.synced_folder ".", "/var/www", :mount_options => ["dmode=777", "fmode=666"]
    
    config.vm.provision "multihost", type: "shell" do |s|
      s.path = "./provision/setup.sh"
      s.privileged = true
      s.keep_color = true
    end

end
