-- Issue with primary key that some preps have mysteriously duplicate pieces
-- Drop existing tables if they exist
DROP TABLE IF EXISTS pieces CASCADE;
DROP TABLE IF EXISTS pieces_staging;

-- Create final 'pieces' table (with surrogate primary key)
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

-- Create staging table (no constraints)
CREATE TABLE pieces_staging (
    PieceCID      TEXT,
    PieceSize     BIGINT,
    RootCID       TEXT,
    FileSize      BIGINT,
    StorageID     BIGINT,
    PrepID        BIGINT,
    IsDag         BOOLEAN
);

-- Load CSV into staging (run in psql shell)
-- \copy pieces_staging FROM '/Users/brianeggert/workscripts/postgres/pieces_flat.csv' WITH (FORMAT csv, HEADER true)

-- Copy all rows into final table
INSERT INTO pieces (PieceCID, PieceSize, RootCID, FileSize, StorageID, PrepID, IsDag)
SELECT * FROM pieces_staging;
