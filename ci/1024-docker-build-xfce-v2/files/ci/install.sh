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
pip install selenium-wire --break-system-packages

apt install chromium-driver  -y
apt install chromium  -y


apt update -y
apt upgrade -y
apt autoremove -y
apt clean -y

cd /opt/
mkdir ruleset
cd ruleset
curl https://raw.githubusercontent.com/Loyalsoldier/clash-rules/release/reject.txt > reject.yaml
curl https://raw.githubusercontent.com/Loyalsoldier/clash-rules/release/icloud.txt > icloud.yaml
curl https://raw.githubusercontent.com/Loyalsoldier/clash-rules/release/apple.txt > apple.yaml
curl https://raw.githubusercontent.com/Loyalsoldier/clash-rules/release/google.txt > google.yaml
curl https://raw.githubusercontent.com/Loyalsoldier/clash-rules/release/proxy.txt > proxy.yaml
curl https://raw.githubusercontent.com/Loyalsoldier/clash-rules/release/direct.txt > direct.yaml
curl https://raw.githubusercontent.com/Loyalsoldier/clash-rules/release/private.txt > private.yaml
curl https://raw.githubusercontent.com/Loyalsoldier/clash-rules/release/gfw.txt > gfw.yaml 
curl https://raw.githubusercontent.com/Loyalsoldier/clash-rules/release/greatfire.txt > greatfire.yaml
curl https://raw.githubusercontent.com/Loyalsoldier/clash-rules/release/tld-not-cn.txt > tld-not-cn.yaml
curl https://raw.githubusercontent.com/Loyalsoldier/clash-rules/release/telegramcidr.txt > telegramcidr.yaml
curl https://raw.githubusercontent.com/Loyalsoldier/clash-rules/release/cncidr.txt > cncidr.yaml
curl https://raw.githubusercontent.com/Loyalsoldier/clash-rules/release/lancidr.txt > lancidr.yaml
curl https://raw.githubusercontent.com/Loyalsoldier/clash-rules/release/applications.txt > applications.yaml

curl https://raw.githubusercontent.com/vxiaov/free_proxy_ss/main/clash/clash.provider.yaml > 1.learnhard-cn.yaml
curl https://raw.githubusercontent.com/ermaozi01/free_clash_vpn/main/subscribe/clash.yml > 7.ermaozi01.yml
curl https://raw.githubusercontent.com/e-miao/freeClash/main/proxies.yaml > 7.e-miao.yml
curl https://raw.githubusercontent.com/anaer/Sub/main/clash.yaml > 9.anaer.yaml
curl https://raw.githubusercontent.com/ermaozi/get_subscribe/main/subscribe/clash.yml > 11.ermaozi.yaml



echo "============================================================================"
