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


git config --global user.email "gnuhub@gmail.com"
git config --global user.name "gnuhub"

git remote -v
git remote set-url origin git@github.com:${GITHUB_REPOSITORY}.git
git remote -v

ssh-keygen -f "$HOME/.ssh/known_hosts" -R "frs.sourceforge.net"
ssh-keyscan "frs.sourceforge.net" >> $HOME/.ssh/known_hosts
ssh-keygen -f "$HOME/.ssh/known_hosts" -R "github.com"
ssh-keyscan "github.com" >> $HOME/.ssh/known_hosts
cat $HOME/.ssh/known_hosts

cd $CMD_PATH

docker build . -f Dockerfile \
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
# docker push registry.cn-hangzhou.aliyuncs.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:$GITHUB_RUN_NUMBER
# docker push registry.cn-hangzhou.aliyuncs.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:latest
# docker push hkccr.ccs.tencentyun.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:$GITHUB_RUN_NUMBER 
# docker push hkccr.ccs.tencentyun.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:latest 
docker push ${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:$GITHUB_RUN_NUMBER
docker push ${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:latest
cd $CMD_PATH

cid=$(docker run -it --detach ${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:$GITHUB_RUN_NUMBER)

git pull origin HEAD
rm -rf versions
rm -rf yum.repos.d
docker cp ${cid}:/root/versions/ ./versions/
docker cp ${cid}:/etc/yum.repos.d/ ./yum.repos.d/
cd $CMD_PATH
git add .
git commit -a -m "CI-BOT:$(date +%Y.%m.%d-%H%M%S)-$GITHUB_REF_NAME-$GITHUB_RUN_NUMBER"
git push origin HEAD


echo "============================================================================"
