netplan set ethernets.enp0s3.addresses=[192.168.1.205/24]
netplan set ethernets.enp0s3.dhcp4=no
netplan apply