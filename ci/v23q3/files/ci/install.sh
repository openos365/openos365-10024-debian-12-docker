#!/usr/bin/env bash

set -x
export CMD_PATH=$(cd `dirname $0`; pwd)
export PROJECT_NAME="${CMD_PATH##*/}"
echo $PROJECT_NAME
cd $CMD_PATH
export DEBIAN_FRONTEND="noninteractive"

echo "============================================================================"
pwd

echo "============================================================================"
whoami

echo "============================================================================"
env

echo "============================================================================"
# TODO HERE
cd $CMD_PATH
ls -al

apt update -y
apt upgrade -y

apt install -y task-xfce-desktop
apt -y install --no-install-recommends calamares calamares-settings-debian
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

debconf-set-selections <<< "console-setup	console-setup/charmap47	select	UTF-8"
debconf-set-selections <<< "console-setup	console-setup/codeset47	select	Guess optimal character set"
debconf-set-selections <<< "console-setup	console-setup/codesetcode	string	guess"
debconf-set-selections <<< "console-setup	console-setup/fontface47	select	Fixed"
debconf-set-selections <<< "console-setup	console-setup/fontsize	string	8x16"
debconf-set-selections <<< "console-setup	console-setup/fontsize-fb47	select	8x16"
debconf-set-selections <<< "console-setup	console-setup/fontsize-text47	select	8x16"
debconf-set-selections <<< "console-setup	console-setup/store_defaults_in_debconf_db	boolean	true"



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

function update_clean()
{
	apt update -y
	apt upgrade -y
	apt autoremove -y
	apt clean
	apt-get autoremove -y 
	apt-get clean 
	rm -rf \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/tmp/* \
        /var/log/* \
        /root/.cache
}
systemctl enable osfix

update_clean
mkdir -p /etc/buildinfo/v23q3/
cd /etc/buildinfo/v23q3/

date > /build_date.txt
apt list --installed > apt.list.installed.txt
apt list > /apt.list.txt
df -h > df.txt


echo "============================================================================"
