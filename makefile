OWNER ?= fourjuaneight
REPO ?= hugo-gulp
VERSION ?= latest

build:
	docker build -t $(OWNER)/$(REPO):$(VERSION) .

push: build
	docker login -u $(OWNER)
	docker push $(OWNER)/$(REPO):$(VERSION)

shell: build
	docker run --rm -i -t $(OWNER)/$(REPO):$(VERSION) /bin/bash

rmi:
	docker rmi -f $(OWNER)/$(REPO)