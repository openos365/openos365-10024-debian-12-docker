#!/usr/bin/env bash
set -x
export CMD_PATH=$(cd `dirname $0`; pwd)
export TERM=xterm-256color
cd $CMD_PATH
date
echo "root:act365" | chpasswd
cd /opt
wget https://cdn-package-store6.deepin.com/appstore/pool/appstore/c/com.xunlei.download/com.xunlei.download_1.0.0.2_amd64.deb
apt install -y com.xunlei.download_1.0.0.2_amd64.deb
rm -rf com.xunlei.download_1.0.0.2_amd64.deb
date
