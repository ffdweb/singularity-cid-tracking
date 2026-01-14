/*
CREATE TABLE IF NOT EXISTS contents (
    storageid INTEGER NOT NULL,
    identifier TEXT NOT NULL,
    PRIMARY KEY (storageid, identifier)
);
*/

DROP TABLE IF EXISTS contents_staging;

CREATE UNLOGGED TABLE contents_staging (
    storageid INTEGER,
    identifier TEXT
);

/*
\copy contents_staging FROM '/Users/brianeggert/ffpostgres/singularity-cid-tracking/etl/contents/storage-contents.csv' WITH (FORMAT csv, HEADER true);
*/

INSERT INTO contents (storageid, identifier)
SELECT DISTINCT storageid, identifier
FROM contents_staging
ON CONFLICT DO NOTHING;
