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


function nvm_install()
{
cd ~
git clone https://github.com/nvm-sh/nvm.git .nvm
cd .nvm
git checkout v0.39.5

cd ~
. ~/.nvm/nvm.sh

for node_version in "v14.21.3"
do
  nvm install $node_version
  nvm use $node_version
  npm install yarn -g
  npm install pnpm -g
  yarn global add prettier
done

nvm use v14.21.3
npm install meteor -g --unsafe-perm

export PATH=$HOME/.meteor:$PATH
echo $PATH
which node
node --version

rsync -avzP /root/.nvm/ /etc/skel/.nvm/
}

nvm_install

apt install caddy -y

apt autoremove -y

apt remove --purge -y $(dpkg -l | grep linux-image | awk '{print $2}')
dpkg -l | grep linux-image | awk '{print $2}'
apt update -y
apt upgrade -y
apt -y install --no-install-recommends linux-image-amd64

echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

mkdir -p /etc/sudoers.d
echo "www ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/www-nopassword
echo "runner ALL=(ALL) NOPASSWD: ALL"   > /etc/sudoers.d/runner-nopassword
chmod 750 /etc/sudoers.d/www-nopassword
chmod 750 /etc/sudoers.d/runner-nopassword
chmod 750 /etc/sudoers.d/
cat /etc/passwd

apt install build-essential libjpeg-dev libpng-dev libtiff-dev -y
apt install python3 -y
apt install python3-pip -y
apt install python3-selenium -y
apt install python3-pymongo -y
apt install python3-redis -y

apt install -y ethtool
apt install -y python3-scrapy

pip install selenium-wire --break-system-packages
pip install scrapeops-scrapy --break-system-packages
pip install scrapeops-scrapy-proxy-sdk --break-system-packages


apt install chromium-driver  -y
apt install chromium  -y


apt update -y
apt upgrade -y
apt autoremove -y
apt clean -y

cd /opt/
wget https://gitea.elara.ws/lure/lure/releases/download/v0.1.3/linux-user-repository-0.1.3-linux-x86_64.deb
dpkg -i linux-user-repository-0.1.3-linux-x86_64.deb
rm -rf linux-user-repository-0.1.3-linux-x86_64.deb



echo "============================================================================"
