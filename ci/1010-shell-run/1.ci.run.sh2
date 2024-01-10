#!/usr/bin/env bash

set -x
export CMD_PATH=$(cd `dirname $0`; pwd)
export PROJECT_NAME="${CMD_PATH##*/}"
echo $PROJECT_NAME
cd $CMD_PATH

echo "============================================================================"
# TODO HERE
sudo df -h
sudo rm -rf /usr/local/lib/android # will release about 10 GB if you don't need Android
sudo rm -rf /usr/share/dotnet # will release about 20GB if you don't need .NET

sudo docker image prune --all --force

sudo rm -rf ~/.nvm/
sudo rm -rf ~/.m2/

sleep 5

sudo df -h

# https://github.com/jlumbroso/free-disk-space/blob/main/action.yml
sudo rm -rf /opt/ghc

sudo apt-get remove -y '^dotnet-.*'
sudo apt-get remove -y '^llvm-.*'
sudo apt-get remove -y 'php.*'
sudo apt-get remove -y '^mongodb-.*'
sudo apt-get remove -y '^mysql-.*'
sudo apt-get remove -y azure-cli google-cloud-sdk google-chrome-stable firefox powershell mono-devel libgl1-mesa-dri
sudo apt-get autoremove -y
sudo apt-get clean
echo "$AGENT_TOOLSDIRECTORY"
sudo rm -rf "$AGENT_TOOLSDIRECTORY"

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
