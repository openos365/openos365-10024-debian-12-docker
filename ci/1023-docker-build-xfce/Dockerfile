FROM openos365/openos365-10001-anolisos-7-docker-main-root:latest

# 1
COPY files/ /tmp/files/

# 2
WORKDIR /root
ENV HOME=/root
RUN /tmp/files/install.sh

# 3
RUN rm -rf /tmp/files/

