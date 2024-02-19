FROM scratch

ADD rootfs.tar /
# 1
ADD files/ /

# 2
WORKDIR /root
ENV HOME=/root
RUN /ci/install.sh

# 3
RUN rm -rf /ci/
