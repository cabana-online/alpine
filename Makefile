-include env_make

ALPINE_VER ?= 3.12.0

REPO = cabanaonline/alpine
NAME = alpine-$(ALPINE_VER)

ifneq ($(STABILITY_TAG),)
    ifneq ($(TAG),latest)
        override TAG := $(TAG)-$(STABILITY_TAG)
    endif
endif

ifeq ($(TAG),)
    ifneq ($(ALPINE_DEV),)
    	TAG ?= $(ALPINE_VER)-dev
    else
        TAG ?= $(ALPINE_VER)
    endif
endif

ifneq ($(ALPINE_DEV),)
    NAME := $(NAME)-dev
endif

.PHONY: build test push shell run start stop logs clean release

default: build

build:
	docker build -t $(REPO):$(TAG) \
		--build-arg ALPINE_VER=$(ALPINE_VER) \
		--build-arg ALPINE_DEV=$(ALPINE_DEV) \
		./

-include docker-helper-scripts/Makefile
