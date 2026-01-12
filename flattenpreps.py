#!/usr/bin/env python3
import subprocess
import csv
import re

def run_prep_list():
    result = subprocess.run(
        ["singularity", "prep", "list"],
        capture_output=True,
        text=True
    )
    if result.returncode != 0:
        raise RuntimeError(result.stderr)
    return result.stdout.splitlines()


def parse_prep_list(lines):
    rows = []
    current = None
    in_source = False
    in_output = False

    for line in lines:
        line = line.rstrip()

        # Skip database log spam
        if "WARN" in line or "INFO" in line or line.strip() == "":
            continue

        # Detect a new preparation entry:
        # Example:
        # 573  prelinger_union_10  false  33822867456  34359738368  ...
        prep_match = re.match(
            r"^(\d+)\s+(\S+)\s+(true|false)\s+(\d+)\s+(\d+)\s+(\d+)\s+(true|false)\s+(true|false)$",
            line
        )

        if prep_match:
            # If there was a previous prep, store it
            if current:
                rows.append(current)

            pid, name, del_after, max_size, piece_size, min_piece, no_inline, no_dag = prep_match.groups()

            current = {
                "PrepID": pid,
                "Name": name,
                "DeleteAfterExport": del_after,
                "MaxSize": max_size,
                "PieceSize": piece_size,
                "MinPieceSize": min_piece,
                "NoInline": no_inline,
                "NoDag": no_dag,
                "SourceStorageID": "",
                "SourceStorageName": "",
                "SourceStorageType": "",
                "SourceStoragePath": "",
                "HasOutputStorage": "false"
            }

            in_source = False
            in_output = False
            continue

        # Detect "Source Storages:" block
        if "Source Storages:" in line:
            in_source = True
            in_output = False
            continue

        # Detect "Output Storages:" block
        if "Output Storages:" in line:
            in_output = True
            in_source = False
            if current:
                current["HasOutputStorage"] = "true"
            continue

        # Parse Source Storage entry lines:
        # Example:
        #    ID   Name   Type   Path
        #    573  prelinger_union_10  union
        src_match = re.match(r"^\s+(\d+)\s+(\S+)\s+(\S+)(?:\s+(.*))?$", line)
        if src_match and current and in_source:
            sid, sname, stype, spath = src_match.groups()
            spath = spath or ""
            current["SourceStorageID"] = sid
            current["SourceStorageName"] = sname
            current["SourceStorageType"] = stype
            current["SourceStoragePath"] = spath
            continue

        # Ignore Output storage details per your request

    # Add the last record
    if current:
        rows.append(current)

    return rows


def write_csv(rows, outfile="preps_flat.csv"):
    fieldnames = [
        "PrepID", "Name", "DeleteAfterExport", "MaxSize", "PieceSize",
        "MinPieceSize", "NoInline", "NoDag",
        "SourceStorageID", "SourceStorageName",
        "SourceStorageType", "SourceStoragePath",
        "HasOutputStorage"
    ]
    with open(outfile, "w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)
    print(f"✅ CSV written to {outfile}")


def main():
    print("⏳ Running 'singularity prep list' ...")
    lines = run_prep_list()
    print("⏳ Parsing ...")
    rows = parse_prep_list(lines)
    print(f"📦 Parsed {len(rows)} preparations.")
    write_csv(rows)


if __name__ == "__main__":
    main()
