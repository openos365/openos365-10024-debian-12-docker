# openos365-10024-debian-12-docker

## 0 star the project if it is helpfull

* star it at github: https://github.com/openos365/openos365-10024-debian-12-docker
* star it at dockerhub: https://hub.docker.com/r/openos365/openos365-10024-debian-12-docker-main

  > Thank you

## 1 support

* submit a issue: https://github.com/openos365/openos365-10024-debian-12-docker/issues/new
* chat with us: https://matrix.to/#/#openos365:matrix.org

## 2 what

* openos365-10024-debian-12-docker docker images
  
## 3 why (values)

1. setup repo mirror for China `files/install.sh`
1. pr-install some packages `files/install.sh`
1. pre-config `files/root/`
1. networking problems `using github actions network`
1. save install and update time `build it using schedule actions`
1. publish and track `versions` changes
1. publish and track `yum.repo.d`

## 4 how to use

#### root
```
docker pull openos365/openos365-10024-debian-12-docker-main-root:latest
docker run -it --privileged=true -v /sys/fs/cgroup:/sys/fs/cgroup:ro openos365/openos365-10024-debian-12-docker-main-root:latest bash

podman pull docker.io/openos365/openos365-10024-debian-12-docker-main-root:latest
podman run -it docker.io/openos365/openos365-10024-debian-12-docker-main-root:latest
podman run -it docker.io/openos365/openos365-10024-debian-12-docker-main-root:latest /sbin/init

sudo podman run -it \
--cap-add=ALL \
--privileged=true \
--tmpfs /tmp \
--tmpfs /run \
-v /etc/resolv.conf:/etc/resolv.conf \
--net=host \
--hostname=openos365-10024-debian-12-docker-main-root \
docker.io/openos365/openos365-10024-debian-12-docker-main-root:latest \
/sbin/init \
--log-level=debug

```
#### www

```
docker pull openos365/openos365-10024-debian-12-docker-main-www:latest
docker run -it --privileged=true -v /sys/fs/cgroup:/sys/fs/cgroup:ro openos365/openos365-10024-debian-12-docker-main-www:latest bash

podman pull docker.io/openos365/openos365-10024-debian-12-docker-main-www:latest:latest
podman run -it docker.io/openos365/openos365-10024-debian-12-docker-main-www:latest:latest
podman run -it docker.io/openos365/openos365-10024-debian-12-docker-main-www:latest:latest sudo /sbin/init



docker pull dockerhub.qingcloud.com/openos365/openos365-10024-debian-12-docker-main-root:latest
docker run -it --privileged=true -v /sys/fs/cgroup:/sys/fs/cgroup:ro dockerhub.qingcloud.com/openos365/openos365-10024-debian-12-docker-main-root:latest bash


```
