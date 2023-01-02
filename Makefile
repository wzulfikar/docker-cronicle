IMAGE_NAME=wzulfikar/cronicle
IMAGE_VERSION=latest
PLATFORM=linux/amd64,linux/arm/v6,linux/arm/v7

docker:
	docker build --pull -t $(IMAGE_NAME):$(IMAGE_VERSION) .

push:
	docker push $(IMAGE_NAME):$(IMAGE_VERSION)

multi:
	docker buildx create --platform $(PLATFORM) --name multibuild --use
	docker buildx inspect multibuild --bootstrap
	docker buildx build --platform $(PLATFORM) -t $(IMAGE_NAME):$(IMAGE_VERSION) --push -f ./docker/Dockerfile .
	docker buildx rm multibuild
