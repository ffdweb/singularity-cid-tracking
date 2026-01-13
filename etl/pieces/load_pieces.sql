-- Issue with primary key that some preps have duplicate pieces
-- Create final pieces table with surrogate primary key (record id)

/*
DROP TABLE IF EXISTS pieces CASCADE;

CREATE TABLE pieces (
    PieceRecordID SERIAL PRIMARY KEY,
    PieceCID      TEXT,
    PieceSize     BIGINT,
    RootCID       TEXT,
    FileSize      BIGINT,
    StorageID     BIGINT REFERENCES storages(StorageID),
    PrepID        BIGINT REFERENCES preparations(PrepID),
    IsDag         BOOLEAN
);
*/


DROP TABLE IF EXISTS pieces_staging;

CREATE TABLE pieces_staging (
    PieceCID      TEXT,
    PieceSize     BIGINT,
    RootCID       TEXT,
    FileSize      BIGINT,
    StorageID     BIGINT,
    PrepID        BIGINT,
    IsDag         BOOLEAN
);


/*

\copy pieces_staging FROM  '/Users/brianeggert/ffpostgres/singularity-cid-tracking/etl/pieces/pieces_flat.csv' WITH (FORMAT csv, HEADER true)

*/


INSERT INTO pieces (PieceCID, PieceSize, RootCID, FileSize, StorageID, PrepID, IsDag)
SELECT * FROM pieces_staging;
