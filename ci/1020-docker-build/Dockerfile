FROM scratch

ADD rootfs.tar /
# 1
COPY files/ /tmp/files/

# 2
WORKDIR /root
ENV HOME=/root
RUN /tmp/files/install.sh

# 3
RUN rm -rf /tmp/files/
