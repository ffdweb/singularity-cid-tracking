#!/usr/bin/env python3
import subprocess
import csv
import re


def run_storage_list():
    result = subprocess.run(
        ["singularity", "storage", "list"],
        capture_output=True,
        text=True
    )
    if result.returncode != 0:
        raise RuntimeError(result.stderr)
    return result.stdout.splitlines()


def parse_storage_list(lines):
    rows = []
    current_storage = {}
    in_source_block = False

    for line in lines:
        raw = line.rstrip()
        stripped = raw.strip()

        # Skip logs and irrelevant lines
        if (
            not stripped or
            any(tag in raw for tag in ("INFO", "WARN")) or
            stripped.startswith("ID   Name") or
            stripped.startswith("As Source:")
        ):
            if stripped == "As Source:":
                in_source_block = True
            continue

        # Match storage line: ID, Name, Type, [Path]
        match_storage = re.match(r"^(\d+)\s+(.+?)\s+(\S+)(?:\s+(\S.*))?$", raw)
        if match_storage and not raw.startswith(" "):
            sid, name, stype, path = match_storage.groups()
            current_storage = {
                "StorageID": int(sid),
                "StorageName": name.strip(),
                "StorageType": stype.strip(),
                "StoragePath": path.strip() if path else "",
            }
            in_source_block = False  # reset on new storage entry
            continue

        # Match source info line (if inside source block)
        if in_source_block:
            match_source = re.match(
                r"^(\d+)\s+(.+?)\s+(true|false)\s+(\d+)\s+(\d+)\s+(\d+)\s+(true|false)\s+(true|false)$", stripped
            )
            if match_source:
                (
                    src_id, src_name, del_after, max_size,
                    piece_size, min_piece, no_inline, no_dag
                ) = match_source.groups()

                row = {
                    **current_storage,
                    "IsSource": "true",
                    "SourceID": int(src_id),
                    "SourceName": src_name.strip(),
                    "SourceDeleteAfterExport": del_after,
                    "SourceMaxSize": int(max_size),
                    "SourcePieceSize": int(piece_size),
                    "SourceMinPieceSize": int(min_piece),
                    "SourceNoInline": no_inline,
                    "SourceNoDag": no_dag
                }
                rows.append(row)

    return rows


def write_csv(rows, outfile="storages_flat.csv"):
    fieldnames = [
        "StorageID", "StorageName", "StorageType", "StoragePath",
        "IsSource", "SourceID", "SourceName", "SourceDeleteAfterExport",
        "SourceMaxSize", "SourcePieceSize", "SourceMinPieceSize",
        "SourceNoInline", "SourceNoDag"
    ]
    with open(outfile, "w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)

    print(f"CSV written to {outfile}")


def report_missing_ids(rows):
    ids = sorted(set(row["StorageID"] for row in rows))
    if not ids:
        print("No StorageIDs found.")
        return

    full = set(range(ids[0], ids[-1] + 1))
    missing = sorted(full - set(ids))

    if missing:
        print("Removed IDs:", ", ".join(map(str, missing)))
    else:
        print("No missing StorageIDs.")


def main():
    print("Running 'singularity storage list' ...")
    lines = run_storage_list()

    print("Parsing storage entries and sources ...")
    rows = parse_storage_list(lines)

    print(f"Parsed {len(rows)} (storage, source) pairs.")
    report_missing_ids(rows)
    write_csv(rows)


if __name__ == "__main__":
    main()
