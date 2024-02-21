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

apt update -y
apt upgrade -y

apt -y install zstd
apt -y install --no-install-recommends linux-image-amd64
apt -y install --no-install-recommends systemd-sysv 
apt -y install --no-install-recommends network-manager 
apt -y install --no-install-recommends live-boot
apt -y install --no-install-recommends calamares calamares-settings-debian
apt -y install --no-install-recommends grub2

echo "root:root" | chpasswd

apt update -y
apt upgrade -y
apt autoremove -y
apt clean -y

mkdir -p /etc/buildinfo/v1/
cd /etc/buildinfo/v1/

date > /build_date.txt
apt list --installed > apt.list.installed.txt
apt list > /apt.list.txt
df -h > df.txt

echo "============================================================================"
