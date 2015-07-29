NAME = alpine-base
TAG = 3.2
IMAGE = gigablah/$(NAME)
BUILD = gigablah/alpine-dev:latest

.PHONY: all build push clean bindings

all: build push

build: s6-2.1.6.0.tar.gz
	docker build -t $(IMAGE):$(TAG) --rm --no-cache .

push:
	docker push $(IMAGE)

clean:
	rm -rf s6-2.1.6.0.tar.gz

s6-2.1.6.0.tar.gz:
	chmod +x ./scripts/*.sh && sleep 1
	docker run --rm -v $(PWD):/opt $(BUILD) /opt/scripts/build.sh
