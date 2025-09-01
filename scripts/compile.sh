#!/bin/bash

# Script to compile Persian LaTeX document
# This script handles both local and CI environments

set -e

# Configuration
DOCUMENT="seminar"
COMPILER="xelatex"
COMPILER_FLAGS="-interaction=nonstopmode -shell-escape"
BIBTEX="bibtex"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if main document exists
if [ ! -f "${DOCUMENT}.tex" ]; then
    print_error "Main document ${DOCUMENT}.tex not found!"
    exit 1
fi

print_status "Starting compilation of ${DOCUMENT}.tex"

# Check if we're in a CI environment
if [ -n "$CI" ]; then
    print_status "Running in CI environment"
    # Install fonts if needed
    if command -v apt-get &> /dev/null; then
        print_status "Installing Persian fonts..."
        sudo apt-get update -qq
        sudo apt-get install -y -qq fonts-b-nazanin fonts-xb-royale fonts-b-titr fonts-b-mitra
        sudo fc-cache -fv
    fi
fi

# First compilation
print_status "First compilation..."
$COMPILER $COMPILER_FLAGS $DOCUMENT.tex

# Check if bibliography exists and compile it
if [ -f "${DOCUMENT}.aux" ] && grep -q "\\bibdata" "${DOCUMENT}.aux"; then
    print_status "Compiling bibliography..."
    $BIBTEX $DOCUMENT
else
    print_warning "No bibliography found, skipping bibtex"
fi

# Second compilation
print_status "Second compilation..."
$COMPILER $COMPILER_FLAGS $DOCUMENT.tex

# Third compilation (for references)
print_status "Third compilation (for references)..."
$COMPILER $COMPILER_FLAGS $DOCUMENT.tex

# Check if PDF was created
if [ -f "${DOCUMENT}.pdf" ]; then
    print_status "Compilation successful! PDF created: ${DOCUMENT}.pdf"
    
    # Get file size
    FILESIZE=$(du -h "${DOCUMENT}.pdf" | cut -f1)
    print_status "PDF file size: $FILESIZE"
    
    # Check for warnings in log
    if grep -q "Warning" "${DOCUMENT}.log"; then
        print_warning "Warnings found in compilation log. Check ${DOCUMENT}.log for details."
    fi
    
    exit 0
else
    print_error "Compilation failed! PDF not created."
    print_error "Check ${DOCUMENT}.log for error details."
    exit 1
fi
