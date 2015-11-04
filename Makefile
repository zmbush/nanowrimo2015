all:
	pandoc -S -o output/$(shell date +'%Y-%M-%d')-book.epub Config.txt About.txt Chapter*.md

