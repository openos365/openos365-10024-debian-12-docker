FROM registry.cn-hangzhou.aliyuncs.com/openos365/openos365-10024-debian-12-docker-main-root:latest

# 1
COPY files/ /tmp/files/

# 2
WORKDIR /root
ENV HOME=/root
RUN /tmp/files/install.sh

# 3
RUN rm -rf /tmp/files/
