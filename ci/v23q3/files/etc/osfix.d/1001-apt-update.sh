#!/bin/sh

set -x
umask 022
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin
export PATH

cd /etc/apt/
cp -fv sources.list.2 sources.list
apt update -y


