#!/bin/sh
#
# Plain Plain Text shell script for building pdfs and docxs.
# Based on https://github.com/denten-bin/write-support/blob/master/print.sh

# 1. reset tmp directory.
if [[ -d tmp ]]; then
  # The directory exists, so empty its contents
  rm tmp/*
else
  mkdir tmp
fi

# 2. find metadata file.
if ! [[ -f metadata.yml ]]; then
  echo "Could not find file “metadata.yml”"
  exit 1
fi

# 3. Make sections list
if [[ -f sections.txt ]]; then
  sections=`grep "^[^#]" sections.txt | sed -n 's#^\(.*\)$#sections/\1.md#p' | tr '\n' ' '`
  cat $sections > tmp/main.md
else
  echo "Could not find file “sections.txt”"
  exit 1
fi

# 3. Invoke pandoc
pandoc -sr markdown+yaml_metadata_block+citations \
  --pdf-engine=xelatex --template=template.tex \
  --filter pandoc-citeproc \
  ./metadata.yml ./tmp/main.md \
  -o output.pdf
