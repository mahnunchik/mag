NODE_BIN ?= node_modules/.bin

COFFEE ?= $(NODE_BIN)/coffee
COFFEELINT ?= $(NODE_BIN)/coffeelint

SRC_DIR := src
OUT_DIR := lib
VPATH = $(SRC_DIR)

SCRIPTS = $(patsubst $(SRC_DIR)/%.coffee,   \
                     $(OUT_DIR)/%.js,       \
                     $(wildcard $(SRC_DIR)/*.coffee))

.SUFFIXES:
.PHONY: all clean

all: $(SCRIPTS)

$(OUT_DIR)/%.js : %.coffee
	@mkdir -p $(@D)
	$(COFFEE) -cb -o $(@D) $^

lint:
	$(COFFEELINT) -r -f coffeelint.json src/

clean:
	rm -rf $(OUT_DIR)
