#!/usr/bin/env bash

set -x
export CMD_PATH=$(cd `dirname $0`; pwd)
export PROJECT_NAME="${CMD_PATH##*/}"
echo $PROJECT_NAME
cd $CMD_PATH
export DEBIAN_FRONTEND="noninteractive"

cd $CMD_PATH
update_install_remove_clean v23q3 remove

