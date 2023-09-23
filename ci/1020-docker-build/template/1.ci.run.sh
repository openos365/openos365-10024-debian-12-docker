#!/usr/bin/env bash

set -x
export CMD_PATH=$(cd `dirname $0`; pwd)
cd $CMD_PATH

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
# docker push registry.cn-hangzhou.aliyuncs.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:$GITHUB_RUN_NUMBER
# docker push registry.cn-hangzhou.aliyuncs.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:latest
# docker push hkccr.ccs.tencentyun.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:$GITHUB_RUN_NUMBER 
# docker push hkccr.ccs.tencentyun.com/${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:latest 
docker push ${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:$GITHUB_RUN_NUMBER
docker push ${GITHUB_REPOSITORY}-$GITHUB_REF_NAME:latest

echo "============================================================================"
