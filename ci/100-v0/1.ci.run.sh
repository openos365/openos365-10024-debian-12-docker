#!/usr/bin/env bash

set -x
export CMD_PATH=$(cd `dirname $0`; pwd)
cd $CMD_PATH

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

# echo "openos365" > files/root/etc/hostname

docker build . -f Dockerfile \
--progress plain \
-t ghcr.io/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:$GITHUB_RUN_NUMBER \
-t ghcr.io/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:latest \
-t ${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:$GITHUB_RUN_NUMBER \
-t ${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:latest \
-t hkccr.ccs.tencentyun.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:$GITHUB_RUN_NUMBER \
-t hkccr.ccs.tencentyun.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:latest \
-t registry.cn-hangzhou.aliyuncs.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:$GITHUB_RUN_NUMBER \
-t registry.cn-hangzhou.aliyuncs.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:latest


# docker push ghcr.io/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:$GITHUB_RUN_NUMBER
# docker push ghcr.io/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:latest
docker push registry.cn-hangzhou.aliyuncs.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:$GITHUB_RUN_NUMBER
docker push registry.cn-hangzhou.aliyuncs.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:latest
# docker push hkccr.ccs.tencentyun.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:$GITHUB_RUN_NUMBER 
# docker push hkccr.ccs.tencentyun.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:latest 
docker push ${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:$GITHUB_RUN_NUMBER
docker push ${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:latest

docker run ${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:latest apt list --installed > apt.list.installed.txt
docker run ${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:latest apt list > apt.list.txt

echo "============================================================================"
