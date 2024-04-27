.POSIX:

export DOCKER_BUILDKIT=1

IMAGE_FULLNAME=git.devmem.ru/projects/nextcloud
# renovate: depName=nextcloud
IMAGE_TAG=27.1.9-fpm
IMAGE=${IMAGE_FULLNAME}:${IMAGE_TAG}

default: build

build:
	@docker build \
		--cache-from ${IMAGE} \
		--tag ${IMAGE} \
		--build-arg BUILD_IMAGE=nextcloud:${IMAGE_TAG} \
		-f .docker/Dockerfile .

build-nocache:
	@docker build \
		--pull --no-cache \
		--tag ${IMAGE} \
		--build-arg BUILD_IMAGE=nextcloud:${IMAGE_TAG} \
		-f .docker/Dockerfile .

rmi:
	@docker rmi ${IMAGE}

run:
	@docker run \
		--rm \
		--interactive \
		--tty \
		${IMAGE}
