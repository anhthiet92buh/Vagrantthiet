# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_NO_PARALLEL'] = 'yes'
# ENV["DEFAULT_BRIDGE"] ||= "wlp111s0"
# ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

Vagrant.configure(2) do |config|

  config.vm.provision "shell", path: "bootstrap.sh"

  # Load Balancer Nodes
  LoadBalancerCount = 2

  (1..LoadBalancerCount).each do |i|

    config.vm.define "loadbalancer#{i}" do |lb|

      lb.vm.box               = "generic/ubuntu2304"
      lb.vm.box_check_update  = false
      lb.vm.hostname          = "loadbalancer#{i}.example.com"
      # lb.vm.network :public_network,
      #   :dev => "wlp111s0",
      #   :mode => "bridge",
      #   :type => "bridge"

      lb.vm.network "public_network", ip: "192.168.0.3#{i}"
      # lb.vm.network :public_network, :dev => "eno1", :mode => "bridge", :type => "bridge"

      lb.vm.provider :virtualbox do |v|
        v.name   = "loadbalancer#{i}"
        v.memory = 4096
        v.cpus   = 8
        v.gui = true
      end

      lb.vm.provision "shell", path: "loadbalancer.sh"

      # lb.vm.provider :libvirt do |v|
      #   # v.name   = "loadbalancer#{i}"
      #   v.memory  = 4096
      #   v.cpus    = 8
      # end

    end

  end


  # Kubernetes Master Nodes
  MasterCount = 3

  (1..MasterCount).each do |i|

    config.vm.define "kmaster#{i}" do |masternode|

      masternode.vm.box               = "generic/ubuntu2304"
      masternode.vm.box_check_update  = false
      masternode.vm.hostname          = "kmaster#{i}.example.com"
      # masternode.vm.network :public_network,
      # :dev => "wlp111s0",
      # :mode => "bridge",
      # :type => "bridge"

      masternode.vm.network "public_network", ip: "192.168.0.1#{i}"
      # masternode.vm.network :public_network, :dev => "eno1", :mode => "bridge", :type => "bridge"
      masternode.vm.provider :virtualbox do |v|
        v.name   = "kmaster#{i}"
        v.memory = 4096
        v.cpus   = 8
        v.gui = true
      end
      masternode.vm.provision "shell", path: "master.sh"
    
      # masternode.vm.provider :libvirt do |v|
      #   # v.name   = "kmaster#{i}"
      #   v.memory  = 4096
      #   v.cpus    = 8
      # end

    end

  end


  # Kubernetes Worker Nodes
  WorkerCount = 2

  (1..WorkerCount).each do |i|

    config.vm.define "kworker#{i}" do |workernode|

      workernode.vm.box               = "generic/ubuntu2304"
      workernode.vm.box_check_update  = false
      workernode.vm.hostname          = "kworker#{i}.example.com"

      # workernode.vm.network :public_network,
      # :dev => "wlp111s0",
      # :mode => "bridge",
      # :type => "bridge"

      workernode.vm.network "public_network", ip: "192.168.0.2#{i}"
      # workernode.vm.network :public_network, :dev => "eno1", :mode => "bridge", :type => "bridge"
      workernode.vm.provision "shell", path: "master.sh"

      workernode.vm.provider :virtualbox do |v|
        v.name   = "kworker#{i}"
        v.memory = 4096
        v.cpus   = 8
        v.gui = true
      end

      # workernode.vm.provider :libvirt do |v|
      #   # v.name   = "kworker#{i}"
      #   # v.nested  = true
      #   v.memory  = 4096
      #   v.cpus    = 8
      # end

    end

  end

end
