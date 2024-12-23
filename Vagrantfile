# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_NO_PARALLEL'] = 'yes'
# ENV["DEFAULT_BRIDGE"] ||= "wlp111s0"
# ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'
VAGRANTFILE_API_VERSION = "2"

VITUAL_IP         ="192.168.1.200"
KMASTER1_IP       ="192.168.1.201"
KMASTER2_IP       ="192.168.1.202"
KMASTER3_IP       ="192.168.1.203"

KWORKER1_IP       ="192.168.1.204"
KWORKER2_IP       ="192.168.1.205"
KWORKER3_IP       ="192.168.1.206"

LOADBALANCER1_IP  ="192.168.1.207"
LOADBALANCER2_IP  ="192.168.1.208"

SQL_IP            ="192.168.1.209"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provision "shell", path: "bootstrap.sh"

  #Kmaster1
  config.vm.define "kmaster1" do |masternode|
    masternode.vm.box               = "generic/ubuntu2304"
    masternode.vm.box_check_update  = false
    masternode.vm.hostname          = "kmaster1.example.com"
    masternode.vm.network "public_network", ip: KMASTER1_IP
    masternode.vm.provider :virtualbox do |v|
      v.name   = "kmaster1"
      v.memory = 4096
      v.cpus   = 8
      v.gui = false
    end
    masternode.vm.provision "shell", path: "master.sh"
  end

  #Kmaster2
  config.vm.define "kmaster2" do |masternode|
    masternode.vm.box               = "generic/ubuntu2304"
    masternode.vm.box_check_update  = false
    masternode.vm.hostname          = "kmaster2.example.com"
    masternode.vm.network "public_network", ip: KMASTER2_IP
    masternode.vm.provider :virtualbox do |v|
      v.name   = "kmaster2"
      v.memory = 4096
      v.cpus   = 8
      v.gui = false
    end
    masternode.vm.provision "shell", path: "master.sh"
  end

  #Kmaster3
  config.vm.define "kmaster3" do |masternode|
    masternode.vm.box               = "generic/ubuntu2304"
    masternode.vm.box_check_update  = false
    masternode.vm.hostname          = "kmaster3.example.com"
    masternode.vm.network "public_network", ip: KMASTER3_IP
    masternode.vm.provider :virtualbox do |v|
      v.name   = "kmaster3"
      v.memory = 4096
      v.cpus   = 8
      v.gui = false
    end
    masternode.vm.provision "shell", path: "master.sh"
  end

  #Kworker1
  config.vm.define "kworker1" do |workernode|
    workernode.vm.box               = "generic/ubuntu2304"
    workernode.vm.box_check_update  = false
    workernode.vm.hostname          = "kworker1.example.com"
    workernode.vm.network "public_network", ip: KWORKER1_IP
    workernode.vm.provision "shell", path: "master.sh"
    workernode.vm.provider :virtualbox do |v|
      v.name   = "kworker1"
      v.memory = 4096
      v.cpus   = 8
      v.gui = false
      end
  end

  #Kworker2
  config.vm.define "kworker2" do |workernode|
    workernode.vm.box               = "generic/ubuntu2304"
    workernode.vm.box_check_update  = false
    workernode.vm.hostname          = "kworker2.example.com"
    workernode.vm.network "public_network", ip: KWORKER2_IP
    workernode.vm.provision "shell", path: "master.sh"
    workernode.vm.provider :virtualbox do |v|
      v.name   = "kworker2"
      v.memory = 4096
      v.cpus   = 8
      v.gui = false
      end
  end

  #Kworker3
  config.vm.define "kworker3" do |workernode|
    workernode.vm.box               = "generic/ubuntu2304"
    workernode.vm.box_check_update  = false
    workernode.vm.hostname          = "kworker3.example.com"
    workernode.vm.network "public_network", ip: KWORKER3_IP
    workernode.vm.provision "shell", path: "master.sh"
    workernode.vm.provider :virtualbox do |v|
      v.name   = "kworker3"
      v.memory = 4096
      v.cpus   = 8
      v.gui = false
      end
  end

  #Loadbalancer1
  config.vm.define "loadbalancer1" do |lb|
    lb.vm.box               = "generic/ubuntu2304"
    lb.vm.box_check_update  = false
    lb.vm.hostname          = "loadbalancer1.example.com"
    lb.vm.network "public_network", ip: LOADBALANCER1_IP
    lb.vm.provider :virtualbox do |v|
      v.name   = "loadbalancer1"
      v.memory = 4096
      v.cpus   = 8
      v.gui = false
      end
    lb.vm.provision "shell", path: "loadbalancer.sh"
  end

  #Loadbalancer2
  config.vm.define "loadbalancer2" do |lb|
    lb.vm.box               = "generic/ubuntu2304"
    lb.vm.box_check_update  = false
    lb.vm.hostname          = "loadbalancer2.example.com"
    lb.vm.network "public_network", ip: LOADBALANCER2_IP
    lb.vm.provider :virtualbox do |v|
      v.name   = "loadbalancer2"
      v.memory = 4096
      v.cpus   = 8
      v.gui = false
      end
    lb.vm.provision "shell", path: "loadbalancer.sh"
  end

  #Test Postgresql
  config.vm.define "sql1" do |testnode|
    testnode.vm.box               = "generic/ubuntu2304"
    testnode.vm.box_check_update  = false
    testnode.vm.hostname          = "sql1.example.com"
    testnode.vm.network "public_network", ip: SQL_IP
    testnode.vm.provider :virtualbox do |v|
      v.name   = "sql1"
      v.memory = 4096
      v.cpus   = 8
      v.gui = false
    end
  end

  # # Load Balancer Nodes
  # LoadBalancerCount = 2

  # (1..LoadBalancerCount).each do |i|

  #   config.vm.define "loadbalancer#{i}" do |lb|

  #     lb.vm.box               = "generic/ubuntu2304"
  #     lb.vm.box_check_update  = false
  #     lb.vm.hostname          = "loadbalancer#{i}.example.com"
  #     # lb.vm.network :public_network,
  #     #   :dev => "wlp111s0",
  #     #   :mode => "bridge",
  #     #   :type => "bridge"

  #     # lb.vm.network "public_network", ip: "192.168.0.8#{i}"
  #     lb.vm.network "public_network", ip: "192.168.1.8#{i}" #ksps
  #     # lb.vm.network :public_network, :dev => "eno1", :mode => "bridge", :type => "bridge"

  #     lb.vm.provider :virtualbox do |v|
  #       v.name   = "loadbalancer#{i}"
  #       v.memory = 4096
  #       v.cpus   = 8
  #       v.gui = false
  #     end

  #     lb.vm.provision "shell", path: "loadbalancer.sh"

  #     # lb.vm.provider :libvirt do |v|
  #     #   # v.name   = "loadbalancer#{i}=========
  #     #   v.memory  = 4096
  #     #   v.cpus    = 8
  #     # end

  #   end

  # end


  # # Kubernetes Master Nodes
  # MasterCount = 3

  # (1..MasterCount).each do |i|

  #   config.vm.define "kmaster#{i}" do |masternode|

  #     masternode.vm.box               = "generic/ubuntu2304"
  #     masternode.vm.box_check_update  = false
  #     masternode.vm.hostname          = "kmaster#{i}.example.com"
  #     # masternode.vm.network :public_network,
  #     # :dev => "wlp111s0",
  #     # :mode => "bridge",
  #     # :type => "bridge"

  #     # masternode.vm.network "public_network", ip: "192.168.0.1#{i}"
  #     masternode.vm.network "public_network", ip: "192.168.1.10#{i}" #ksps
  #     # masternode.vm.network :public_network, :dev => "eno1", :mode => "bridge", :type => "bridge"
  #     masternode.vm.provider :virtualbox do |v|
  #       v.name   = "kmaster#{i}"
  #       v.memory = 4096
  #       v.cpus   = 8
  #       v.gui = false
  #     end
  #     masternode.vm.provision "shell", path: "master.sh"
    
  #     # masternode.vm.provider :libvirt do |v|
  #     #   # v.name   = "kmaster#{i}"
  #     #   v.memory  = 4096
  #     #   v.cpus    = 8
  #     # end

  #   end

  # end


  # # Kubernetes Worker Nodes
  # WorkerCount = 2

  # (1..WorkerCount).each do |i|

  #   config.vm.define "kworker#{i}" do |workernode|

  #     workernode.vm.box               = "generic/ubuntu2304"
  #     workernode.vm.box_check_update  = false
  #     workernode.vm.hostname          = "kworker#{i}.example.com"

  #     # workernode.vm.network :public_network,
  #     # :dev => "wlp111s0",
  #     # :mode => "bridge",
  #     # :type => "bridge"

  #     # workernode.vm.network "public_network", ip: "192.168.0.2#{i}"
  #     workernode.vm.network "public_network", ip: "192.168.1.9#{i}" #ksps
  #     # workernode.vm.network :public_network, :dev => "eno1", :mode => "bridge", :type => "bridge"
  #     workernode.vm.provision "shell", path: "master.sh"

  #     workernode.vm.provider :virtualbox do |v|
  #       v.name   = "kworker#{i}"
  #       v.memory = 4096
  #       v.cpus   = 8
  #       v.gui = false
  #     end

  #     # workernode.vm.provider :libvirt do |v|
  #     #   # v.name   = "kworker#{i}"
  #     #   # v.nested  = true
  #     #   v.memory  = 4096
  #     #   v.cpus    = 8
  #     # end

  #   end

  # end
end
