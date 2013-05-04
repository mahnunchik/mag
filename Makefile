COFFEE ?= node_modules/.bin/coffee

SRC := src
OUT_DIR := lib

SCRIPTS = $(patsubst $(SRC)/%.coffee, \
                     $(OUT_DIR)/%.js, \
                     $(wildcard $(SRC)/*.coffee))

.SUFFIXES:
.PHONY: all clean

all: $(SCRIPTS)

$(OUT_DIR)/%.js : $(SRC)/%.coffee | $(OUT_DIR)
	$(COFFEE) -cb -o $(OUT_DIR) $^

$(OUT_DIR) :
	mkdir -p $@

clean:
	rm -rf $(OUT_DIR)
