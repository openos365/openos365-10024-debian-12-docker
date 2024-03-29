#!/usr/bin/env bash
set -x
export CMD_PATH=$(cd `dirname $0`; pwd)
export TERM=xterm-256color
cd $CMD_PATH
date

curl -SL https://github.com/docker/compose/releases/download/v2.24.5/docker-compose-linux-x86_64 -o /usr/bin/docker-compose

function jabba_install()
{
  export HOME=/root
  export USER=root
  export JABBA_VERSION=0.11.2
  export JABBA_INDEX=https://github.com/typelevel/jdk-index/raw/main/index.json
  curl -sL https://github.com/shyiko/jabba/raw/master/install.sh | bash 
  . /root/.jabba/jabba.sh
  for p_name in `jabba ls-remote`
  do
  	echo $p_name
       jabba install $p_name
  done
	rsync -avzP /root/.jabba/ /etc/skel/.jabba/
}
jabba_install

function go_install()
{
apt install golang -y
curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer | bash
source /root/.gvm/scripts/gvm


git clone https://github.com/cooperspencer/gickup.git
#export go_version=$(cat gickup/.github/workflows/go.yml | yq -y .jobs.build.steps[1].with | cut -d ":" -f 2 | tr -d " ")
export go_version=$(cat gickup/.github/workflows/go.yml | grep "go-version" | cut -d ":" -f 2 | tr -d " ")

gvm install go$go_version
gvm use go$go_version

cd gickup
go build .
cp -fv ./gickup /usr/bin/gickup
which gickup
gickup --help

rsync -avzP /root/.gvm/ /etc/skel/.gvm/
}

go_install

function nvm_install()
{
cd ~
git clone https://github.com/nvm-sh/nvm.git .nvm
cd .nvm
git checkout v0.39.5

cd ~
. ~/.nvm/nvm.sh

for node_version in "v14.21.3" "v16.20.2" "v18.18.0" "v20.8.0"
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

md_server_install()
{
	groupadd www
 	useradd -m -d /home/www -G sudo -g www www -s /bin/bash
	echo "www:act365" | chpasswd
	# https://github.com/DDS-Derek/mdserver-web-Docker/tree/master
 	# 1
	curl --insecure -fsSL https://cdn.jsdelivr.net/gh/midoks/mdserver-web@latest/scripts/install.sh | bash
 
	# 2
	cd /www/server/mdserver-web/plugins/openresty
	bash install.sh install 1.21.4.3
 
 	# 3
	cd /www/server/mdserver-web/plugins/php
	bash install.sh install 74
 
	# 4
	cd /www/server/mdserver-web/plugins/mysql
	bash install.sh install 5.7
 
	# 5
	cd /www/server/mdserver-web/plugins/phpmyadmin 
	bash install.sh install 5.2.0
}

md_server_install

curl -LO https://storage.googleapis.com/container-diff/latest/container-diff-linux-amd64
install container-diff-linux-amd64 /usr/bin/container-diff
rm -rf container-diff-linux-amd64

export DIVE_VERSION=$(curl -sL "https://api.github.com/repos/wagoodman/dive/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
curl -OL https://github.com/wagoodman/dive/releases/download/v${DIVE_VERSION}/dive_${DIVE_VERSION}_linux_amd64.deb
apt install ./dive_${DIVE_VERSION}_linux_amd64.deb
  
function code_server_install()
{

  
  curl -fsSL https://code-server.dev/install.sh | sh
  
  systemctl enable code-server@root

}
code_server_install

# https://github.com/cli/cli/blob/trunk/docs/install_linux.md
type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y

cd ~/
git clone https://github.com/gnuhub/connect-proxy.git
cd connect-proxy
gcc connect.c -o connect -lssl -lcrypto

rsync -avP ./connect /usr/bin/connect
chmod +x /usr/bin/connect
cd ~/
rm -rf connect-proxy

export OSH="/etc/skel/.oh-my-bash"; bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" --unattended

# https://pve.proxmox.com/wiki/Install_Proxmox_VE_on_Debian_12_Bookworm
# wget https://mirrors.ustc.edu.cn/proxmox/debian/proxmox-release-bookworm.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-bookworm.gpg
# echo "deb [arch=amd64] https://mirrors.ustc.edu.cn/proxmox/debian/pve/ bookworm pve-no-subscription" > /etc/apt/sources.list.d/pve-install-repo.list
# apt update -y
# apt upgrade -y


wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list
rm -f packages.microsoft.gpg
apt update -y
apt install -y code 
rm -rf /etc/apt/sources.list.d/vscode.list


# pip3 install git+https://github.com/tomquirk/linkedin-api.git --break-system-packages

cd /opt/
wget https://gitea.elara.ws/lure/lure/releases/download/v0.1.3/linux-user-repository-0.1.3-linux-x86_64.deb
dpkg -i linux-user-repository-0.1.3-linux-x86_64.deb
rm -rf linux-user-repository-0.1.3-linux-x86_64.deb


cd /etc/skel

mkdir actions-runner
cd actions-runner
# curl -o actions-runner-linux-x64-2.313.0.tar.gz -L https://mirror.ghproxy.com/github.com/actions/runner/releases/download/v2.313.0/actions-runner-linux-x64-2.313.0.tar.gz
curl -o actions-runner-linux-x64-2.313.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.313.0/actions-runner-linux-x64-2.313.0.tar.gz
tar xzf ./actions-runner-linux-x64-2.313.0.tar.gz
rm -rf actions-runner-linux-x64-2.313.0.tar.gz

ls -al

cd /opt/
wget https://dldir1.qq.com/qqfile/qq/QQNT/852276c1/linuxqq_3.2.5-21453_amd64.deb
apt install -y ./linuxqq_3.2.5-21453_amd64.deb
rm -rf linuxqq_3.2.5-21453_amd64.deb

curl -L --output /usr/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64
chmod +x /usr/bin/gitlab-runner


# https://www.influxdata.com/downloads/
# influxdata-archive_compat.key GPG fingerprint:
#     9D53 9D90 D332 8DC7 D6C8 D3B9 D8FF 8E1F 7DF8 B07E
wget -q https://repos.influxdata.com/influxdata-archive_compat.key
echo '393e8779c89ac8d958f81f942f9ad7fb82a25e133faddaf92e15b16e6ac9ce4c influxdata-archive_compat.key' | sha256sum -c && cat influxdata-archive_compat.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg > /dev/null
echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg] https://repos.influxdata.com/debian stable main' | tee /etc/apt/sources.list.d/influxdata.list

apt-get update -y
apt-get install influxdb2 -y
apt-get install telegraf -y

rm -rf /etc/apt/sources.list.d/influxdata.list

apt update -y
apt upgrade -y

systemctl enable influxdb2
systemctl enable telegraf

curl https://dl.gitea.com/act_runner/nightly/act_runner-nightly-linux-amd64 -o /usr/bin/act_runner
chmod +x /usr/bin/act_runner

# dbschema
cd /opt/
wget https://dbschema.com/download/DbSchema_linux_9_5_2.deb
apt install ./DbSchema_linux_9_5_2.deb
rm -rf ./DbSchema_linux_9_5_2.deb


