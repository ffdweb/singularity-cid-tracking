#!/bin/bash

START=399
END=405
OUTFILE="storage-contents.csv"

echo "storageid,identifier" > "$OUTFILE"

for storage in $(seq "$START" "$END"); do
    timeout 10s singularity storage explore "$storage" 2>/dev/null \
        | awk -v sid="$storage" '
            NR == 1 { next }
            NF == 0 { next }
            $1 ~ /_meta\.xml$/ {
                id = $1
                sub(/_meta\.xml$/, "", id)
                if (!seen[id]++) print sid "," id
            }
        ' >> "$OUTFILE"

    if [ $? -eq 124 ]; then
        echo "storage $storage timed out" >&2
    fi
done
