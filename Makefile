IMAGE_NAME=wzulfikar/cronicle
IMAGE_VERSION=latest
PLATFORM=linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64

docker:
	docker build --pull -t $(IMAGE_NAME):$(IMAGE_VERSION) .

push:
	docker push $(IMAGE_NAME):$(IMAGE_VERSION)

multi: ./docker/Dockerfile
	docker buildx create --platform $(PLATFORM) --name multibuild --use
	docker buildx inspect multibuild --bootstrap
	docker buildx build --platform $(PLATFORM) -t $(IMAGE_NAME):$(IMAGE_VERSION) --push .
	docker buildx rm multibuild
