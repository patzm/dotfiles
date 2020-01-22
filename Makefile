IMAGE_NAME := patzm/home
BUILD_VERSION := $(shell cat VERSION)

build: docker_build

docker_build:
	  @docker build \
    	--build-arg BUILD_DATE=$(shell date -u +'%Y-%m-%dT%H:%M:%SZ') \
    	--build-arg BUILD_VERSION=${BUILD_VERSION} \
    	--build-arg VCS_REF=$(shell git rev-parse --short HEAD) \
    	-t ${IMAGE_NAME}:latest -t ${IMAGE_NAME}:${BUILD_VERSION} \
    	.

docker_publish:
		@docker push ${IMAGE_NAME}:latest
		@docker push ${IMAGE_NAME}:${BUILD_VERSION}

.PHONY: docker_build
