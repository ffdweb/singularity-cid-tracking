/* if starting fresh

DROP TABLE IF EXISTS preparations;

CREATE TABLE IF NOT EXISTS preparations (
    PrepID     BIGINT PRIMARY KEY,
    Name       TEXT NOT NULL,
    StorageID  BIGINT NOT NULL REFERENCES storages(StorageID),
    DeleteAfterExport BOOLEAN,
    MaxSize     BIGINT,
    PieceSize   BIGINT,
    MinPieceSize BIGINT,
    NoInline    BOOLEAN,
    NoDag       BOOLEAN,
    HasOutputStorage BOOLEAN
);

*/

DROP TABLE IF EXISTS preparations_staging;

CREATE TABLE preparations_staging (
    PrepID     BIGINT,
    Name       TEXT,
    DeleteAfterExport BOOLEAN,
    MaxSize     BIGINT,
    PieceSize   BIGINT,
    MinPieceSize BIGINT,
    NoInline    BOOLEAN,
    NoDag       BOOLEAN,
    SourceStorageID BIGINT,
    SourceStorageName TEXT,
    SourceStorageType TEXT,
    SourceStoragePath TEXT,
    HasOutputStorage BOOLEAN
);

/* run in psql session

\copy preparations_staging FROM '/Users/brianeggert/ffpostgres/singularity-cid-tracking/etl/preps/preps_flat.csv' WITH (FORMAT csv, HEADER true)

*/

INSERT INTO preparations (
    PrepID, Name, StorageID,
    DeleteAfterExport, MaxSize, PieceSize,
    MinPieceSize, NoInline, NoDag, HasOutputStorage
)
SELECT
    PrepID, Name, SourceStorageID,
    DeleteAfterExport, MaxSize, PieceSize,
    MinPieceSize, NoInline, NoDag, HasOutputStorage
FROM preparations_staging
ON CONFLICT (PrepID) DO NOTHING;
