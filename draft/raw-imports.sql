--come back and make staging tables for these

CREATE TABLE prep_list_raw (
    PrepID              INTEGER,
    Name                TEXT,
    DeleteAfterExport   BOOLEAN,
    MaxSize             BIGINT,
    PieceSize           BIGINT,
    MinPieceSize        BIGINT,
    NoInline            BOOLEAN,
    NoDag               BOOLEAN,
    SourceStorageID     INTEGER,
    SourceStorageName   TEXT,
    SourceStorageType   TEXT,
    SourceStoragePath   TEXT,
    HasOutputStorage    BOOLEAN
);

CREATE TABLE storages_raw_basic (
    StorageID      INTEGER,
    StorageName    TEXT,
    StorageType    TEXT,
    StoragePath    TEXT
);

DROP TABLE IF EXISTS deals_raw;

CREATE TABLE deals_raw (
    DealID        BIGINT,
    State         TEXT,
    Provider      TEXT,
    PieceCID      TEXT,
    PieceSize     BIGINT,
    StartEpoch    BIGINT,
    Price         BIGINT,
    Verified      BOOLEAN,
    ClientID      TEXT
);

CREATE TABLE deals_full (
    DealID                BIGINT,
    PieceCID              TEXT,
    PieceSize             BIGINT,
    VerifiedDeal          BOOLEAN,
    Client                TEXT,
    Provider              TEXT,
    Label                 TEXT,
    StartEpoch            BIGINT,
    EndEpoch              BIGINT,
    StoragePricePerEpoch  BIGINT,
    ProviderCollateral    BIGINT,
    ClientCollateral      BIGINT,
    SectorNumber          BIGINT,
    SectorStartEpoch      BIGINT,
    LastUpdatedEpoch      BIGINT,
    SlashEpoch            BIGINT
);

CREATE TABLE collection_35mmstockfootage_raw (
    identifier TEXT PRIMARY KEY
);


\copy collection_35mmstockfootage_raw FROM '/users/brianeggert/35mmstockfootage-identifiers.txt' WITH (FORMAT text);
-- collection_35mmstockfootage_raw 1602
-- collection_legacy_prelinger_raw 8710
-- collection_aruba_raw 182638
-- us_fbis_raw 16293
-- rohingya_archive_raw 9
-- eot_2024_pre_election_raw 13635
-- eot_2024_interim_raw 27051
-- eot_2024_post_inauguration_raw 28306
-- archiveteam_eot2024_usgovernment_raw 80765
-- archiveteam_eot2024_voiceofamerica_raw 36367
-- eot_2024_unt_raw 1577
-- eot_2024_webrecorder_raw 386
-- ff_prelinger_raw 1453

CREATE TABLE items_all_unique (
    identifier TEXT PRIMARY KEY
);

INSERT INTO items_all_unique (identifier)
SELECT identifier FROM collection_35mmstockfootage_raw
UNION
SELECT identifier FROM collection_legacy_prelinger_raw
UNION
SELECT identifier FROM collection_aruba_raw
UNION
SELECT identifier FROM us_fbis_raw
UNION
SELECT identifier FROM rohingya_archive_raw
UNION
SELECT identifier FROM eot_2024_pre_election_raw
UNION
SELECT identifier FROM eot_2024_interim_raw
UNION
SELECT identifier FROM eot_2024_post_inauguration_raw
UNION
SELECT identifier FROM archiveteam_eot2024_usgovernment_raw
UNION
SELECT identifier FROM archiveteam_eot2024_voiceofamerica_raw
UNION
SELECT identifier FROM eot_2024_unt_raw
UNION
SELECT identifier FROM eot_2024_webrecorder_raw
UNION
SELECT identifier FROM ff_prelinger_raw;

-- 398791 total

CREATE TABLE unionname_prelinger_union_1 (identifier TEXT PRIMARY KEY);

-- script to extract union contents from parsing _meta.xml filenames uploaded
