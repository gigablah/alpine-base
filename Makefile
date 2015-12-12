NAME = alpine-base
TAG = 3.2
IMAGE = gigablah/$(NAME)

.PHONY: all build push clean

all: build push

build: s6-overlay-amd64.tar.gz
	docker build -t $(IMAGE):$(TAG) --rm --no-cache .

push:
	docker push $(IMAGE)

clean:
	rm -f s6-overlay-amd64.tar.gz

s6-overlay-amd64.tar.gz:
	wget https://github.com/just-containers/s6-overlay/releases/download/v1.14.0.4/s6-overlay-amd64.tar.gz
