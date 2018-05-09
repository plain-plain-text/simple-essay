#!/bin/bash
#
# Plain Plain Text shell script for building pdfs and docxs.
# Based on https://github.com/denten-bin/write-support/blob/master/print.sh
#
# USAGE:
#           sh print.sh [-p|-d] filename.md
#
#           -p to produce .pdf
#           -d for .docx
#
# This script makes some assumptions about the structure of the work, because
# we assume that every essay is its own clone of:
#
# https://github.com/plain-plain-text/plain-essay
#
# Hence, we assume ahead of time a metadata file, metadata.yml, and a main file,
# main.md. Other files can be appended, but those are the basic assumptions.

## pass the file name as an argument, with "main.md" as the default
if [ $# -eq 0 ]
then
  echo "Usage: To print a .pdf, try $0 -p. To print a .docx, try $0 -d."
elif [ $# -eq 1 ]
then
  source="main.md"
else
  source=$2
fi

# Use parameter expansion to strip the name
target="${source%%.*}"

# Check to make sure metadata.yml exists
if [ -f metadata.yml ]
then
  yaml="metadata.yml"
else
  echo "Could not find metadata.yml"
  exit
fi

# Branch based on passed options.
while getopts ":dp" opt; do
  case $opt in
    d)
      echo "printing $source to $target.docx " >&2
      pandoc -sr markdown+yaml_metadata_block "$yaml" "$source" \
        -o "$target".docx
      ;;
    p)
      echo "printing $source to $target.pdf " >&2
      pandoc -sr markdown+yaml_metadata_block "$yaml" "$source" \
        --pdf-engine=xelatex \
        -o "$target".pdf
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done
