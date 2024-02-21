#!/usr/bin/env bash

set -x
export CMD_PATH=$(cd `dirname $0`; pwd)
export PROJECT_NAME="${CMD_PATH##*/}"
echo $PROJECT_NAME
cd $CMD_PATH
export DEBIAN_FRONTEND="noninteractive"

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

apt install -y task-xfce-desktop
apt install locales -y 
apt install locales-all -y 
apt install -y fonts-wqy-microhei
apt install -y fonts-wqy-zenhei 
apt install -y xfonts-intl-chinese

apt install debconf-utils -y
debconf-set-selections <<< "firmware-ipw2x00 firmware-ipw2x00/license/accepted	boolean	true"
debconf-set-selections <<< "firmware-ivtv firmware-ivtv/license/accepted	boolean	true"
debconf-set-selections <<< "keyboard-configuration keyboard-configuration/layoutcode	string	us"
debconf-set-selections <<< "keyboard-configuration keyboard-configuration/variant	select	English (US)"

debconf-set-selections <<< "console-setup	console-setup/charmap47	select	UTF-8"
debconf-set-selections <<< "console-setup	console-setup/codeset47	select	Guess optimal character set"
debconf-set-selections <<< "console-setup	console-setup/codesetcode	string	guess"
debconf-set-selections <<< "console-setup	console-setup/fontface47	select	Fixed"
debconf-set-selections <<< "console-setup	console-setup/fontsize	string	8x16"
debconf-set-selections <<< "console-setup	console-setup/fontsize-fb47	select	8x16"
debconf-set-selections <<< "console-setup	console-setup/fontsize-text47	select	8x16"
debconf-set-selections <<< "console-setup	console-setup/store_defaults_in_debconf_db	boolean	true"



apt-get install -y --no-install-recommends linux-image-amd64 live-boot systemd-sysv

apt-get install -y --no-install-recommends \
    iwd \
    curl openssh-client \
    openbox xserver-xorg-core xserver-xorg xinit xterm \
    nano vim rsync expect

apt install xfce4 -y

apt install -y calamares calamares-settings-debian

apt install -y fcitx5
apt install -y fcitx5-chinese-addons

apt install -y exfatprogs
apt install -y debootstrap 
apt install -y squashfs-tools
apt install -y xorriso
apt install -y isolinux
apt install -y syslinux-efi
apt install -y grub-pc-bin
apt install -y grub-efi-amd64-bin
apt install -y grub-efi-ia32-bin
apt install -y mtools
apt install -y dosfstools
apt install -y rsync 
apt install -y qemu-system-x86
apt install -y docker.io 
# apt install -y docker-compose 
curl -SL https://github.com/docker/compose/releases/download/v2.24.5/docker-compose-linux-x86_64 -o /usr/bin/docker-compose
apt install -y golang
apt install -y maven
apt install -y tree
apt install -y extlinux
apt install -y kpartx
apt install -y p7zip-full grub2-common mtools xorriso squashfs-tools-ng jq
apt install -y cloud-utils
apt install -y deepin-terminal
apt install -y caddy
apt install -y repo
apt install -y ostree
apt install -y wget 
apt install -y gpg
apt install -y adb
apt install -y fastboot
apt install -y ruby
apt install -y net-tools
apt install -y ssh
apt install -y ntpdate
systemctl enable docker
systemctl enable ssh

export OSH="/etc/skel/.oh-my-bash"; bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" --unattended

# https://pve.proxmox.com/wiki/Install_Proxmox_VE_on_Debian_12_Bookworm
wget https://mirrors.ustc.edu.cn/proxmox/debian/proxmox-release-bookworm.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-bookworm.gpg
echo "deb [arch=amd64] https://mirrors.ustc.edu.cn/proxmox/debian/pve/ bookworm pve-no-subscription" > /etc/apt/sources.list.d/pve-install-repo.list
apt update -y
apt upgrade -y



wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list
rm -f packages.microsoft.gpg
apt install -y apt-transport-https
apt update -y
apt install -y code 


function pkg_install_remove()
{
	cd $CMD_PATH
	while read pkg
	do
  		echo $pkg
  		apt install -y --no-install-recommends $pkg
	done < packages.list.txt

	while read pkg
	do
 		echo $pkg
  		apt install -y $pkg
	done < remove.list.txt
}
pkg_install_remove


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
 
	# 6
	apt-get autoremove -y 
	apt-get clean 
	rm -rf \
	        /tmp/* \
	        /var/lib/apt/lists/* \
	        /var/tmp/* \
	        /var/log/* \
	        /root/.cache
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

apt update -y
apt upgrade -y
apt autoremove -y
apt clean -y

systemctl enable osfix

echo "============================================================================"
