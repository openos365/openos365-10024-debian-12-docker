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
cd $CMD_PATH
ls -al
apt update -y
apt upgrade -y


mkdir -p /etc/buildinfo/v24q1/
cd /etc/buildinfo/v24q1/

date > /build_date.txt
apt list --installed > apt.list.installed.txt
apt list > /apt.list.txt
df -h > df.txt


echo "============================================================================"
