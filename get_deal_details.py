#!/usr/bin/env python3
import subprocess
import json
import csv
from pathlib import Path
import argparse


def flatten_deal_json(deal_json):
    """Flatten the nested structure from lotus state get-deal output."""
    proposal = deal_json.get("Proposal", {})
    state = deal_json.get("State", {})

    flat = {
        "PieceCID": proposal.get("PieceCID", {}).get("/", ""),
        "PieceSize": proposal.get("PieceSize"),
        "VerifiedDeal": proposal.get("VerifiedDeal"),
        "Client": proposal.get("Client"),
        "Provider": proposal.get("Provider"),
        "Label": proposal.get("Label"),
        "StartEpoch": proposal.get("StartEpoch"),
        "EndEpoch": proposal.get("EndEpoch"),
        "StoragePricePerEpoch": proposal.get("StoragePricePerEpoch"),
        "ProviderCollateral": proposal.get("ProviderCollateral"),
        "ClientCollateral": proposal.get("ClientCollateral"),
        "SectorNumber": state.get("SectorNumber"),
        "SectorStartEpoch": state.get("SectorStartEpoch"),
        "LastUpdatedEpoch": state.get("LastUpdatedEpoch"),
        "SlashEpoch": state.get("SlashEpoch"),
    }

    return flat


def get_deal_info(deal_id):
    """Run `lotus state get-deal <id>` and return parsed JSON."""
    result = subprocess.run(
        ["lotus", "state", "get-deal", str(deal_id)],
        capture_output=True,
        text=True
    )
    if result.returncode != 0:
        raise RuntimeError(f"Error fetching deal {deal_id}: {result.stderr.strip()}")

    return json.loads(result.stdout)


def main():
    parser = argparse.ArgumentParser(
        description="Export detailed Filecoin deal info for a list of deal IDs."
    )
    parser.add_argument("input_file", type=Path, help="File with one deal ID per line")
    parser.add_argument("--csv", dest="csv_file", type=Path, default="deals_full.csv", help="Output CSV file")
    args = parser.parse_args()

    # --- Read deal IDs ---
    with open(args.input_file, "r") as f:
        deal_ids = [line.strip() for line in f if line.strip().isdigit()]

    print(f" Processing {len(deal_ids)} deals...\n")

    # --- Gather data ---
    all_rows = []
    for deal_id in deal_ids:
        try:
            deal_json = get_deal_info(int(deal_id))
            flat = flatten_deal_json(deal_json)
            flat["DealID"] = deal_id
            all_rows.append(flat)
            print(f"✅ {deal_id}")
        except Exception as e:
            print(f"❌ {deal_id}: {e}")

    # --- Write CSV ---
    if all_rows:
        fieldnames = [
            "DealID", "PieceCID", "PieceSize", "VerifiedDeal", "Client", "Provider",
            "Label", "StartEpoch", "EndEpoch", "StoragePricePerEpoch",
            "ProviderCollateral", "ClientCollateral", "SectorNumber",
            "SectorStartEpoch", "LastUpdatedEpoch", "SlashEpoch"
        ]
        with open(args.csv_file, "w", newline="") as f:
            writer = csv.DictWriter(f, fieldnames=fieldnames)
            writer.writeheader()
            writer.writerows(all_rows)
        print(f"\n✅ Results saved to {args.csv_file}")
    else:
        print("\n⚠️ No valid deal data to write.")


if __name__ == "__main__":
    main()
