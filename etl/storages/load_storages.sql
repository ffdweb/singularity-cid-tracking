/* if starting fresh

DROP TABLE IF EXISTS storages;

CREATE TABLE IF NOT EXISTS storages (
    StorageID   BIGINT PRIMARY KEY,
    StorageName TEXT NOT NULL,
    StorageType TEXT,
    StoragePath TEXT
);

*/

DROP TABLE IF EXISTS storages_staging;

CREATE TABLE storages_staging (
    StorageID                BIGINT,
    StorageName              TEXT,
    StorageType              TEXT,
    StoragePath              TEXT,
    IsSource                 BOOLEAN,
    SourceID                 BIGINT,
    SourceName               TEXT,
    SourceDeleteAfterExport  BOOLEAN,
    SourceMaxSize            BIGINT,
    SourcePieceSize          BIGINT,
    SourceMinPieceSize       BIGINT,
    SourceNoInline           BOOLEAN,
    SourceNoDag              BOOLEAN
);

/*run below in psql session

\copy storages_staging FROM '/Users/brianeggert/ffpostgres/singularity-cid-tracking/etl/storages/storages_flat.csv' WITH (FORMAT csv, HEADER true);

*/

INSERT INTO storages (StorageID, StorageName, StorageType, StoragePath)
SELECT DISTINCT ON (StorageID)
    StorageID, StorageName, StorageType, StoragePath
FROM storages_staging
WHERE StorageID NOT IN (SELECT StorageID FROM storages)
ORDER BY StorageID;
