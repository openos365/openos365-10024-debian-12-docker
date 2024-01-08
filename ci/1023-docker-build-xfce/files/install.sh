#!/usr/bin/env bash

set -x
export CMD_PATH=$(cd `dirname $0`; pwd)
export PROJECT_NAME="${CMD_PATH##*/}"
echo $PROJECT_NAME
cd $CMD_PATH

echo "============================================================================"
pwd

echo "============================================================================"
whoami

echo "============================================================================"
env

echo "============================================================================"
# TODO HERE
apt install -y task-xfce-desktop
echo "debian-live" > /etc/hostname

apt-get update -y
apt autoremove -y
apt install locales -y 
apt install locales-all -y 
apt install -y fonts-wqy-microhei
apt install -y fonts-wqy-zenhei 
apt install -y xfonts-intl-chinese

apt install debconf-utils -y
debconf-set-selections <<< "firmware-ipw2x00 firmware-ipw2x00/license/accepted	boolean	true"
debconf-set-selections <<< "firmware-ivtv firmware-ivtv/license/accepted	boolean	true"
debconf-set-selections <<< "keyboard-configuration keyboard-configuration/layoutcode	string	us"
debconf-set-selections <<< "keyboard-configuration keyboard-configuration/variant	select	English (US)"


apt-get install -y --no-install-recommends linux-image-amd64 live-boot systemd-sysv

apt-get install -y --no-install-recommends \
    iwd \
    curl openssh-client \
    openbox xserver-xorg-core xserver-xorg xinit xterm \
    nano vim rsync expect

apt install xfce4 -y

apt install -y calamares calamares-settings-debian

apt install -y fcitx5
apt install -y fcitx5-chinese-addons

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
apt install -y  docker-compose 
apt install -y  golang
apt install -y  maven
apt install -y  tree
apt install -y extlinux
apt install -y kpartx
apt install -y p7zip-full grub2-common mtools xorriso squashfs-tools-ng jq
apt install -y cloud-utils
systemctl enable docker

apt-get install -y wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list
rm -f packages.microsoft.gpg
apt install -y apt-transport-https
apt update -y
apt install -y code 


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



echo "============================================================================"
