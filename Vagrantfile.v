# -*- mode: ruby -*-
# vi: set ft=ruby :

# ENV['VAGRANT_NO_PARALLEL'] = 'yes'
ENV["DEFAULT_BRIDGE"] ||= "wlp111s0"

Vagrant.configure(2) do |config|

  config.vm.provision "shell", path: "bootstrap.sh"

  # Load Balancer Nodes
  LoadBalancerCount = 2

  (1..LoadBalancerCount).each do |i|

    config.vm.define "loadbalancer#{i}" do |lb|

      lb.vm.box               = "generic/ubuntu2304"
      lb.vm.box_check_update  = false
      lb.vm.hostname          = "loadbalancer#{i}.example.com"

      lb.vm.network "public_network", ip: "192.168.0.5#{i}"

      lb.vm.provider :virtualbox do |v|
        v.name   = "loadbalancer#{i}"
        v.memory = 2048
        v.cpus   = 4
      end

      lb.vm.provision "shell", path: "loadbalancer.sh"

      # lb.vm.provider :libvirt do |v|
      #   v.memory  = 2048
      #   v.cpus    = 4
      # end

    end

  end


  # Kubernetes Master Nodes
  MasterCount = 2

  (1..MasterCount).each do |i|

    config.vm.define "kmaster#{i}" do |masternode|

      masternode.vm.box               = "generic/ubuntu2304"
      masternode.vm.box_check_update  = false
      masternode.vm.hostname          = "kmaster#{i}.example.com"

      masternode.vm.network "public_network", ip: "192.168.0.10#{i}"

      masternode.vm.provider :virtualbox do |v|
        v.name   = "kmaster#{i}"
        v.memory = 2048
        v.cpus   = 4
      end
      masternode.vm.provision "shell", path: "master.sh"
    
      # masternode.vm.provider :libvirt do |v|
      #   v.nested  = true
      #   v.memory  = 2048
      #   v.cpus    = 4
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

      workernode.vm.network "public_network", ip: "192.168.0.20#{i}"
      workernode.vm.provision "shell", path: "master.sh"

      workernode.vm.provider :virtualbox do |v|
        v.name   = "kworker#{i}"
        v.memory = 2048
        v.cpus   = 4
      end

      # workernode.vm.provider :libvirt do |v|
      #   v.nested  = true
      #   v.memory  = 2048
      #   v.cpus    = 4
      # end

    end

  end

end
