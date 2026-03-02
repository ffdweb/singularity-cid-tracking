#!/bin/bash
set -euo pipefail

# -------- CONFIG --------
PREP_CSV="/Users/brianeggert/ffpostgres/singularity-cid-tracking/etl/preps/preps_flat.csv"
OUTPUT_CSV="pieces_flat.csv"
# ------------------------

echo "PieceCID,PieceSize,RootCID,FileSize,StorageID,PrepID,IsDag,StorageName" > "$OUTPUT_CSV"

# Extract prep IDs in file order, skipping header
awk -F',' 'NR > 1 { print $1 }' "$PREP_CSV" | while read -r prep_id; do
    echo "Processing PrepID $prep_id ..." >&2

    output=$(timeout 10s singularity prep list-pieces "$prep_id" 2>/dev/null || true)
    [[ -z "$output" ]] && continue

    storage_id=$(echo "$output" | awk '/AttachmentID/ { getline; print $2; exit }')
    storage_name=$(echo "$output" | awk '
        /SourceStorage/ { in_block=1; next }
        in_block && /^[[:space:]]+[0-9]+/ { print $2; exit }
    ')

    # Fallbacks if not found
    [[ -z "$storage_id" ]] && storage_id=0
    [[ -z "$storage_name" ]] && storage_name="unknown"

    echo "$output" | awk -v storage_id="$storage_id" -v prep_id="$prep_id" -v storage_name="$storage_name" '
        $0 ~ /baga/ {
            # Trim leading/trailing whitespace
            gsub(/^[ \t]+|[ \t]+$/, "", $0)
            num_fields = split($0, fields, /[[:space:]]+/)

            # Expect either 5 or 6 fields: with or without PieceType
            if (num_fields == 6) {
                piece_type = fields[1]
                piece_cid = fields[2]
                piece_size = fields[3]
                root_cid = fields[4]
                file_size = fields[5]
            } else if (num_fields == 5) {
                piece_type = ""
                piece_cid = fields[1]
                piece_size = fields[2]
                root_cid = fields[3]
                file_size = fields[4]
            } else {
                # Malformed line, skip
                next
            }

            is_dag = (piece_type == "dag") ? 1 : 0

            printf "%s,%s,%s,%s,%s,%s,%d,%s\n", \
                piece_cid, piece_size, root_cid, file_size, storage_id, prep_id, is_dag, storage_name
        }
    ' >> "$OUTPUT_CSV"
done

echo "Done. Output written to $OUTPUT_CSV"
