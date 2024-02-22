#!/usr/bin/env bash

set -x
export CMD_PATH=$(cd `dirname $0`; pwd)
cd $CMD_PATH

sudo df -h
sudo rm -rf /usr/local/lib/android # will release about 10 GB if you don't need Android
sudo rm -rf /usr/share/dotnet # will release about 20GB if you don't need .NET
# https://github.com/jlumbroso/free-disk-space/blob/main/action.yml
sudo rm -rf /opt/ghc
sudo rm -rf /usr/local/.ghcup || true
sudo rm -rf ~/.nvm/
sudo rm -rf ~/.m2/
rm -rf ~/.nvm/
rm -rf ~/.m2/
sudo apt-get remove -y '^aspnetcore-.*' || echo "::warning::The command [sudo apt-get remove -y '^aspnetcore-.*'] failed to complete successfully. Proceeding..."
sudo apt-get remove -y '^dotnet-.*' --fix-missing || echo "::warning::The command [sudo apt-get remove -y '^dotnet-.*' --fix-missing] failed to complete successfully. Proceeding..."
sudo apt-get remove -y '^llvm-.*' --fix-missing || echo "::warning::The command [sudo apt-get remove -y '^llvm-.*' --fix-missing] failed to complete successfully. Proceeding..."
sudo apt-get remove -y 'php.*' --fix-missing || echo "::warning::The command [sudo apt-get remove -y 'php.*' --fix-missing] failed to complete successfully. Proceeding..."
sudo apt-get remove -y '^mongodb-.*' --fix-missing || echo "::warning::The command [sudo apt-get remove -y '^mongodb-.*' --fix-missing] failed to complete successfully. Proceeding..."
sudo apt-get remove -y '^mysql-.*' --fix-missing || echo "::warning::The command [sudo apt-get remove -y '^mysql-.*' --fix-missing] failed to complete successfully. Proceeding..."
sudo apt-get remove -y azure-cli google-chrome-stable firefox powershell mono-devel libgl1-mesa-dri --fix-missing || echo "::warning::The command [sudo apt-get remove -y azure-cli google-chrome-stable firefox powershell mono-devel libgl1-mesa-dri --fix-missing] failed to complete successfully. Proceeding..."
sudo apt-get remove -y google-cloud-sdk --fix-missing || echo "::debug::The command [sudo apt-get remove -y google-cloud-sdk --fix-missing] failed to complete successfully. Proceeding..."
sudo apt-get remove -y google-cloud-cli --fix-missing || echo "::debug::The command [sudo apt-get remove -y google-cloud-cli --fix-missing] failed to complete successfully. Proceeding..."
sudo apt-get autoremove -y || echo "::warning::The command [sudo apt-get autoremove -y] failed to complete successfully. Proceeding..."
sudo apt-get clean || echo "::warning::The command [sudo apt-get clean] failed to complete successfully. Proceeding..."
sudo apt-get remove -y '^firefox-.*'
sudo apt-get remove -y '^chrom.*'
sudo rm -rf /home/linuxbrew/.linuxbrew/
sudo docker image prune --all --force

sudo rm -rf /opt/hostedtoolcache/CodeQL

sudo swapoff -a || true
sudo rm -f /mnt/swapfile || true
free -h

echo "$AGENT_TOOLSDIRECTORY"
sudo rm -rf "$AGENT_TOOLSDIRECTORY"
apt clean

sudo df -h

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

echo "============================================================================"
