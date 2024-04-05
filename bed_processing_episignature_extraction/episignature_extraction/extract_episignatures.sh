#!/bin/bash

# Checking if bedtools is installed
if ! command -v bedtools &> /dev/null; then
    echo "bedtools is not installed. Please install bedtools to run this script."
    exit 1
fi



# path to bed files containing the episignature loci (hg38_episignature_cordinates)
group1_path=""
# path to nanopore bedmethyl files
group2_path=""

# Creating the output folder if it doesn't exist
output_folder="name_out_folder"
mkdir -p "$output_folder"

for file2 in "$group2_path"/*.bed; do

    file2_basename=$(basename "$file2" .bed)

    for file1 in "$group1_path"/*.bed; do

        file1_basename=$(basename "$file1" .bed)

        output_file="${output_folder}/${file1_basename}_${file2_basename}.bed"

        # Performing the intersection using bedtools
        bedtools intersect -a "$file1" -b "$file2" -loj -wa -wb > "$output_file"

       	echo "Intersection created: $output_file"
    done
done

echo "Intersections completed!"

