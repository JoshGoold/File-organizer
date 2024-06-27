#!/bin/bash

# Description: This script automatically organizes files in a directory.
# Author: Joshua Goold

# Source and destination directories (modify as needed)

source_directory=$1
destination_directory=$2

# Print directory to be organized
echo "Organizing directory: $source_directory"

# Create destination subdirectories (handle errors)
mkdir -p "$destination_directory/images" || echo "Error creating images directory"
mkdir -p "$destination_directory/text" || echo "Error creating text directory"
mkdir -p "$destination_directory/media" || echo "Error creating media directory"
mkdir -p "$destination_directory/other" || echo "Error creating other directory"

# Move files with progress messages
echo "Working..."
echo "Moving files..."

for file in "$source_directory"/*; do
  # Check if it's a regular file and skip directories
  if [[ -f "$file" ]]; then
    # Get the filename and extension
    filename=$(basename "$file")
    extension="${filename##*.}"
    echo "$extension"

    # Move based on extension (add more cases as needed)
    case "$extension" in
      txt|docx)
        mv "$file" "$destination_directory/text/$filename"
        ;;
      jpg|png|gif|avif)
        mv "$file" "$destination_directory/images/$filename"
        ;;
      mp3|mp4)
        mv  "$file" "$destination_directory/media/$filename"
        ;;
      *)
	mv "$file" "$destination_directory/other/$filename"
        echo "Other extension: $extension"
        ;;
    esac
  fi
done

echo "Files organized!"
