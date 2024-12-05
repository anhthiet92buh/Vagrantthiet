# ssh-keygen -f "/root/.ssh/known_hosts" -R "192.168.1.191"
# ssh-keygen -f "/root/.ssh/known_hosts" -R "192.168.1.192"
# ssh-keygen -f "/root/.ssh/known_hosts" -R "192.168.1.193"

scp -r ./kmaster/kmaster1.sh $m1:/home/kmaster1/
scp -r ./kmaster/finishkmaster1.sh $m1:/home/kmaster1/
scp -r ./postgresql-ha/* $m1:/home/kmaster1/
scp -r /home/thiet/Desktop/thpostgresql-ha/* $m1:/home/kmaster1/postgresql-ha/
scp -r /home/thiet/Desktop/postgresql-ha/* $m1:/home/kmaster1/postgresql-ha2/
scp -r ./phoenix/* $m1:/home/kmaster1/

scp -r ./kmaster/finishkmaster2.sh $m2:/home/kmaster2/
scp -r ./kmaster/finishkmaster3.sh $m3:/home/kmaster3/

scp -r ./loadbalancer.sh $lb1:/home/$nlb1/
scp -r ./loadbalancer.sh $lb2:/home/$nlb2/


