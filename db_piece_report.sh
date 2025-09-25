#!/bin/bash

# Usage: ./db_piece_report.sh 1-3 5 7-9
# Output is saved to pieces.csv

output_file="pieces.csv"

# Start fresh: truncate file and write header once
echo "PieceCID,PieceSize,RootCID,FileSize,StorageID,PrepID,IsDag" > "$output_file"

# Expand numeric ranges like 1-3 into 1 2 3
expand_ranges() {
    for arg in "$@"; do
        if [[ "$arg" =~ ^[0-9]+-[0-9]+$ ]]; then
            start=${arg%-*}
            end=${arg#*-}
            for ((i=start; i<=end; i++)); do echo "$i"; done
        else
            echo "$arg"
        fi
    done
}

prep_ids=($(expand_ranges "$@"))

for prep_id in "${prep_ids[@]}"; do
    output=$(singularity prep list-pieces "$prep_id")

    # Get storage_id
    storage_id=$(echo "$output" | awk '/AttachmentID/{getline; print $2}')

    # Process each line in the singularity output
    echo "$output" | while read -r line; do
        # Skip lines that don't contain a PieceCID
        [[ "$line" =~ baga ]] || continue

        # Split line into fields
        fields=($line)

        # Detect presence of PieceType (older preps may not have it)
        if [[ "${fields[0]}" == "dag" || "${fields[0]}" == "data" ]]; then
            piece_type="${fields[0]}"
            piece_cid="${fields[1]}"
            piece_size="${fields[2]}"
            root_cid="${fields[3]}"
            file_size="${fields[4]}"
        else
            piece_type=""
            piece_cid="${fields[0]}"
            piece_size="${fields[1]}"
            root_cid="${fields[2]}"
            file_size="${fields[3]}"
        fi

        # Boolean flag for DAG
        [[ "$piece_type" == "dag" ]] && is_dag=1 || is_dag=0

        # Append CSV row
        printf "%s,%s,%s,%s,%s,%s,%d\n" \
            "$piece_cid" \
            "$piece_size" \
            "$root_cid" \
            "$file_size" \
            "$storage_id" \
            "$prep_id" \
            "$is_dag"
    done >> "$output_file"
done

echo "Output written to $output_file"
