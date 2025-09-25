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
    PieceCID    TEXT PRIMARY KEY,        -- content-addressed, long hash
    PrepID      BIGINT NOT NULL,         -- FK to preparations (many-to-many in practice)
    PieceType   VARCHAR(10),             -- 'data' or 'dag' (optional, nullable)
    IsDag       BOOLEAN NOT NULL,        -- from script (0/1 → f/t)
    StorageID   BIGINT NOT NULL,         -- FK, numeric ID from script
    RootCID     TEXT NOT NULL,           -- another content-addressed hash
    FileSize    BIGINT NOT NULL,         -- raw file size in bytes
    PieceSize   BIGINT NOT NULL          -- padded piece size
);

