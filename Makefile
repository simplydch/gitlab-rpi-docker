include ./versions.mk

omnibus-gitlab:
	git clone https://gitlab.com/gitlab-org/omnibus-gitlab.git \
	&& cd omnibus-gitlab \
	&& git apply ../gitlab-docker-arm.patch
	@if [ "$(CUSTOM_RB_FILE)" = "true" ]; then \
		cp gitlab.rb ./omnibus-gitlab/docker/assets/gitlab.rb; \
	fi
	
build: omnibus-gitlab
	@echo Docker build using ${RELEASE_PACKAGE}/${RELEASE_VERSION}
	docker build --network=host omnibus-gitlab/docker \
		-t gitlab-ce:${RELEASE_VERSION}-${RELEASE_ARCH} \
		--build-arg RELEASE_PACKAGE=${RELEASE_PACKAGE} \
		--build-arg RELEASE_VERSION=${RELEASE_VERSION} \
		--build-arg RELEASE_ARCH=${RELEASE_ARCH} \
		--build-arg RELEASE_REPO=${RELEASE_REPO} \
		--build-arg RELEASE_PACK_URL=${RELEASE_PACK_URL} \
		--build-arg OS_NAME=${OS_NAME}
		

clean:
	rm -rf omnibus-gitlab