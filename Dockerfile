# Dockerfile for Persian LaTeX compilation
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# Install system dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    git \
    make \
    inotify-tools \
    fontconfig \
    && rm -rf /var/lib/apt/lists/*

# Install TeX Live
RUN wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz \
    && tar -xzf install-tl-unx.tar.gz \
    && cd install-tl-* \
    && echo "selected_scheme scheme-full" > texlive.profile \
    && ./install-tl -profile texlive.profile -repository https://mirror.ctan.org/systems/texlive/tlnet/ \
    && cd .. \
    && rm -rf install-tl-* install-tl-unx.tar.gz

# Add TeX Live to PATH
ENV PATH="/usr/local/texlive/2023/bin/x86_64-linux:${PATH}"

# Install Persian fonts
RUN apt-get update && apt-get install -y \
    fonts-b-nazanin \
    fonts-xb-royale \
    fonts-b-titr \
    fonts-b-mitra \
    fonts-b-yekan \
    fonts-b-homa \
    fonts-b-koodak \
    && fc-cache -fv \
    && rm -rf /var/lib/apt/lists/*

# Create working directory
WORKDIR /workspace

# Copy scripts
COPY scripts/ /workspace/scripts/
RUN chmod +x /workspace/scripts/*.sh

# Copy LaTeX files
COPY *.tex /workspace/
COPY *.sty /workspace/
COPY *.bib /workspace/
COPY images/ /workspace/images/
COPY Makefile /workspace/
COPY latexmkrc /workspace/

# Set default command
CMD ["make", "all"]
