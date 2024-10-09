#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <input_path>"
  exit 1
fi

input_path="$1"

for file in "$input_path"/*.bed; do
  cut -f 1-11 "$file" > "$input_path"/temp.bed && mv "$input_path"/temp.bed "$file"
done
