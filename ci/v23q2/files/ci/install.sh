#!/usr/bin/env bash

set -x
export CMD_PATH=$(cd `dirname $0`; pwd)
export PROJECT_NAME="${CMD_PATH##*/}"
echo $PROJECT_NAME
cd $CMD_PATH

# TODO HERE

apt update -y
apt upgrade -y

apt -y install zstd
apt -y install --no-install-recommends linux-image-amd64
apt -y install --no-install-recommends systemd-sysv 
apt -y install --no-install-recommends network-manager 
apt -y install --no-install-recommends live-boot
apt -y install --no-install-recommends grub2

echo "root:root" | chpasswd

update_install_remove_clean v23q1 remove

