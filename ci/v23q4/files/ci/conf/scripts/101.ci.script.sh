#!/usr/bin/env bash
set -x
export CMD_PATH=$(cd `dirname $0`; pwd)
export TERM=xterm-256color
cd $CMD_PATH
date
# pip install selenium-wire --break-system-packages
# pip install scrapeops-scrapy --break-system-packages
# pip install scrapeops-scrapy-proxy-sdk --break-system-packages