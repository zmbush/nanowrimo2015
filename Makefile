FORMATS=epub odt docx pdf
TITLE=The Incident
OUT_DIR=output


space :=
space +=

FIXED_TITLE=$(subst $(space),-,$(TITLE))
OUT_PREFIX=$(OUT_DIR)/$(FIXED_TITLE)-$(shell date +'%Y-%m-%d')
OUT_FILES=$(addprefix $(OUT_PREFIX).,$(FORMATS))

all: $(OUT_FILES)
	@echo "Files for $(TITLE) are up to date"

$(OUT_FILES): Config.txt $(shell cat Contents.txt)
	@mkdir -p $(OUT_DIR)
	@echo "[Build] $@"
	@pandoc -o $@ $^
