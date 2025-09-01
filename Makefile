# Makefile for Persian LaTeX document compilation

# Main document name (without extension)
DOCUMENT = seminar

# XeLaTeX compiler
XELATEX = xelatex
XELATEX_FLAGS = -interaction=nonstopmode -shell-escape

# BibTeX for bibliography
BIBTEX = bibtex

# Clean command
CLEAN = rm -f *.aux *.bbl *.blg *.log *.out *.toc *.lof *.lot *.fls *.fdb_latexmk *.ent

# Default target
all: $(DOCUMENT).pdf

# Main compilation rule
$(DOCUMENT).pdf: $(DOCUMENT).tex
	$(XELATEX) $(XELATEX_FLAGS) $(DOCUMENT).tex
	$(BIBTEX) $(DOCUMENT)
	$(XELATEX) $(XELATEX_FLAGS) $(DOCUMENT).tex
	$(XELATEX) $(XELATEX_FLAGS) $(DOCUMENT).tex

# Clean auxiliary files
clean:
	$(CLEAN)

# Clean everything including PDF
distclean: clean
	rm -f $(DOCUMENT).pdf

# Install Persian fonts (Ubuntu/Debian)
install-fonts:
	sudo apt-get update
	sudo apt-get install -y fonts-b-nazanin fonts-xb-royale fonts-b-titr fonts-b-mitra
	sudo fc-cache -fv

# Install TeX Live packages
install-texlive:
	sudo apt-get update
	sudo apt-get install -y texlive-full texlive-fonts-extra texlive-lang-arabic

# Watch for changes and recompile
watch:
	@echo "Watching for changes in .tex files..."
	@while inotifywait -e modify *.tex *.sty *.bib; do \
		echo "Recompiling..."; \
		make $(DOCUMENT).pdf; \
	done

# Help
help:
	@echo "Available targets:"
	@echo "  all          - Compile the document (default)"
	@echo "  clean        - Remove auxiliary files"
	@echo "  distclean    - Remove auxiliary files and PDF"
	@echo "  install-fonts - Install Persian fonts"
	@echo "  install-texlive - Install TeX Live packages"
	@echo "  watch        - Watch for changes and recompile"
	@echo "  help         - Show this help"

.PHONY: all clean distclean install-fonts install-texlive watch help
