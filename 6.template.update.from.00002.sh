#!/usr/bin/env bash

set -x
export CMD_PATH=$PWD
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
cd ~
if [ ! -d openos365-00002-ci-github-actions-template ];then
    git clone https://ghproxy.com/github.com/openos365/openos365-00002-ci-github-actions-template.git
fi

cd openos365-00002-ci-github-actions-template
if [ -z $1 ];then
    git pull origin main
fi

rsync -avzP \
--exclude=".git" \
--exclude="8.workflows.to.run.repos.txt" \
--exclude="README.md" \
~/openos365-00002-ci-github-actions-template/ \
$CMD_PATH/

echo "============================================================================"
