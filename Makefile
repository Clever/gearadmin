SHELL := /bin/bash
PKG = github.com/Clever/gearadmin
SUBPKGS = github.com/Clever/gearadmin/cmd/gearlogger
PKGS = $(PKG) $(SUBPKGS)

.PHONY: test $(PKGS)

test: $(PKGS)

build:
	go build github.com/Clever/gearadmin/cmd/gearlogger

$(PKGS):
ifeq ($(LINT),1)
	golint $(GOPATH)/src/$@*/**.go
endif
	go get -d -t $@
ifeq ($(COVERAGE),1)
	go test -cover -coverprofile=$(GOPATH)/src/$@/c.out $@ -test.v
	go tool cover -html=$(GOPATH)/src/$@/c.out
else
	go test $@ -test.v
endif
