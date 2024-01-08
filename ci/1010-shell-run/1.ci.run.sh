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

debootstrap \
--arch=amd64 \
--variant=minbase \
--include=zsh \
$distro $rootfsDir $mirror

sudo tar -C chroot -cf ./rootfs.tar .

mv ./rootfs.tar ../1020-docker-build/

echo "============================================================================"
