NODE_BIN ?= node_modules/.bin

JSHINT ?= $(NODE_BIN)/jshint

LIB := index.js
EXAMPLE := example

.SUFFIXES:
.PHONY: all lint

all: lint

lint:
	@$(JSHINT) $(LIB) $(EXAMPLE)
	@echo "All right!"
