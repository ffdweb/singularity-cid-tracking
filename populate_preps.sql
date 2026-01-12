-- PREPARATIONS

CREATE TABLE IF NOT EXISTS preparations (
    PrepID    BIGINT PRIMARY KEY,
    Name      TEXT NOT NULL,
    StorageID BIGINT REFERENCES storages(StorageID)
);

DROP TABLE IF EXISTS preparations_staging;

CREATE TABLE preparations_staging (
    PrepID    BIGINT,
    Name      TEXT,
    StorageID BIGINT
);


\copy preparations_staging (PrepID, Name, StorageID) FROM '/Users/brianeggert/preparations.csv' WITH (FORMAT csv, HEADER true);
