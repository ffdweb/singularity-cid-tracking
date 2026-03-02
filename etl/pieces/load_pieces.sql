DROP TABLE IF EXISTS pieces;

CREATE TABLE pieces (
    piece_cid      TEXT NOT NULL,
    piece_size     BIGINT NOT NULL,
    root_cid       TEXT NOT NULL,
    file_size      BIGINT NOT NULL,
    storage_id     BIGINT NOT NULL REFERENCES storages(StorageID),
    preparation_id BIGINT NOT NULL REFERENCES preparations(PrepID),
    is_dag         BOOLEAN NOT NULL,
    storage_name   TEXT,
    PRIMARY KEY (piece_cid, preparation_id)
);

DROP TABLE IF EXISTS pieces_staging;

CREATE TABLE pieces_staging (
    piece_cid      TEXT,
    piece_size     BIGINT,
    root_cid       TEXT,
    file_size      BIGINT,
    storage_id     BIGINT,
    preparation_id BIGINT,
    is_dag         BOOLEAN,
    storage_name   TEXT
);

\copy pieces_staging FROM '/Users/brianeggert/ffpostgres/singularity-cid-tracking/etl/pieces/pieces_flat.csv' WITH (FORMAT csv, HEADER true)

INSERT INTO pieces (
    piece_cid,
    piece_size,
    root_cid,
    file_size,
    storage_id,
    preparation_id,
    is_dag,
    storage_name
)
SELECT DISTINCT ON (piece_cid, preparation_id)
    piece_cid,
    piece_size,
    root_cid,
    file_size,
    storage_id,
    preparation_id,
    is_dag,
    storage_name
FROM pieces_staging
WHERE piece_cid IS NOT NULL
ORDER BY piece_cid, preparation_id
ON CONFLICT (piece_cid, preparation_id) DO NOTHING;
