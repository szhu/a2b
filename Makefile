index.js:
	coffee --compile --map index.coffee

PHONY += watch
watch:
	coffee --compile --map --watch index.coffee


.PHONY: $(PHONY)
