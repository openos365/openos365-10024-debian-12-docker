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
docker pull egistry.cn-hangzhou.aliyuncs.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME-xfce-v2:$GITHUB_RUN_NUMBER
docker run -i -v $PWD:/code ${GITHUB_REPOSITORY}-$GITHUB_REF_NAME-root:$GITHUB_RUN_NUMBER /code/2.run.in.docker.sh

echo "============================================================================"
