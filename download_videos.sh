#!/bin/bash

# Assign the first command-line argument to the INPUT_FILE variable.
INPUT_FILE="$1"

# Check if a file was provided.
if [[ -z "$INPUT_FILE" ]]; then
  echo "Error: Please provide an input file."
  echo "Usage: $0 <filename.csv>"
  exit 1
fi

# Check if the provided file exists.
if [[ ! -f "$INPUT_FILE" ]]; then
  echo "Error: Input file '$INPUT_FILE' not found."
  exit 1
fi

# Loop through each line of the CSV file.
while IFS=, read -r link name
do
  echo "\n\n======== SAVING $name ========"

  # Check if both fields are non-empty.
  if [[ -n "$link" && -n "$name" ]]; then
    # Execute the yt-dlp command.
    yt-dlp -S res,ext:mp4:m4a --recode mp4 "$link" -o "$name"
  else
    echo "Skipping an empty or malformed line."
  fi

done < "$INPUT_FILE"
