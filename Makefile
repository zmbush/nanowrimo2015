FORMATS=epub odt docx pdf txt
TITLE=The Incident
OUT_DIR=output


space :=
space +=

FIXED_TITLE=$(subst $(space),-,$(TITLE))
OUT_PREFIX=$(OUT_DIR)/$(FIXED_TITLE)-$(shell git describe --dirty=-DRAFT)
OUT_FILES=$(addprefix $(OUT_PREFIX).,$(FORMATS))

all: $(FORMATS)
	@echo "Files for $(TITLE) are up to date"

.PHONY: $(FORMATS)
$(FORMATS): %:$(OUT_PREFIX).%

$(OUT_FILES): Config.txt $(shell cat Contents.txt)
	@mkdir -p $(OUT_DIR)
	@echo "[Build] $@"
	@pandoc -o $@ $^

DAY ?= $(shell date +'%d')
GOAL ?= 1666
.PHONY: words
words:
	@./script/words.sh $(DAY) $(GOAL)
