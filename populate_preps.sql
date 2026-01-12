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

-- run db_prep_report.sh

/*
\copy preparations_staging (PrepID, Name, StorageID) FROM '/Users/brianeggert/preparations.csv' WITH (FORMAT csv, HEADER true)
*/

INSERT INTO preparations
SELECT * FROM preparations_staging
ON CONFLICT (PrepID) DO NOTHING;

/*
SELECT ps.*
FROM preparations_staging ps
LEFT JOIN preparations p ON ps.PrepID = p.PrepID
WHERE p.PrepID IS NOT NULL;
*/
