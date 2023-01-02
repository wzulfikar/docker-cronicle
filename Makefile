IMAGE_NAME=wzulfikar/cronicle

multi:
	docker buildx create --platform ${PLATFORM} --name multibuild-${VERSION} --use
	docker buildx inspect multibuild-${VERSION} --bootstrap
	docker buildx build --platform ${PLATFORM} -t $(IMAGE_NAME):${VERSION} --push -f ${DOCKERFILE} ./docker
	docker buildx rm multibuild-${VERSION}

multi-default:
	VERSION=latest PLATFORM=linux/amd64,linux/arm/v7 DOCKERFILE=./docker/Dockerfile make multi

multi-arm64:
	cat docker/Dockerfile | sed 's/FROM node:/FROM arm64v8\/node:/' >> docker/Dockerfile.arm64
	VERSION=latest-arm64 PLATFORM=linux/arm64/v8 DOCKERFILE=./docker/Dockerfile.arm64 make multi
