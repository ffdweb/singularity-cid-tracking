#!/bin/bash

# Usage: ./db_piece_report.sh 1-3 5 7-9
# Output is saved to pieces.csv

# Actual command used:
#
# bash db_piece_report.sh \
# 1 2 3 4 5 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 \
# 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 \
# 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 75 76 77 78 79 80 81 82 83 84 85 86 87 \
# 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 \
# 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 \
# 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 \
# 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 184 185 186 187 188 \
# 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 \
# 212 213 214 215 216 217 218 219 220 222 224 225 227 228 387 389 390 392 393 394 396 400 409 \
# 410 419 423 428 436 572 590 626 639 672 689 691

output_file="pieces.csv"
: > "$output_file"

# Write CSV header row
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

        # Output as CSV row
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
