#!/bin/bash
cd /home/thiet/VirtualBox\ VMs/
VBoxManage createvm --name=kmaster1 --ostype=Ubuntu23_64 --register
# VBoxManage showvminfo kmaster1
VBoxManage modifyvm kmaster1 --cpus 6 --memory 4096
# cd kmaster1
VBoxManage createmedium --filename kmaster1 --size 40960
VBoxManage storagectl kmaster1 --name "SATA Controller" --add sata --controller IntelAHCI 
VBoxManage storageattach kmaster1 --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium kmaster1.vdi
VBoxManage storagectl kmaster1 --name "IDE Controller" --add ide
VBoxManage storageattach kmaster1 --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium /home/thiet/Downloads/ubuntu-23.04-live-server-amd64.iso
VBoxHeadless -s kmaster1