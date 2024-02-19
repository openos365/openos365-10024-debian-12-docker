#!/usr/bin/env bash
set -x

export CMD_PATH=$(cd `dirname $0`; pwd)
export PROJECT_NAME="${CMD_PATH##*/}"
export TERM=xterm-256color
echo $PROJECT_NAME
cd $CMD_PATH
env
whoami
pwd
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
df -h


