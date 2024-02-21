FROM openos365/openos365-10024-debian-12-docker-v23q2:latest

# 1
ADD files/ /

# 2
WORKDIR /root
ENV HOME=/root
RUN /ci/install.sh

# 3
RUN rm -rf /ci/