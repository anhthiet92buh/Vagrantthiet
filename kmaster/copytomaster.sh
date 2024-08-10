ssh-keygen -f "/root/.ssh/known_hosts" -R "192.168.1.191"
ssh-keygen -f "/root/.ssh/known_hosts" -R "192.168.1.192"
ssh-keygen -f "/root/.ssh/known_hosts" -R "192.168.1.193"

scp -r ./kmaster/kmaster1.sh root@192.168.1.191:/home/vagrant/
scp -r ./kmaster/finishkmaster1.sh root@192.168.1.191:/home/vagrant/
scp -r ./postgresql-ha/* root@192.168.1.191:/home/vagrant/
scp -r /home/thiet/Desktop/postgresql-ha/* root@192.168.1.191:/home/vagrant/postgresql-ha/
scp -r ./phoenix/* root@192.168.1.191:/home/vagrant/

scp -r ./kmaster/finishkmaster2.sh root@192.168.1.192:/home/vagrant/
scp -r ./kmaster/finishkmaster3.sh root@192.168.1.193:/home/vagrant/


