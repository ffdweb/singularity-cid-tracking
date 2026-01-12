DROP TABLE IF EXISTS pieces;

CREATE TABLE pieces (
    PieceCID   TEXT PRIMARY KEY,
    PieceSize  BIGINT,
    RootCID    TEXT,
    FileSize   BIGINT,
    StorageID  BIGINT REFERENCES storages(StorageID),
    PrepID     BIGINT REFERENCES preparations(PrepID),
    IsDag      BOOLEAN
);

DROP TABLE IF EXISTS pieces_staging;

CREATE TABLE pieces_staging (
    PieceCID   TEXT PRIMARY KEY,
    PieceSize  BIGINT,
    RootCID    TEXT,
    FileSize   BIGINT,
    StorageID  BIGINT,
    PrepID     BIGINT,
    IsDag      BOOLEAN
);

-- \copy pieces_staging FROM '/Users/brianeggert/workscripts/postgres/pieces_flat.csv' WITH (FORMAT csv, HEADER true)

INSERT INTO pieces (PieceCID, PieceSize, RootCID, FileSize, StorageID, PrepID, IsDag)
SELECT * FROM pieces_staging;
