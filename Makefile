PWD:=$(shell pwd)

.PHONY: build
build:
	docker build -t nuget-generator .

.PHONY: run
run:
	docker run --rm -it --name protobuf-nuget-generator \
		--volume $(PWD)/proto:/proto --volume $(PWD)/artifacts:/artifacts\
		protobuf-nuget-generator \
			--package-name=EP.Contract.Awsome \
			--package-version=1.1.0 \
			--protobuf-dir-path=../nuget-generator/proto \
			--output-path=./artifacts
