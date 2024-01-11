#!/usr/bin/env bash

set -x
export CMD_PATH=$(cd `dirname $0`; pwd)
export PROJECT_NAME="${CMD_PATH##*/}"
echo $PROJECT_NAME
cd $CMD_PATH

echo "============================================================================"
# TODO HERE
cd ~
wget https://mirrors.ustc.edu.cn/debian/pool/main/d/debian-archive-keyring/debian-archive-keyring_2023.4_all.deb
sudo dpkg -i debian-archive-keyring_2023.4_all.deb
cd $CMD_PATH

date
sudo apt install debootstrap -y
distro=bookworm
mirror=http://mirrors.ustc.edu.cn/debian/

rootfsDir=chroot
debootstrap=debootstrap

if [  -d $rootfsDir ];then
    rm -rf $rootfsDir
fi

sudo debootstrap \
--arch=amd64 \
--include=zsh,locales,locales-all,rsync \
--components=main,contrib,non-free,non-free-firmware \
--variant=minbase \
$distro $rootfsDir $mirror

sudo tar -C chroot -cf ./rootfs.tar .

mv ./rootfs.tar ../1020-docker-build/

echo "============================================================================"
