FORMATS=epub odt docx pdf txt
TITLE=The Incident
AUTHOR=Zachary Bush
OUT_DIR=output


space :=
space +=

FIXED_TITLE=$(subst $(space),-,$(TITLE))
OUT_PREFIX=$(OUT_DIR)/$(FIXED_TITLE)-$(shell git describe --dirty=-DRAFT)
OUT_FILES=$(addprefix $(OUT_PREFIX).,$(FORMATS))

all: /tmp/nano-cover.jpg $(FORMATS)
	@echo "Files for $(TITLE) are up to date"

.PHONY: $(FORMATS)
$(FORMATS): %:$(OUT_PREFIX).%

$(OUT_FILES): Config.txt $(shell cat Contents.txt)
	@mkdir -p $(OUT_DIR)
	@echo "[Build] $@"
	@pandoc --toc --chapters -V documentclass=report -o $@ $^

/tmp/nano-cover.jpg: images/cover2.jpg
	convert $^ \
	-resize 1000x1000 -background white -gravity center \
	-extent 1563x2500 -pointsize 200 \
	-draw "gravity north fill black text 0,300 '$(TITLE)'" \
	-draw "gravity south fill black text 0,300 '$(AUTHOR)'" \
	$@

DAY ?= $(shell date +'%d')
GOAL ?= 1666
.PHONY: words
words:
	@./script/words.sh $(DAY) $(GOAL)
