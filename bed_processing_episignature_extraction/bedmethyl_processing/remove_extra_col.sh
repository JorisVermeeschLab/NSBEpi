for file in *.bed; do
cut -f 1-11 "$file" > temp.bed && mv temp.bed "$file"
done
