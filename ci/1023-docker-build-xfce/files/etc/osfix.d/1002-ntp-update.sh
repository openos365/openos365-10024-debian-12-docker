#!/usr/bin/env bash

which ntpdate > /dev/null
if [ $? = 1 ];then
	if [ -f "/etc/redhat-release" ];then
		yum install -y ntpdate
	else
		apt-get install -y ntpdate
	fi
fi
echo "|-正在尝试从cn.pool.ntp.org同步时间..";
ntpdate -u cn.pool.ntp.org
if [ $? = 1 ];then
	echo "|-正在尝试从0.pool.ntp.org同步时间..";
	ntpdate -u 0.pool.ntp.org
fi
if [ $? = 1 ];then
	echo "|-正在尝试从2.pool.ntp.org同步时间..";
	ntpdate -u 2.pool.ntp.org
fi
if [ $? = 1 ];then
	echo "|-正在尝试从www.bt.cn同步时间..";
	getBtTime=$(curl -sS --connect-timeout 3 -m 60 http://www.bt.cn/api/index/get_time)
	if [ "${getBtTime}" ];then	
		date -s "$(date -d @$getBtTime +"%Y-%m-%d %H:%M:%S")"
	fi
fi
echo "|-正在尝试将当前系统时间写入硬件..";
hwclock -w
date
echo "|-时间同步完成!";
