# latexmk configuration for Persian LaTeX documents
$pdf_mode = 1;
$postscript_mode = $dvi_mode = 0;

# Use XeLaTeX for Persian support
$pdflatex = 'xelatex -interaction=nonstopmode -shell-escape %O %S';

# Clean up auxiliary files
$clean_ext = 'aux bbl blg fdb_latexmk fls log out toc lof lot ent';

# Force XeLaTeX compilation
$pdf_mode = 1;
$pdflatex = 'xelatex -interaction=nonstopmode -shell-escape %O %S';

# Bibliography processing
$bibtex_use = 2;

# Enable shell escape for external commands
$pdflatex = 'xelatex -interaction=nonstopmode -shell-escape %O %S';
