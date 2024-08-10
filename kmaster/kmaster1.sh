kubeadm init --control-plane-endpoint="192.168.1.190:6443" --upload-certs --apiserver-advertise-address=192.168.1.191 --pod-network-cidr=10.244.0.0/16
#kubeadm init --upload-certs --apiserver-advertise-address=192.168.1.191 --pod-network-cidr=10.244.0.0/16 --resolv-conf=systemd-resolved
