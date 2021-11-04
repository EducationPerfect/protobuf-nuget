PWD:=$(shell pwd)

.PHONY: build-pack
build-pack:
	docker build -t protobuf-nuget-packer ./pack

.PHONY: run-pack
run-pack:
	docker run --rm -it --name protobuf-nuget-packer \
		--volume $(PWD)/protosx:/protos --volume $(PWD)/artifacts:/artifacts\
		protobuf-nuget-packer \
			--package-name=EP.Contract.Awsome \
			--package-version=1.1.0 \
			--protobuf-dir-path=/protos \
			--output-path=./artifacts \
			--company=EP \
			--authors="Team Void"
