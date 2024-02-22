#!/usr/bin/env bash

set -x
export CMD_PATH=$(cd `dirname $0`; pwd)
export PROJECT_NAME="${CMD_PATH##*/}"
echo $PROJECT_NAME
cd $CMD_PATH
ls -al
apt update -y
apt upgrade -y

function pkg_install_remove()
{
	cd $CMD_PATH
	while read pkg
	do
  		echo $pkg
  		apt install -y --no-install-recommends $pkg
	done < packages.list.txt

	while read pkg
	do
 		echo $pkg
  		apt install -y $pkg
	done < remove.list.txt
}
pkg_install_remove

apt install -y exfatprogs
apt install -y debootstrap 
apt install -y squashfs-tools
apt install -y xorriso
apt install -y isolinux
apt install -y syslinux-efi
apt install -y grub-pc-bin
apt install -y grub-efi-amd64-bin
apt install -y grub-efi-ia32-bin
apt install -y mtools
apt install -y dosfstools
apt install -y rsync 
apt install -y qemu-system-x86
apt install -y docker.io 
# apt install -y docker-compose 
# curl -SL https://github.com/docker/compose/releases/download/v2.24.5/docker-compose-linux-x86_64 -o /usr/bin/docker-compose
apt install -y golang
apt install -y maven
apt install -y tree
apt install -y extlinux
apt install -y kpartx
apt install -y p7zip-full grub2-common mtools xorriso squashfs-tools-ng jq
apt install -y cloud-utils
apt install -y deepin-terminal
apt install -y caddy
apt install -y repo
apt install -y ostree
apt install -y wget 
apt install -y gpg
apt install -y adb
apt install -y fastboot
apt install -y ruby
apt install -y net-tools
apt install -y ssh
apt install -y ntpdate
systemctl enable docker
systemctl enable ssh



apt install caddy -y

apt autoremove -y

apt remove --purge -y $(dpkg -l | grep linux-image | awk '{print $2}')
dpkg -l | grep linux-image | awk '{print $2}'
apt update -y
apt upgrade -y
apt -y install --no-install-recommends linux-image-amd64

echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

mkdir -p /etc/sudoers.d
echo "www ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/www-nopassword
echo "runner ALL=(ALL) NOPASSWD: ALL"   > /etc/sudoers.d/runner-nopassword
chmod 750 /etc/sudoers.d/www-nopassword
chmod 750 /etc/sudoers.d/runner-nopassword
chmod 750 /etc/sudoers.d/
cat /etc/passwd



pip install selenium-wire --break-system-packages
pip install scrapeops-scrapy --break-system-packages
pip install scrapeops-scrapy-proxy-sdk --break-system-packages



apt install chromium-driver  -y
apt install chromium  -y


apt update -y
apt upgrade -y
apt autoremove -y
apt clean -y

# https://blog.csdn.net/qq_21891743/article/details/132818491
apt install -y sysbench
sysbench --version


update_install_remove_clean v23q4 remove

