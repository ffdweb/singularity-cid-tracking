#!/bin/bash

# Usage: ./db_prep_report.sh
# Output is saved to preparations.csv with columns: PrepID,Name,StorageID

output_file="preparations.csv"
temp_file="$(mktemp)"

# Truncate output and write header
echo "PrepID,Name,StorageID" > "$output_file"

# Get the full prep list from Singularity and process with awk
singularity prep list | awk '
    /^[0-9][0-9]*[[:space:]]/ {
        # First line of a prep block, grab ID and Name (only $2, not the rest)
        prep_id=$1
        name=$2
    }
    /^[[:space:]][[:space:]]*[0-9][0-9]*[[:space:]]/ {
        # Storage block line, grab StorageID
        storage_id=$1
        printf "%s,%s,%s\n", prep_id, name, storage_id
    }
' > "$temp_file"

# Sort by numeric PrepID and append to output file
sort -t, -k1,1n "$temp_file" >> "$output_file"
rm "$temp_file"

echo "Output written to $output_file"
