# GitLab Docker Image builder for Raspberry PI 4

### Forked from https://github.com/xaxa06/gitlab-rpi-docker. I've made changes so that this works for 17.8.7-ce.0 and is a bit more flexible.  I've also included a gitlab.rb which follows GitLab's recommendations for memory constrained environments.  This should be automatically applied but if it isn't you can copy it to the /gitlab/config/ folder and then run gitlab-ctl reconfigure.

## What is this ?
As time of writing, GitLab doesn't seem to provide any docker image for RPI (nor even for arm64).

1. [Instructions for Raspberry PI](https://docs.gitlab.com/omnibus/settings/rpi.html) only refer to installing directly on RPI (no docker) and mentions it lacks support for AMR64 on RPI: 
2. [General Docker instructions](https://docs.gitlab.com/ee/install/docker.html), only refer to Gitlab official docker image, but none for `arm64` nor `armhf`
3. We have third parties pre-build Docker images for `arm64`, however they fail with obscure reasons on RPI, likely because of 1. (ex: https://github.com/zengxs/gitlab-arm64)


This project allows building manually, and transparently, a Gitlab CE docker image for Raspberry PI 4, using GitLab's official [Dockerfile](https://gitlab.com/gitlab-org/omnibus-gitlab/-/tree/master/docke) and official [raspberry-pi2 gitlab-ce debian package](https://packages.gitlab.com/gitlab/raspberry-pi2)

It just clones the official repo and apply a patch on it (see [gitlab-docker-arm.patch](gitlab-docker-arm.patch)) with a few lines fixups in order to build an RPI 4 compatible docker image (with `armhf` arch).

## How to use it
- set repo and os information in `versions.mk`
- (optional) bump version in `versions.mk` (upstream: https://packages.gitlab.com/gitlab/raspberry-pi2)
- run:
```sh
make clean build
# [...]
#  => naming to gitlab-ce:16.3.6-ce.0-armhf
```
- use built image name (ex: `gitlab-ce:16.3.6-ce.0-armhf`) in docker run/compose/swarm, as documented in [GitLab Docker instructions](https://docs.gitlab.com/ee/install/docker.html) (simply replace `gitlabb/gitlab-ce:latest` image with the image name/tag that has just been built)

- An example of the docker run command might look like:
```
docker run --detach \
           --hostname localhost \
           --publish 8443:443 \
           --publish 8080:80 \
           --publish 8022:22 \
           --name gitlab \
           --restart always \
           --volume ~/gitlab/config:/etc/gitlab \
           --volume ~/gitlab/logs:/var/log/gitlab \
           --volume ~/gitlab/data:/var/opt/gitlab \
           --privileged \
           --memory="2.5g" \
           gitlab-ce:17.8.7-ce.0-arm64
```