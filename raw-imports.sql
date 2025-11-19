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
