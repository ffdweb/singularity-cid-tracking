-- item_mapping schema
-- Maps IA identifiers to collections and Singularity union storage names.
-- items_all_unique must be populated before item_collection_map or prelinger_union_map.

CREATE SCHEMA IF NOT EXISTS item_mapping;

CREATE TABLE IF NOT EXISTS item_mapping.items_all_unique (
    identifier text NOT NULL,
    PRIMARY KEY (identifier)
);

CREATE TABLE IF NOT EXISTS item_mapping.item_collection_map (
    identifier text NOT NULL,
    collection text NOT NULL,
    PRIMARY KEY (identifier, collection),
    FOREIGN KEY (identifier) REFERENCES item_mapping.items_all_unique(identifier)
);

CREATE TABLE IF NOT EXISTS item_mapping.prelinger_union_map (
    identifier text NOT NULL,
    unionname  text NOT NULL,
    PRIMARY KEY (identifier, unionname),
    FOREIGN KEY (identifier) REFERENCES item_mapping.items_all_unique(identifier)
);

-- Prelinger prep data imported from Google Sheets (no PK, may have duplicates)
CREATE TABLE IF NOT EXISTS item_mapping.prelinger_preps_gsheets (
    identifier    text,
    itemsizegib   numeric(12,3),
    preparationid bigint,
    piecescount   integer,
    packedsizegib numeric(12,3)
);

-- Utility table used by vw_input_identifier_* views.
-- Holds a single IA identifier to query against pieces and deal status.
CREATE TABLE IF NOT EXISTS public.input_identifier (
    my_identifier text
);
