ssh-keygen -f "/root/.ssh/known_hosts" -R "192.168.1.201"
ssh-keygen -f "/root/.ssh/known_hosts" -R "192.168.1.202"
ssh-keygen -f "/root/.ssh/known_hosts" -R "192.168.1.203"

scp -r ./kmaster/kmaster1.sh root@192.168.1.201:/home/vagrant/
scp -r ./kmaster/finishkmaster1.sh root@192.168.1.201:/home/vagrant/
scp -r ./postgresql-ha/* root@192.168.1.201:/home/vagrant/
scp -r /home/thiet/Desktop/thpostgresql-ha/* root@192.168.1.201:/home/vagrant/postgresql-ha/
scp -r /home/thiet/Desktop/editsql-ha/ root@192.168.1.201:/home/vagrant/
# scp -r /home/thiet/Desktop/editsql-ha/ kmaster1@192.168.1.201:/home/kmaster1/
scp -r ./phoenix/* root@192.168.1.201:/home/vagrant/

scp -r ./kmaster/finishkmaster2.sh root@192.168.1.202:/home/vagrant/
scp -r ./kmaster/finishkmaster3.sh root@192.168.1.203:/home/vagrant/


