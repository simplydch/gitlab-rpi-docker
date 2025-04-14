# upstream: https://packages.gitlab.com/gitlab/raspberry-pi2
# arm64 not supported on rpi, so let's use armhf (see https://docs.gitlab.com/omnibus/settings/rpi.html)
# repo originally hard-coded as raspberry-pi2 changed to gitlab-ce as default
# OS originally hard-coded as bullseye changed to bookworm as default
RELEASE_ARCH=arm64
RELEASE_PACKAGE=gitlab-ce
RELEASE_VERSION=17.8.7-ce.0
RELEASE_REPO=gitlab-ce 
RELEASE_PACK_URL=debian # will be raspbian if REPO is raspberry-pi2
OS_NAME=bookworm


