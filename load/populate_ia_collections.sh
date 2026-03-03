#!/bin/bash
# Populate raw IA collection tables from ia search CLI, then build item_mapping tables.
# Requires: ia CLI, psql, database named 'analytics'
# Usage: bash load/populate_ia_collections.sh

set -euo pipefail

DB="analytics"

echo "Loading IA collections into raw tables..."

# ia_collections_ia_search schema
ia search -i "collection:aruba" \
    | psql -d "$DB" -c "\copy ia_collections_ia_search.aruba_raw FROM STDIN WITH (FORMAT text)"

ia search -i "collection:archiveteam_eot2024_usgovernment" \
    | psql -d "$DB" -c "\copy ia_collections_ia_search.eot_2024_ateam_usgovernment_raw FROM STDIN WITH (FORMAT text)"

ia search -i "collection:archiveteam_eot2024_voiceofamerica" \
    | psql -d "$DB" -c "\copy ia_collections_ia_search.eot_2024_ateam_voiceofamerica_raw FROM STDIN WITH (FORMAT text)"

ia search -i "collection:EndOfTerm2024InterimCrawls" \
    | psql -d "$DB" -c "\copy ia_collections_ia_search.eot_2024_interim_raw FROM STDIN WITH (FORMAT text)"

ia search -i "collection:EndOfTerm2024PostInaugurationCrawls" \
    | psql -d "$DB" -c "\copy ia_collections_ia_search.eot_2024_post_inauguration_raw FROM STDIN WITH (FORMAT text)"

ia search -i "collection:EndOfTerm2024PreElectionCrawls" \
    | psql -d "$DB" -c "\copy ia_collections_ia_search.eot_2024_pre_election_raw FROM STDIN WITH (FORMAT text)"

ia search -i "collection:EndOfTerm2024UNTCrawls" \
    | psql -d "$DB" -c "\copy ia_collections_ia_search.eot_2024_unt_raw FROM STDIN WITH (FORMAT text)"

ia search -i "collection:EndOfTerm2024WebrecorderCrawls" \
    | psql -d "$DB" -c "\copy ia_collections_ia_search.eot_2024_webrecorder_raw FROM STDIN WITH (FORMAT text)"

ia search -i "collection:rohingya-archive" \
    | psql -d "$DB" -c "\copy ia_collections_ia_search.rohingya_archive_raw FROM STDIN WITH (FORMAT text)"

ia search -i "collection:us-fbis" \
    | psql -d "$DB" -c "\copy ia_collections_ia_search.us_fbis_raw FROM STDIN WITH (FORMAT text)"

# pa_collections_ia_search schema
ia search -i "collection:35mmstockfootage" \
    | psql -d "$DB" -c "\copy pa_collections_ia_search.collection_35mmstockfootage_raw FROM STDIN WITH (FORMAT text)"

# legacy_prelinger: collection:prelinger items added before 2022-08-01
ia search -i "collection:prelinger AND addeddate:[1900-01-01 TO 2022-07-31]" \
    | psql -d "$DB" -c "\copy pa_collections_ia_search.collection_legacy_prelinger_raw FROM STDIN WITH (FORMAT text)"

# ff_prelinger: collection:prelinger items added 2022-08-01 and after
ia search -i "collection:prelinger AND addeddate:[2022-08-01 TO 9999-12-31]" \
    | psql -d "$DB" -c "\copy pa_collections_ia_search.ff_prelinger_raw FROM STDIN WITH (FORMAT text)"

echo "Raw tables loaded. Building item_mapping tables..."

psql -d "$DB" << 'SQL'

-- Populate items_all_unique (union of all raw collections)
INSERT INTO item_mapping.items_all_unique (identifier)
SELECT identifier FROM ia_collections_ia_search.aruba_raw
UNION
SELECT identifier FROM ia_collections_ia_search.eot_2024_ateam_usgovernment_raw
UNION
SELECT identifier FROM ia_collections_ia_search.eot_2024_ateam_voiceofamerica_raw
UNION
SELECT identifier FROM ia_collections_ia_search.eot_2024_interim_raw
UNION
SELECT identifier FROM ia_collections_ia_search.eot_2024_post_inauguration_raw
UNION
SELECT identifier FROM ia_collections_ia_search.eot_2024_pre_election_raw
UNION
SELECT identifier FROM ia_collections_ia_search.eot_2024_unt_raw
UNION
SELECT identifier FROM ia_collections_ia_search.eot_2024_webrecorder_raw
UNION
SELECT identifier FROM ia_collections_ia_search.rohingya_archive_raw
UNION
SELECT identifier FROM ia_collections_ia_search.us_fbis_raw
UNION
SELECT identifier FROM pa_collections_ia_search.collection_35mmstockfootage_raw
UNION
SELECT identifier FROM pa_collections_ia_search.collection_legacy_prelinger_raw
UNION
SELECT identifier FROM pa_collections_ia_search.ff_prelinger_raw
ON CONFLICT DO NOTHING;

-- Populate item_collection_map
INSERT INTO item_mapping.item_collection_map (identifier, collection)
SELECT identifier, 'aruba' FROM ia_collections_ia_search.aruba_raw
UNION ALL
SELECT identifier, 'archiveteam_eot2024_usgovernment' FROM ia_collections_ia_search.eot_2024_ateam_usgovernment_raw
UNION ALL
SELECT identifier, 'archiveteam_eot2024_voiceofamerica' FROM ia_collections_ia_search.eot_2024_ateam_voiceofamerica_raw
UNION ALL
SELECT identifier, 'eot_2024_interim' FROM ia_collections_ia_search.eot_2024_interim_raw
UNION ALL
SELECT identifier, 'eot_2024_post_inauguration' FROM ia_collections_ia_search.eot_2024_post_inauguration_raw
UNION ALL
SELECT identifier, 'eot_2024_pre_election' FROM ia_collections_ia_search.eot_2024_pre_election_raw
UNION ALL
SELECT identifier, 'eot_2024_unt_raw' FROM ia_collections_ia_search.eot_2024_unt_raw
UNION ALL
SELECT identifier, 'eot_2024_webrecorder_raw' FROM ia_collections_ia_search.eot_2024_webrecorder_raw
UNION ALL
SELECT identifier, 'rohingya_archive' FROM ia_collections_ia_search.rohingya_archive_raw
UNION ALL
SELECT identifier, 'us_fbis' FROM ia_collections_ia_search.us_fbis_raw
UNION ALL
SELECT identifier, '35mmstockfootage' FROM pa_collections_ia_search.collection_35mmstockfootage_raw
UNION ALL
SELECT identifier, 'legacy_prelinger' FROM pa_collections_ia_search.collection_legacy_prelinger_raw
UNION ALL
SELECT identifier, 'ff_prelinger' FROM pa_collections_ia_search.ff_prelinger_raw
ON CONFLICT DO NOTHING;

SQL

echo "Done."
