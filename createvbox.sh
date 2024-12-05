#!/bin/bash
cd ./.vitualbox
VBoxManage createvm --name=kmaster1 --ostype=Ubuntu23_64 --register
# VBoxManage showvminfo kmaster1
VBoxManage modifyvm kmaster1 --cpus 6 --memory 4096 --vram 12
# cd kmaster1
VBoxManage modifyvm kmaster1 --nic1 bridged --bridgeadapter1 vboxnet0
VBoxManage createhd --filename ./.vitualbox/kmaster1.vdi --size 51200 
VBoxManage storagectl kmaster1 --name "SATA Controller" --add sata --bootable on
VBoxManage storageattach kmaster1 --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium ./.vitualbox/kmaster1.vdi
VBoxManage storagectl kmaster1 --name "IDE Controller" --add ide
VBoxManage storageattach kmaster1 --storagectl "IDE Controller" --port 0  --device 0 --type dvddrive #--medium host:/dev/dvd
VBoxManage startvm kmaster1

# VBoxManage createmedium --filename kmaster1 --size 40960
# VBoxManage storagectl kmaster1 --name "SATA Controller" --add sata --controller IntelAHCI 
# VBoxManage storageattach kmaster1 --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium kmaster1.vdi
# VBoxManage storagectl kmaster1 --name "IDE Controller" --add ide
# VBoxManage storageattach kmaster1 --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium /home/thiet/Downloads/ubuntu-23.04-live-server-amd64.iso
# VBoxHeadless -s kmaster1