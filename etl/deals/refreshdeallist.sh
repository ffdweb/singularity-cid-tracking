#!/bin/bash
set -euo pipefail

RAW_OUT="deallist.txt"
CSV_OUT="deallist_clean.csv"

PROVIDERS=(
  f02011071
  f02639429
  f03468521
)

# reset outputs
> "$RAW_OUT"
> "$CSV_OUT"

FIRST=1

for PROVIDER in "${PROVIDERS[@]}"; do
    OUTPUT=$(singularity deal list --provider "$PROVIDER")

    if [ "$FIRST" -eq 1 ]; then
        echo "$OUTPUT" >> "$RAW_OUT"
        FIRST=0
    else
        echo "$OUTPUT" | tail -n +2 >> "$RAW_OUT"
    fi
done

echo "Raw output written to $RAW_OUT"

# ---- CSV conversion ----
awk '
BEGIN {
    OFS=","
    print "DealID,State,Provider,PieceCID,PieceSize,StartEpoch,Price,Verified,ClientID"
}
NR > 1 && NF >= 8 && $1 ~ /^[0-9]+$/ {
    client = (NF >= 9 ? $9 : "")
    print $1,$2,$3,$4,$5,$6,$7,$8,client
}
' "$RAW_OUT" > "$CSV_OUT"

echo "CSV output written to $CSV_OUT"
