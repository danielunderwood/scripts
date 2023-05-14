#! /usr/bin/env bash
# Script for unzipping a series of zip files to a target directory
# Particularly helpful for extracting bandcamp downloads to a music directory
target="/path/to/file"
set +x
set -e

for filename in *.zip; do
  dir="$(echo $filename | sed 's/\.zip$//' | sed 's/^.*\s+//' )"
  echo "Unzipping to $dir"
  unzip "$filename" -d "$target/$dir"
done
