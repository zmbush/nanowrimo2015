FORMATS=epub odt docx pdf

OUT_DIR=output/$(shell date +'%Y-%m-%d')
OUT_FILES=$(addprefix $(OUT_DIR)/book.,$(FORMATS))

all: $(OUT_FILES)

$(OUT_FILES): Config.txt $(shell cat Contents.txt)
	@mkdir -p output/$(shell date +'%Y-%m-%d')
	pandoc -o $@ $^
