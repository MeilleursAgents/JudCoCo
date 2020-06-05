SHELL = /bin/bash

ifneq ("$(wildcard .env)","")
	include .env
	export
endif

.DEFAULT_GOAL := init

## help: Display list of commands
.PHONY: help
help: Makefile
	@sed -n 's|^##||p' $< | column -t -s ':' | sed -e 's|^| |'

## init: Init repository
.PHONY: init
init:
	@tools/install_hooks

.PHONY: build
build:
	docker build -t meilleursagentstech/judcoco:latest .

.PHONY: release
release:
	docker login -u meilleurs4gents
	docker push --disable-content-trust meilleursagentstech/judcoco:latest
	docker logout
