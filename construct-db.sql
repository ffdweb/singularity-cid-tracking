-- PIECES

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


\copy pieces_staging (PieceCID, PieceSize, RootCID, FileSize, StorageID, PrepID, IsDag) FROM '/Users/brianeggert/workscripts/postgres/pieces.csv' WITH (FORMAT csv, HEADER true)


INSERT INTO pieces
SELECT *
FROM pieces_staging
ON CONFLICT (PieceCID, PrepID, StorageID) DO NOTHING;


-- check which rows were excluded
SELECT ps.*
FROM pieces_staging ps
LEFT JOIN pieces p
  ON ps.PieceCID  = p.PieceCID
 AND ps.PrepID    = p.PrepID
 AND ps.StorageID = p.StorageID
WHERE p.PieceCID IS NOT NULL;


-- STORAGES
-- Can come back to this and use staging like preparations below
CREATE TABLE IF NOT EXISTS storages (
    StorageID   BIGINT PRIMARY KEY,
    StorageName TEXT NOT NULL,
    Type        TEXT,
    Path        TEXT
);


\copy storages (StorageID, StorageName, Type, Path) FROM '/Users/brianeggert/storages.csv' WITH (FORMAT csv, HEADER false)


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

-- not sure why some storage ids are not in storages table. I think they are corrupt somehow because it is not possible to delete
-- a storage that is attached to an existing prep

INSERT INTO preparations (PrepID, Name, StorageID)
SELECT ps.PrepID, ps.Name, ps.StorageID
FROM preparations_staging ps
WHERE EXISTS (
    SELECT 1 FROM storages s WHERE s.StorageID = ps.StorageID
)
ON CONFLICT (PrepID) DO NOTHING;


-- ITEMS

CREATE TABLE IF NOT EXISTS items (
    Identifier     TEXT PRIMARY KEY,                 -- IA item identifier
    ItemSizeGiB    NUMERIC(12,3),                    -- size in GiB from IA list
    PreparationID  BIGINT REFERENCES preparations(PrepID), -- FK to preparations
    PiecesCount    INT,                              -- number of pieces
    PackedSizeGiB  NUMERIC(12,3)                     -- sum of piece sizes
);

DROP TABLE IF EXISTS items_staging;

CREATE TABLE items_staging (
    Identifier     TEXT,
    ItemSizeGiB    NUMERIC(12,3),
    PreparationID  BIGINT,
    PiecesCount    INT,
    PackedSizeGiB  NUMERIC(12,3)
);

\copy items_staging (Identifier, ItemSizeGiB, PreparationID, PiecesCount, PackedSizeGiB) FROM '/Users/brianeggert/items.csv' WITH (FORMAT csv, HEADER true);

INSERT INTO items (Identifier, ItemSizeGiB, PreparationID, PiecesCount, PackedSizeGiB)
SELECT i.Identifier, i.ItemSizeGiB, i.PreparationID, i.PiecesCount, i.PackedSizeGiB
FROM items_staging i
WHERE EXISTS (
    SELECT 1 FROM preparations p WHERE p.PrepID = i.PreparationID
)
ON CONFLICT (Identifier) DO NOTHING;

