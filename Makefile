NODE_BIN ?= node_modules/.bin

COFFEE ?= $(NODE_BIN)/coffee
MOCHA ?= $(NODE_BIN)/mocha
COFFEELINT ?= $(NODE_BIN)/coffeelint
MARKDOX ?= $(NODE_BIN)/markdox

SRC_DIR := src
OUT_DIR := lib
DOC_DIR := docs

SCRIPTS := $(patsubst $(SRC_DIR)/%.coffee, \
                     	$(OUT_DIR)/%.js, \
                     	$(wildcard $(SRC_DIR)/*.coffee))

DOCS := $(patsubst $(SRC_DIR)/%.coffee, \
                   $(DOC_DIR)/%.md, \
                   $(wildcard $(SRC_DIR)/*.coffee))


.SUFFIXES:
.PHONY: all clean test lint

all: $(SCRIPTS) $(DOCS)

debug:
	@echo $(SCRIPTS)
	@echo $(DOCS)

$(OUT_DIR)/%.js : $(SRC_DIR)/%.coffee
	@mkdir -p $(@D)
	$(COFFEE) -cb -o $(@D) $^

$(DOC_DIR)/%.md : $(SRC_DIR)/%.coffee
	@mkdir -p $(@D)
	$(MARKDOX) -o $@ $^

lint:
	$(COFFEELINT) -r -f coffeelint.json src/

clean:
	rm -rf $(OUT_DIR)
	rm -rf $(DOC_DIR)

docs: $(DOCS)
