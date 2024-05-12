#!/bin/bash
rm -rf *
sudo apt update && apt upgrade -y
sudo apt install keepalived haproxy -y

echo https://github.com/kubernetes/kubeadm/blob/main/docs/ha-considerations.md#options-for-software-load-balancing

export APISERVER_DEST_PORT=6443
export APISERVER_VIP="192.168.0.100"

# rm -rf /etc/keepalived/check_apiserver.sh
cat >> /etc/keepalived/check_apiserver.sh <<EOF
#!/bin/sh

errorExit() {
    echo "*** $*" 1>&2
    exit 1
}

curl --silent --max-time 2 --insecure https://localhost :${APISERVER_DEST_PORT}/ -o /dev/null || errorExit "Error GET https://localhost:${APISERVER_DEST_PORT}/"
if ip addr | grep -q ${APISERVER_VIP}; then
    curl --silent --max-time 2 --insecure https://${APISERVER_VIP}:${APISERVER_DEST_PORT}/ -o /dev/null || errorExit "Error GET https://${APISERVER_VIP}:${APISERVER_DEST_PORT}/"
fi
EOF

sudo chmod +x /etc/keepalived/check_apiserver.sh

# rm -rf /etc/keepalived/keepalived.conf
cat >> /etc/keepalived/keepalived.conf <<EOF
vrrp_script check_apiserver {
    script "/etc/keepalived/check_apiserver.sh"
    interval 3
    timeout 10
    fall 5
    rise 2
    weight -2
}
# chu y thay doi MASTER va BACKUP
vrrp_instance VI_1 {
    state MASTER 
    interface eth1
    virtual_router_id 1
    priority 100
    advert_int 5
    authentication {
        auth_type PASS
        auth_pass mysecret
    }
    virtual_ipaddress {
        192.168.0.100
    }
    track_script {
        check_apiserver
    }
}
EOF

systemctl enable --now keepalived

# rm -rf /etc/haproxy/haproxy.cfg 
cat >> /etc/haproxy/haproxy.cfg <<EOF

frontend kubernetes-frontend
    bind *:6443
    mode tcp
    option tcplog
    default_backend kubernetes-backend

backend kubernetes-backend
    option httpchk GET /healthz
    http-check expect status 200
    mode tcp
    option ssl-hello-chk
    balance roundrobin
        server kmaster1 192.168.0.11.:6443 check fall 3 rise 2
        server kmaster2 192.168.0.12.:6443 check fall 3 rise 2
        server kmaster3 192.168.0.13.:6443 check fall 3 rise 2

EOF

systemctl enable haproxy && systemctl restart haproxy
swapoff -a; sed -i '/swap/d' /etc/fstab
systemctl disable --now ufw

# rm -rf /etc/modules-load.d/containerd.conf
cat >> /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF
modprobe overlay
modprobe br_netfilter

# rm -rf /etc/sysctl.d/kubernetes.conf
cat >>/etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
EOF

sysctl --system

echo Download containerd
# sudo apt install containerd -y
rm -rf *
sudo apt install -y apt-transport-https
wget https://github.com/containerd/containerd/releases/download/v1.7.14/containerd-1.7.14-linux-amd64.tar.gz
tar Cxzvf /usr/local containerd-1.7.14-linux-amd64.tar.gz

# wget https://raw.githubusercontent.com/containerd/containerd/main/containerd.service
# echo Tao thu muc cho containerd service
# sudo mkdir -p /usr/local/lib/systemd/system/
# sudo mv containerd.service /usr/local/lib/systemd/system/

echo Run containerd
sudo systemctl daemon-reload
sudo systemctl enable --now containerd
sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml

echo Start install tools of Kubernetes
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
sudo systemctl enable --now kubelet
