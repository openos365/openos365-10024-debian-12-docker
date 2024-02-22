#!/usr/bin/env bash

set -x
export CMD_PATH=$(cd `dirname $0`; pwd)
export PROJECT_NAME="${CMD_PATH##*/}"
echo $PROJECT_NAME
cd $CMD_PATH
export DEBIAN_FRONTEND="noninteractive"


# TODO HERE
cd $CMD_PATH

function my_debconf_set_selections()
{
	cd $CMD_PATH
	while read conf
	do
  		echo $conf_str
  		debconf-set-selections <<< "$conf_str"
	done < debconf.txt
}

function my_pkg_install_remove()
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

update_clean
my_debconf_set_selections
my_pkg_install_remove
update_clean v23q3

