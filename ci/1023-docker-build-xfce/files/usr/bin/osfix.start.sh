#!/bin/sh

set -x
umask 022
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin
export PATH
cd /
if [ -d /etc/osfix.d/ ]; then
  chmod +x /etc/osfix.d/*.sh
  for i in /etc/osfix.d/*.sh;
  do
    if [ -r $i ]; then
    echo ". $i"
      . $i
    fi
  done
  unset i
fi


