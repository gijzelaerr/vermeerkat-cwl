IMAGE_NAME=casa_flagdata
DOCKER_REPO=vermeerkat/${IMAGE_NAME}

.PHONY: build clean run

all: build

build:
	docker build -f ${IMAGE_NAME}.docker -t ${DOCKER_REPO} .

clean:
	docker rmi ${DOCKER_REPO}

run: build
	docker run -ti ${DOCKER_REPO}

