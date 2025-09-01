#!/bin/bash

# Script to install dependencies for Persian LaTeX compilation
# This script should be run on Ubuntu/Debian systems

set -e

echo "Installing dependencies for Persian LaTeX compilation..."

# Update package list
sudo apt-get update

# Install TeX Live and required packages
echo "Installing TeX Live packages..."
sudo apt-get install -y \
    texlive-full \
    texlive-fonts-extra \
    texlive-lang-arabic \
    texlive-xetex \
    latexmk

# Install Persian fonts
echo "Installing Persian fonts..."
sudo apt-get install -y \
    fonts-b-nazanin \
    fonts-xb-royale \
    fonts-b-titr \
    fonts-b-mitra \
    fonts-b-yekan \
    fonts-b-homa \
    fonts-b-koodak

# Update font cache
echo "Updating font cache..."
sudo fc-cache -fv

# Install additional tools
echo "Installing additional tools..."
sudo apt-get install -y \
    inotify-tools \
    make

# Verify installation
echo "Verifying installation..."

# Check XeLaTeX
if command -v xelatex &> /dev/null; then
    echo "✅ XeLaTeX is installed"
    xelatex --version | head -1
else
    echo "❌ XeLaTeX is not installed"
    exit 1
fi

# Check Persian fonts
echo "Checking Persian fonts..."
if fc-list | grep -i "b nazanin" &> /dev/null; then
    echo "✅ B Nazanin font is available"
else
    echo "❌ B Nazanin font is not available"
fi

if fc-list | grep -i "xb roya" &> /dev/null; then
    echo "✅ XB Roya font is available"
else
    echo "❌ XB Roya font is not available"
fi

# Check latexmk
if command -v latexmk &> /dev/null; then
    echo "✅ latexmk is installed"
else
    echo "❌ latexmk is not installed"
fi

echo ""
echo "Installation completed successfully!"
echo ""
echo "You can now compile your Persian LaTeX document using:"
echo "  make all"
echo ""
echo "Or manually with:"
echo "  xelatex -interaction=nonstopmode -shell-escape seminar.tex"
echo "  bibtex seminar"
echo "  xelatex -interaction=nonstopmode -shell-escape seminar.tex"
echo "  xelatex -interaction=nonstopmode -shell-escape seminar.tex"
