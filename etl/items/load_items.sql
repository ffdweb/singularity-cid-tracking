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
