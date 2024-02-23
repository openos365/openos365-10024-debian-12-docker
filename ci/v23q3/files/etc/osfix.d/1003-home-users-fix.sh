#!/bin/sh

set -x
umask 022
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin
export PATH

echo "root:act365" | chpasswd

cd /home/

for user in `ls`
do
    sudo usermod -aG docker $user
    sudo -u $user rsync -avP /etc/skel/ /home/$user/
    echo "${user}  ALL=(ALL:ALL) NOPASSWD: ALL" | tee -a /etc/sudoers.d/osfix-${user}-nopassword
    sudo -u $user chmod 600 /home/$user/.ssh/id*
    sudo -u $user chmod 600 /home/$user/.ssh/authorized_keys
    sudo -u $user chmod 777 /home/$user/.ssh/known_hosts
done


rsync -avzP /etc/skel/ /root/

chmod 600 /root/.ssh/id*
chmod 600 /root/.ssh/authorized_keys
chmod 777 /root/.ssh/known_hosts
