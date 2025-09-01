# Seminar Document - Persian LaTeX

This repository contains a Persian LaTeX document with automatic CI/CD compilation support.

## Features

- ✅ Persian language support using XePersian
- ✅ Automatic compilation with GitHub Actions
- ✅ Local compilation with Makefile
- ✅ Bibliography support
- ✅ Persian fonts (B Nazanin, XB Roya)
- ✅ XeLaTeX compilation

## Quick Start

### Local Compilation

1. **Install TeX Live and Persian fonts:**
   ```bash
   make install-texlive
   make install-fonts
   ```

2. **Compile the document:**
   ```bash
   make
   ```

3. **Clean auxiliary files:**
   ```bash
   make clean
   ```

### Using GitHub Actions

The document will be automatically compiled on every push to `main` or `master` branch. The compiled PDF will be available as an artifact.

## File Structure

```
├── seminar.tex          # Main document
├── MyTemplate.sty       # Custom LaTeX template with Persian support
├── dictionary.tex       # Dictionary definitions
├── title.tex           # Title page
├── bib.tex             # Bibliography
├── ref.bib             # BibTeX references
├── images/             # Image directory
├── .github/workflows/  # GitHub Actions configuration
├── Makefile            # Local compilation
├── latexmkrc           # latexmk configuration
└── README.md           # This file
```

## Dependencies

### Required LaTeX Packages
- `xepersian` - Persian language support
- `hyperref` - Hyperlinks
- `graphicx` - Graphics
- `endnotes` - Endnotes
- `geometry` - Page layout
- `multicol` - Multiple columns
- `fancybox` - Fancy boxes
- `subcaption` - Subcaptions

### Required Fonts
- B Nazanin (Persian text)
- XB Roya (Persian digits)
- Times New Roman (Latin text)

### System Requirements
- TeX Live 2020 or later
- XeLaTeX compiler
- Persian fonts installed

## Compilation Commands

### Manual Compilation
```bash
xelatex -interaction=nonstopmode -shell-escape seminar.tex
bibtex seminar
xelatex -interaction=nonstopmode -shell-escape seminar.tex
xelatex -interaction=nonstopmode -shell-escape seminar.tex
```

### Using latexmk
```bash
latexmk -xelatex -interaction=nonstopmode -shell-escape seminar.tex
```

### Using Makefile
```bash
make all          # Compile document
make clean        # Clean auxiliary files
make distclean    # Clean everything including PDF
make watch        # Watch for changes and recompile
```

## Troubleshooting

### Font Issues
If you encounter font-related errors:

1. **Install Persian fonts:**
   ```bash
   make install-fonts
   ```

2. **Update font cache:**
   ```bash
   sudo fc-cache -fv
   ```

3. **Check font availability:**
   ```bash
   fc-list | grep -i nazanin
   fc-list | grep -i roya
   ```

### Compilation Errors
1. Ensure XeLaTeX is used (not pdfLaTeX)
2. Check that all required packages are installed
3. Verify Persian fonts are properly installed
4. Check for syntax errors in .tex files

### GitHub Actions Issues
1. Check the Actions tab for detailed error logs
2. Ensure all files are committed to the repository
3. Verify the workflow file is in the correct location

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test compilation locally
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For issues and questions:
1. Check the troubleshooting section above
2. Review the GitHub Actions logs
3. Open an issue in the repository
