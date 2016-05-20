# Defines our Vagrant environment
#
# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV["VAGRANT_DETECTED_OS"] = ENV["VAGRANT_DETECTED_OS"].to_s + " cygwin"
Vagrant.configure("2") do |config|

  # create load balancer
  (1..1).each do |i|
    config.vm.define "lb#{i}" do |lb_config|
       lb_config.vm.box = "centos/7"
       lb_config.vm.hostname = "lb#{i}"
       lb_config.vm.network :private_network, ip: "10.0.0.1#{i}"
       lb_config.vm.network "forwarded_port", guest: 80, host: "8#{i}"
       lb_config.vm.provider "virtualbox" do |vb|
         vb.memory = "256"
       end
    end
  end

  # create some web servers
  # https://docs.vagrantup.com/v2/vagrantfile/tips.html
  (1..2).each do |i|
    config.vm.define "web#{i}" do |node|
        node.vm.box = "centos/7"
        node.vm.hostname = "web#{i}"
        node.vm.network :private_network, ip: "10.0.0.2#{i}"
        node.vm.network "forwarded_port", guest: 80, host: "808#{i}"
        node.vm.provider "virtualbox" do |vb|
          vb.memory = "256"
        end
    end
  end

  #create ansible node
  config.vm.define :ans do |ans_config|
      ans_config.vm.box = "centos/7"
      ans_config.vm.hostname = "ans"
      ans_config.vm.network :private_network, ip: "10.0.0.2"
      ans_config.vm.provider "virtualbox" do |vb|
        vb.memory = "256"
      end
      ans_config.vm.provision :shell, path: "bootstrap-ans.sh"
  end

end
