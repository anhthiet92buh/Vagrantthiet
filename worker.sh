#!/bin/bash
echo The Path of workplace: $PWD
# echo Start Apt update va upgrade
# sudo apt update && sudo apt upgrade -y
# echo End of update
rm -rf *

sudo apt install net-tools -y
# swapoff -a
swapoff -a; sed -i '/swap/d' /etc/fstab
systemctl disable --now ufw

# rm -rf 
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

sudo sysctl --system

echo Download containerd
# sudo apt install containerd -y
wget https://github.com/containerd/containerd/releases/download/v1.7.19/containerd-1.7.19-linux-amd64.tar.gz
tar Cxzvf /usr/local containerd-1.7.19-linux-amd64.tar.gz

wget https://raw.githubusercontent.com/containerd/containerd/main/containerd.service
echo Tao thu muc cho containerd service
sudo mkdir -p /usr/local/lib/systemd/system/
sudo mv containerd.service /usr/local/lib/systemd/system/

# cat << EOF | sudo tee containerd.service
# sudo container config default

echo Run containerd
sudo systemctl daemon-reload
sudo systemctl enable --now containerd
sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml
echo -------------------------------------------------
# cat /etc/containerd/config.toml

echo Start install runC
wget https://github.com/opencontainers/runc/releases/download/v1.1.12/runc.amd64
sudo install -m 755 runc.amd64 /usr/local/sbin/runc

echo Start install CNI
wget https://github.com/containernetworking/plugins/releases/download/v1.5.0/cni-plugins-linux-amd64-v1.5.0.tgz
mkdir -p /opt/cni/bin
tar Cxzvf /opt/cni/bin cni-plugins-linux-amd64-v1.5.0.tgz

# cat << EOF | sudo tee /etc/cni/net.d/10-containerd-net.conflist
# {
#   "cniVersion": "1.4.1",
#   "name": "containerd-net",
#   "plugins": [
#     {
#       "type": "bridge",
#       "bridge": "cni0",
#       "isGateway": true,
#       "ipMasq": true,
#       "promiscMode": true,
#       "ipam": {
#         "type": "host-local",
#         "ranges": [
#           [{
#             "subnet": "10.88.0.0/16"
#           }],
#           [{
#             "subnet": "2001:4860:4860::/64"
#           }]
#         ],
#         "routes": [
#           { "dst": "0.0.0.0/0" },
#           { "dst": "::/0" }
#         ]
#       }
#     },
#     {
#       "type": "portmap",
#       "capabilities": {"portMappings": true}
#     }
#   ]
# }
# EOF


echo Start install tools of Kubernetes
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
sudo systemctl enable --now kubelet

sudo snap install helm --classic

echo "Chu y: Cgroups true in config.toml va "

# mkdir -p $HOME/.kube
# sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
# sudo chown $(id -u):$(id -g) $HOME/.kube/config
# export KUBECONFIG=/etc/kubernetes/admin.conf
# kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml
