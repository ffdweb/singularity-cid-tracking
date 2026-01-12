#!/usr/bin/env python3
import subprocess
import csv
import re


def run_list_pieces(prep_id):
    result = subprocess.run(
        ["singularity", "prep", "list-pieces", str(prep_id)],
        capture_output=True,
        text=True
    )
    if result.returncode != 0:
        raise RuntimeError(f"Error running list-pieces for {prep_id}:\n{result.stderr}")
    return result.stdout.splitlines()


def parse_list_pieces(lines, prep_id):
    rows = []
    current_storage_id = None
    in_pieces_block = False

    for line in lines:
        line = line.strip()

        if not line or "INFO" in line or "WARN" in line:
            continue

        # Detect and store SourceStorageID
        m = re.match(r"^(\d+)\s+(\d+)$", line)
        if m:
            _, current_storage_id = m.groups()
            continue

        # Detect start of pieces block
        if line.startswith("Pieces"):
            in_pieces_block = True
            continue

        if in_pieces_block:
            # Match: PieceCID, PieceSize, RootCID, FileSize, (ignore padding)
            m = re.match(
                r"^(\S+)\s+(\d+)\s+(\S+)\s+(\d+)",
                line
            )
            if m:
                piece_cid, piece_size, root_cid, file_size = m.groups()
                rows.append({
                    "PieceCID": piece_cid,
                    "PieceSize": int(piece_size),
                    "RootCID": root_cid,
                    "FileSize": int(file_size),
                    "StorageID": int(current_storage_id),
                    "PrepID": int(prep_id),
                    "IsDag": False  # No reliable signal unless present elsewhere
                })

    return rows


def read_prep_ids(prep_csv="preps_flat.csv"):
    ids = []
    with open(prep_csv, newline="") as f:
        reader = csv.DictReader(f)
        for row in reader:
            ids.append(row["PrepID"])
    return ids


def write_output(rows, output_csv="pieces_flat.csv"):
    fieldnames = ["PieceCID", "PieceSize", "RootCID", "FileSize", "StorageID", "PrepID", "IsDag"]
    with open(output_csv, "w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)
    print(f"✅ Wrote {len(rows)} rows to {output_csv}")


def main():
    all_rows = []
    prep_ids = read_prep_ids()

    for pid in prep_ids:
        print(f"📦 Processing PrepID {pid} ...")
        try:
            lines = run_list_pieces(pid)
            rows = parse_list_pieces(lines, pid)
            all_rows.extend(rows)
        except Exception as e:
            print(f"⚠️ Skipping PrepID {pid}: {e}")

    write_output(all_rows)


if __name__ == "__main__":
    main()
