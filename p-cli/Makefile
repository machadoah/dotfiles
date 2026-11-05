BINARY := p-cli
PREFIX ?= $(HOME)/.local/bin
VERSION ?= $(shell git describe --tags --always --dirty 2>/dev/null || echo dev)

.PHONY: build test install clean

build:
	go build -trimpath -ldflags "-s -w -X github.com/machadoah/dotfiles/p-cli/cmd.version=$(VERSION)" -o bin/$(BINARY) .

test:
	go test ./...

install: build
	install -d $(PREFIX)
	install -m 0755 bin/$(BINARY) $(PREFIX)/$(BINARY)

clean:
	rm -rf bin
