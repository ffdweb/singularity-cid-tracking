-- n.b. this straight from singularity
-- deals_full table is from lotus join requires more work for all deal data


/*
CREATE TABLE deals (
    DealID       BIGINT PRIMARY KEY,
    State        VARCHAR(50) NOT NULL,
    Provider     VARCHAR(50) NOT NULL,
    PieceCID     TEXT NOT NULL,
    PieceSize    BIGINT NOT NULL,
    StartEpoch   BIGINT NOT NULL,
    Price        BIGINT NOT NULL,
    Verified     BOOLEAN NOT NULL,
    ClientID     VARCHAR(50) NOT NULL
);
*/

DROP TABLE IF EXISTS deals_staging;

CREATE TABLE deals_staging (
    DealID       BIGINT,
    State        VARCHAR(50),
    Provider     VARCHAR(50),
    PieceCID     TEXT,
    PieceSize    BIGINT,
    StartEpoch   BIGINT,
    Price        BIGINT,
    Verified     BOOLEAN,
    ClientID     VARCHAR(50)
);

/*
\copy deals_staging (DealID, State, Provider, PieceCID, PieceSize, StartEpoch, Price, Verified, ClientID) FROM '/Users/brianeggert/ffpostgres/singularity-cid-tracking/etl/deals/deallist_clean.csv' WITH (FORMAT csv, HEADER true, NULL '<nil>');
*/


-- expect tens to hundreds not thousands in staging
INSERT INTO deals
SELECT * FROM deals_staging
ON CONFLICT (DealID) DO NOTHING;

-- optionally check omitted deals
SELECT s.*
FROM deals_staging s
LEFT JOIN deals d ON s.DealID = d.DealID
WHERE d.DealID IS NULL;
\copy deals_staging (DealID, State, Provider, PieceCID, PieceSize, StartEpoch, Price, Verified, ClientID) \
  FROM '/Users/brianeggert/workscripts/deallist/deallist_clean.tsv' \
  WITH (FORMAT csv, DELIMITER E'\t', HEADER true, NULL '<nil>')
