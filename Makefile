SHELL := /bin/bash

VERSION := `git describe --abbrev=0`
GITCOMMIT := `git rev-parse HEAD`
BUILDDATE := `date +%Y-%m-%d`
BUILDUSER := `whoami`

LDFLAGSSTRING :=-X github.com/ethereum-optimism/optimisticben/eth_exporter/version.Version=$(VERSION)
LDFLAGSSTRING +=-X github.com/ethereum-optimism/optimisticben/eth_exporter/version.GitCommit=$(GITCOMMIT)
LDFLAGSSTRING +=-X github.com/ethereum-optimism/optimisticben/eth_exporter/version.BuildDate=$(BUILDDATE)
LDFLAGSSTRING +=-X github.com/ethereum-optimism/optimisticben/eth_exporter/version.BuildUser=$(BUILDUSER)

LDFLAGS :=-ldflags "$(LDFLAGSSTRING)"

.PHONY: all build

all: build

# Build binary
build:
	CGO_ENABLED=0 go build $(LDFLAGS)