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
