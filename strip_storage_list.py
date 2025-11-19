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

    for line in lines:
        raw = line.rstrip()

        # Skip logs, empty lines, and subtables
        if (
            "WARN" in raw or
            "INFO" in raw or
            raw.strip() == "" or
            raw.startswith("    ") or
            raw.startswith("\t") or
            raw.startswith("As ")
        ):
            continue

        # Match:
        #   1    Name    Type    Path
        #   848  Name    Type
        #
        # General rule: starts with ID, followed by at least 2 more columns.
        #
        match = re.match(r"^(\d+)\s+(\S+)\s+(\S+)(?:\s+(.*))?$", raw)
        if match:
            sid, name, stype, path = match.groups()
            if path is None:
                path = ""  # union storages often have no path

            rows.append({
                "StorageID": sid,
                "StorageName": name,
                "StorageType": stype,
                "StoragePath": path.strip(),
            })

    return rows


def write_csv(rows, outfile="storages_basic.csv"):
    fieldnames = ["StorageID", "StorageName", "StorageType", "StoragePath"]
    with open(outfile, "w", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)

    print(f"CSV written to {outfile}")


def main():
    print("Running 'singularity storage list' ...")
    lines = run_storage_list()

    print("Parsing storage entries ...")
    rows = parse_storage_list(lines)

    print(f"Parsed {len(rows)} storage entries.")
    write_csv(rows)


if __name__ == "__main__":
    main()
