SHELL=bash
GOFILES=$(wildcard *.go)
BIN_NAME=humioctl
BIN_PATH=bin/$(BIN_NAME)
CLI_COMMAND ?= ""

$(BIN_PATH): $(GOFILES)

all: build

$(BIN_PATH): FORCE
	go build -o $(BIN_PATH) ./cmd/humioctl

build: $(BIN_PATH)

clean:
	go clean
	@rm -rf bin/

snapshot:
	goreleaser build --rm-dist --snapshot
	@rm -rf bin/

run: $(BIN_PATH)
	$(BIN_PATH) $(CLI_COMMAND)

e2e: $(BIN_PATH)
	./e2e/run.bash

e2e-upcoming: $(BIN_PATH)
	./e2e/run-upcoming-features.bash

.PHONY: build clean snapshot run e2e e2e-upcoming FORCE

FORCE:
