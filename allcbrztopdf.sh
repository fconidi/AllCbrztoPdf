#!/bin/bash

# Source: https://francoconidi.it
# Source: https://syslinuxos.com

set -xev
sudo apt update
sudo apt upgrade -y
sudo apt install -y pv imagemagick pdftk img2pdf unrar-free rar unrar p7zip-full

# Select the root folder
folder=$(zenity --file-selection --directory --title="Select the root folder")

# Rename all files .cbr to .rar and .cbz to .zip (recursively)
find "$folder" -type f -name "*.cbr" -execdir rename 's/ /_/g' '{}' \;
find "$folder" -type f -name "*.cbr" -execdir mv '{}' '{}'.rar \;
find "$folder" -type f -name "*.cbz" -execdir rename 's/ /_/g' '{}' \;
find "$folder" -type f -name "*.cbz" -execdir mv '{}' '{}'.zip \;

# Convert all files .cbr and .cbz to PDF (recursively)
find "$folder" -type f \( -name "*.rar" -o -name "*.cbr" -o -name "*.zip" -o -name "*.cbz" \) |
while read file; do
  ORIGINAL_FOLDER=$(dirname "$file")
  TMP_FOLDER=$(mktemp -d)
  cd "$TMP_FOLDER"
  case "$file" in
    *.rar|*.cbr)
      unrar e "$file" "$TMP_FOLDER"
      ;;
    *.zip|*.cbz)
      unzip -j "$file" -d "$TMP_FOLDER"
      ;;
  esac
  ls -1 ./*jpg ./*jpeg ./*png | pv -lep -s $(ls -1 ./*jpg ./*jpeg ./*png | wc -l) | xargs -L1 -I {} img2pdf {} -o {}.pdf
  pdftk *.pdf cat output combined.pdf
  cp "$TMP_FOLDER/combined.pdf" "$ORIGINAL_FOLDER/$(basename "$file" .cbr | sed 's/.rar$//;s/.zip$//;s/.cbz$//').pdf"
  rm -rf "$TMP_FOLDER"
  rm "$file"
done

zenity --info --text="Conversion completed!"

