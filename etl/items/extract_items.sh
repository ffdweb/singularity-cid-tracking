#!/bin/bash

START=402
END=403
OUTFILE="items-storages.csv"

echo "storageid,identifier" > "$OUTFILE"

for storage in $(seq "$START" "$END"); do
    singularity storage explore "$storage" 2>/dev/null \
        | awk -v sid="$storage" '
            NR == 1 { next }                 # skip header
            NF == 0 { next }                 # skip empty lines
            $1 ~ /_meta\.xml$/ {
                id = $1
                sub(/_meta\.xml$/, "", id)
                if (!seen[id]++) print sid "," id
            }
        ' >> "$OUTFILE"
done
