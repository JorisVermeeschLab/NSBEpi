#!/bin/bash

input_folder="/staging/leuven/stg_00124/Benjamin/one_strand_epi/control_bedmethyl"

for input_file in "$input_folder"/*.bed; do
    base_name=$(basename "$input_file" .bed)
    output_file="${base_name}_noChr.bed"
    
    awk 'BEGIN {FS=OFS="\t"} {$1 = substr($1, 4)} 1' "$input_file" > "$output_file"
done
