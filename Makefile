HTML_FLAGS=

all: sheet.html sheet.css

sheet.html: template.html
	./generate-html $^ $(HTML_FLAGS) > $@

sheet.css: sheet.scss block.scss box-bar.scss table.scss edit.scss
	sassc -t nested -m auto $< $@

clean:
	rm *.css *.css.map

auto:
	while true; do \
		inotifywait -e close_write *.scss template.html; \
		$(MAKE); \
	done

.PHONY: all clean auto
