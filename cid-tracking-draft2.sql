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


psql "host=onchain-analytics.cdzlqpobahpk.us-east-2.rds.amazonaws.com port=5432 user=brian dbname=analytics sslmode=verify-full sslrootcert=$HOME/.rds-us-east-2.pem" \
-c "\copy deals (DealID, State, Provider, PieceCID, PieceSize, StartEpoch, Price, Verified, ClientID) \
    FROM '/Users/brianeggert/deallist_clean.tsv' \
    WITH (FORMAT csv, DELIMITER E'\t', HEADER true, NULL '<nil>')"


CREATE TABLE clients (
    ClientID      VARCHAR(20) PRIMARY KEY,  -- f0...
    ClientAddress TEXT NOT NULL,            -- f1...
    Active        BOOLEAN NOT NULL,         -- true/false
    ClientOwner   VARCHAR(10) NOT NULL      -- 'PA' or 'IA'
);


INSERT INTO clients (ClientID, ClientAddress, Active, ClientOwner) VALUES
('f02208630', 'f1i2reokfclrqls5mkgtbqk5esvj6it7nykv7c57y', true,  'PA'),
('f03091977', 'f1hnvljphtrpwb6pxszxoh7k57br7goo33s6b22ry', true,  'PA'),
('f01131298', 'f1wp6zoxj7sydnrywvzp276x3gayghi7r6le4tcwy', false, 'IA'),
('f03510418', 'f1skjgotikvvlx3uzhzltiq2ejmwdmtxt5doa5vpy', false, 'IA');


CREATE TABLE pieces (
    PieceCID    TEXT NOT NULL,
    PieceSize   BIGINT NOT NULL,
    RootCID     TEXT NOT NULL,
    FileSize    BIGINT NOT NULL,
    StorageID   BIGINT NOT NULL,
    PrepID      BIGINT NOT NULL,
    IsDag       BOOLEAN NOT NULL,
    PRIMARY KEY (PieceCID, PrepID, StorageID)
);


DROP TABLE IF EXISTS pieces_staging;


CREATE TABLE pieces_staging (
    PieceCID    TEXT NOT NULL,
    PieceSize   BIGINT NOT NULL,
    RootCID     TEXT NOT NULL,
    FileSize    BIGINT NOT NULL,
    StorageID   BIGINT NOT NULL,
    PrepID      BIGINT NOT NULL,
    IsDag       BOOLEAN NOT NULL
);


\copy pieces_staging (PieceCID, PieceSize, RootCID, FileSize, StorageID, PrepID, IsDag) FROM '/Users/brianeggert/pieces.csv' WITH (FORMAT csv, HEADER true)


INSERT INTO pieces
SELECT *
FROM pieces_staging
ON CONFLICT (PieceCID, PrepID, StorageID) DO NOTHING;


CREATE TABLE pieces (
    PieceCID    TEXT NOT NULL,
    PieceSize   BIGINT NOT NULL,
    RootCID     TEXT NOT NULL,
    FileSize    BIGINT NOT NULL,
    StorageID   BIGINT NOT NULL,
    PrepID      BIGINT NOT NULL,
    IsDag       BOOLEAN NOT NULL,
    PRIMARY KEY (PieceCID, PrepID, StorageID)
);


-- This query finds the rows in pieces_staging that were NOT inserted into pieces
-- because they were duplicates of an existing (PieceCID, PrepID, StorageID).
-- In other words, it shows you exactly which rows were skipped by
--   INSERT ... ON CONFLICT DO NOTHING

SELECT ps.*
FROM pieces_staging ps
LEFT JOIN pieces p
  ON ps.PieceCID  = p.PieceCID
 AND ps.PrepID    = p.PrepID
 AND ps.StorageID = p.StorageID
WHERE p.PieceCID IS NOT NULL;



