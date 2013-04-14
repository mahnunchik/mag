
all:
	node_modules/.bin/coffee -cbo lib/ src/

clean:
	rm -rf lib/
