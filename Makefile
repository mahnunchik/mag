NODE_BIN ?= node_modules/.bin

JSHINT ?= $(NODE_BIN)/jshint

LIB := index.js
EXAMPLE_DIR := example

.SUFFIXES:
.PHONY: all lint

all: lint

lint:
	@$(JSHINT) $(LIB) $(EXAMPLE_DIR)
	@echo "All right!"
