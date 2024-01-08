#!/usr/bin/env bash

set -x
export CMD_PATH=$(cd `dirname $0`; pwd)
export PROJECT_NAME="${CMD_PATH##*/}"
echo $PROJECT_NAME
cd $CMD_PATH

echo "============================================================================"
# TODO HERE

date
sudo apt install debootstrap -y
distro=bookworm
mirror=https://mirrors.tuna.tsinghua.edu.cn/debian/

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
