#!/usr/bin/env bash

set -x
export CMD_PATH=$(cd `dirname $0`; pwd)
export PROJECT_NAME="${CMD_PATH##*/}"
echo $PROJECT_NAME
cd $CMD_PATH

if [ ! -z "${GITHUB_REPOSITORY}" ];then

    # 6
    cd $CMD_PATH
    for ci_dir in `ls -d -1 ci/v* | sort`
    do
        echo $ci_dir
        if [ -f $ci_dir/1.ci.run.sh ];then
            ./${ci_dir}/1.ci.run.sh
        fi
    done

fi

