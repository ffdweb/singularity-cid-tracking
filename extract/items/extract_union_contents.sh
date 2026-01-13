#!/bin/bash
storage="$1"

singularity storage explore "$storage" \
    | awk '
        NR == 1 { next }                  # (1) skip header row
        NF == 0 { next }                  # (2) skip empty lines
        $1 ~ /_meta\.xml$/ {
            id = $1
            sub(/_meta\.xml$/, "", id)
            if (!seen[id]++) print id
        }
    ' > "${storage}.txt"
