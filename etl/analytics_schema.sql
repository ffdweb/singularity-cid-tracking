--
-- PostgreSQL database dump
--

\restrict CYDiDcaJCelHivsXBtMQmKRk7JXGlyuSpzAeAujsiIthB7DCpyMGJpNV8UvZ7o5

-- Dumped from database version 16.8
-- Dumped by pg_dump version 18.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: ia_collections_ia_search; Type: SCHEMA; Schema: -; Owner: brian
--

CREATE SCHEMA ia_collections_ia_search;


ALTER SCHEMA ia_collections_ia_search OWNER TO brian;

--
-- Name: item_mapping_collections_unions; Type: SCHEMA; Schema: -; Owner: brian
--

CREATE SCHEMA item_mapping_collections_unions;


ALTER SCHEMA item_mapping_collections_unions OWNER TO brian;

--
-- Name: lotus_import; Type: SCHEMA; Schema: -; Owner: brian
--

CREATE SCHEMA lotus_import;


ALTER SCHEMA lotus_import OWNER TO brian;

--
-- Name: pa_collections_ia_search; Type: SCHEMA; Schema: -; Owner: brian
--

CREATE SCHEMA pa_collections_ia_search;


ALTER SCHEMA pa_collections_ia_search OWNER TO brian;

--
-- Name: singularity_raw; Type: SCHEMA; Schema: -; Owner: brian
--

CREATE SCHEMA singularity_raw;


ALTER SCHEMA singularity_raw OWNER TO brian;

--
-- Name: union_contents_manual; Type: SCHEMA; Schema: -; Owner: brian
--

CREATE SCHEMA union_contents_manual;


ALTER SCHEMA union_contents_manual OWNER TO brian;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: aruba_raw; Type: TABLE; Schema: ia_collections_ia_search; Owner: brian
--

CREATE TABLE ia_collections_ia_search.aruba_raw (
    identifier text NOT NULL
);


ALTER TABLE ia_collections_ia_search.aruba_raw OWNER TO brian;

--
-- Name: eot_2024_ateam_usgovernment_raw; Type: TABLE; Schema: ia_collections_ia_search; Owner: brian
--

CREATE TABLE ia_collections_ia_search.eot_2024_ateam_usgovernment_raw (
    identifier text NOT NULL
);


ALTER TABLE ia_collections_ia_search.eot_2024_ateam_usgovernment_raw OWNER TO brian;

--
-- Name: eot_2024_ateam_voiceofamerica_raw; Type: TABLE; Schema: ia_collections_ia_search; Owner: brian
--

CREATE TABLE ia_collections_ia_search.eot_2024_ateam_voiceofamerica_raw (
    identifier text NOT NULL
);


ALTER TABLE ia_collections_ia_search.eot_2024_ateam_voiceofamerica_raw OWNER TO brian;

--
-- Name: eot_2024_interim_raw; Type: TABLE; Schema: ia_collections_ia_search; Owner: brian
--

CREATE TABLE ia_collections_ia_search.eot_2024_interim_raw (
    identifier text NOT NULL
);


ALTER TABLE ia_collections_ia_search.eot_2024_interim_raw OWNER TO brian;

--
-- Name: eot_2024_post_inauguration_raw; Type: TABLE; Schema: ia_collections_ia_search; Owner: brian
--

CREATE TABLE ia_collections_ia_search.eot_2024_post_inauguration_raw (
    identifier text NOT NULL
);


ALTER TABLE ia_collections_ia_search.eot_2024_post_inauguration_raw OWNER TO brian;

--
-- Name: eot_2024_pre_election_raw; Type: TABLE; Schema: ia_collections_ia_search; Owner: brian
--

CREATE TABLE ia_collections_ia_search.eot_2024_pre_election_raw (
    identifier text NOT NULL
);


ALTER TABLE ia_collections_ia_search.eot_2024_pre_election_raw OWNER TO brian;

--
-- Name: eot_2024_unt_raw; Type: TABLE; Schema: ia_collections_ia_search; Owner: brian
--

CREATE TABLE ia_collections_ia_search.eot_2024_unt_raw (
    identifier text NOT NULL
);


ALTER TABLE ia_collections_ia_search.eot_2024_unt_raw OWNER TO brian;

--
-- Name: eot_2024_webrecorder_raw; Type: TABLE; Schema: ia_collections_ia_search; Owner: brian
--

CREATE TABLE ia_collections_ia_search.eot_2024_webrecorder_raw (
    identifier text NOT NULL
);


ALTER TABLE ia_collections_ia_search.eot_2024_webrecorder_raw OWNER TO brian;

--
-- Name: rohingya_archive_raw; Type: TABLE; Schema: ia_collections_ia_search; Owner: brian
--

CREATE TABLE ia_collections_ia_search.rohingya_archive_raw (
    identifier text NOT NULL
);


ALTER TABLE ia_collections_ia_search.rohingya_archive_raw OWNER TO brian;

--
-- Name: us_fbis_raw; Type: TABLE; Schema: ia_collections_ia_search; Owner: brian
--

CREATE TABLE ia_collections_ia_search.us_fbis_raw (
    identifier text NOT NULL
);


ALTER TABLE ia_collections_ia_search.us_fbis_raw OWNER TO brian;

--
-- Name: item_collection_map; Type: TABLE; Schema: item_mapping_collections_unions; Owner: brian
--

CREATE TABLE item_mapping_collections_unions.item_collection_map (
    identifier text NOT NULL,
    collection text NOT NULL
);


ALTER TABLE item_mapping_collections_unions.item_collection_map OWNER TO brian;

--
-- Name: item_union_map; Type: TABLE; Schema: item_mapping_collections_unions; Owner: brian
--

CREATE TABLE item_mapping_collections_unions.item_union_map (
    identifier text NOT NULL,
    unionname text NOT NULL
);


ALTER TABLE item_mapping_collections_unions.item_union_map OWNER TO brian;

--
-- Name: items; Type: TABLE; Schema: item_mapping_collections_unions; Owner: brian
--

CREATE TABLE item_mapping_collections_unions.items (
    identifier text NOT NULL,
    itemsizegib numeric(12,3),
    preparationid bigint,
    piecescount integer,
    packedsizegib numeric(12,3)
);


ALTER TABLE item_mapping_collections_unions.items OWNER TO brian;

--
-- Name: items_all_unique; Type: TABLE; Schema: item_mapping_collections_unions; Owner: brian
--

CREATE TABLE item_mapping_collections_unions.items_all_unique (
    identifier text NOT NULL
);


ALTER TABLE item_mapping_collections_unions.items_all_unique OWNER TO brian;

--
-- Name: prelinger_preps_gsheets; Type: TABLE; Schema: item_mapping_collections_unions; Owner: brian
--

CREATE TABLE item_mapping_collections_unions.prelinger_preps_gsheets (
    identifier text,
    itemsizegib numeric(12,3),
    preparationid bigint,
    piecescount integer,
    packedsizegib numeric(12,3)
);


ALTER TABLE item_mapping_collections_unions.prelinger_preps_gsheets OWNER TO brian;

--
-- Name: deals_full; Type: TABLE; Schema: lotus_import; Owner: brian
--

CREATE TABLE lotus_import.deals_full (
    dealid bigint,
    piececid text,
    piecesize bigint,
    verifieddeal boolean,
    client text,
    provider text,
    label text,
    startepoch bigint,
    endepoch bigint,
    storagepriceperepoch bigint,
    providercollateral bigint,
    clientcollateral bigint,
    sectornumber bigint,
    sectorstartepoch bigint,
    lastupdatedepoch bigint,
    slashepoch bigint
);


ALTER TABLE lotus_import.deals_full OWNER TO brian;

--
-- Name: deals_raw; Type: TABLE; Schema: lotus_import; Owner: brian
--

CREATE TABLE lotus_import.deals_raw (
    dealid bigint,
    state text,
    provider text,
    piececid text,
    piecesize bigint,
    startepoch bigint,
    price bigint,
    verified boolean,
    clientid text
);


ALTER TABLE lotus_import.deals_raw OWNER TO brian;

--
-- Name: collection_35mmstockfootage_raw; Type: TABLE; Schema: pa_collections_ia_search; Owner: brian
--

CREATE TABLE pa_collections_ia_search.collection_35mmstockfootage_raw (
    identifier text NOT NULL
);


ALTER TABLE pa_collections_ia_search.collection_35mmstockfootage_raw OWNER TO brian;

--
-- Name: collection_legacy_prelinger_raw; Type: TABLE; Schema: pa_collections_ia_search; Owner: brian
--

CREATE TABLE pa_collections_ia_search.collection_legacy_prelinger_raw (
    identifier text NOT NULL
);


ALTER TABLE pa_collections_ia_search.collection_legacy_prelinger_raw OWNER TO brian;

--
-- Name: ff_prelinger_raw; Type: TABLE; Schema: pa_collections_ia_search; Owner: brian
--

CREATE TABLE pa_collections_ia_search.ff_prelinger_raw (
    identifier text NOT NULL
);


ALTER TABLE pa_collections_ia_search.ff_prelinger_raw OWNER TO brian;

--
-- Name: clients; Type: TABLE; Schema: public; Owner: brian
--

CREATE TABLE public.clients (
    clientid character varying(20) NOT NULL,
    clientaddress text NOT NULL,
    active boolean NOT NULL,
    clientowner character varying(10) NOT NULL
);


ALTER TABLE public.clients OWNER TO brian;

--
-- Name: contents; Type: TABLE; Schema: public; Owner: brian
--

CREATE TABLE public.contents (
    storageid integer NOT NULL,
    identifier text NOT NULL
);


ALTER TABLE public.contents OWNER TO brian;

--
-- Name: contents_staging; Type: TABLE; Schema: public; Owner: brian
--

CREATE UNLOGGED TABLE public.contents_staging (
    storageid integer,
    identifier text
);


ALTER TABLE public.contents_staging OWNER TO brian;

--
-- Name: deals; Type: TABLE; Schema: public; Owner: brian
--

CREATE TABLE public.deals (
    dealid bigint NOT NULL,
    state character varying(50) NOT NULL,
    provider text NOT NULL,
    piececid text NOT NULL,
    piecesize bigint NOT NULL,
    startepoch bigint NOT NULL,
    price bigint NOT NULL,
    verified boolean NOT NULL,
    clientid character varying(50) NOT NULL
);


ALTER TABLE public.deals OWNER TO brian;

--
-- Name: deals_staging; Type: TABLE; Schema: public; Owner: brian
--

CREATE TABLE public.deals_staging (
    dealid bigint,
    state character varying(50),
    provider character varying(50),
    piececid text,
    piecesize bigint,
    startepoch bigint,
    price bigint,
    verified boolean,
    clientid character varying(50)
);


ALTER TABLE public.deals_staging OWNER TO brian;

--
-- Name: pieces; Type: TABLE; Schema: public; Owner: brian
--

CREATE TABLE public.pieces (
    piecerecordid integer NOT NULL,
    piececid text,
    piecesize bigint,
    rootcid text,
    filesize bigint,
    storageid bigint,
    prepid bigint,
    isdag boolean
);


ALTER TABLE public.pieces OWNER TO brian;

--
-- Name: pieces_piecerecordid_seq; Type: SEQUENCE; Schema: public; Owner: brian
--

CREATE SEQUENCE public.pieces_piecerecordid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pieces_piecerecordid_seq OWNER TO brian;

--
-- Name: pieces_piecerecordid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: brian
--

ALTER SEQUENCE public.pieces_piecerecordid_seq OWNED BY public.pieces.piecerecordid;


--
-- Name: pieces_staging; Type: TABLE; Schema: public; Owner: brian
--

CREATE TABLE public.pieces_staging (
    piececid text,
    piecesize bigint,
    rootcid text,
    filesize bigint,
    storageid bigint,
    prepid bigint,
    isdag boolean
);


ALTER TABLE public.pieces_staging OWNER TO brian;

--
-- Name: preparations; Type: TABLE; Schema: public; Owner: brian
--

CREATE TABLE public.preparations (
    prepid bigint NOT NULL,
    name text NOT NULL,
    storageid bigint NOT NULL,
    deleteafterexport boolean,
    maxsize bigint,
    piecesize bigint,
    minpiecesize bigint,
    noinline boolean,
    nodag boolean,
    hasoutputstorage boolean
);


ALTER TABLE public.preparations OWNER TO brian;

--
-- Name: preparations_staging; Type: TABLE; Schema: public; Owner: brian
--

CREATE TABLE public.preparations_staging (
    prepid bigint,
    name text,
    deleteafterexport boolean,
    maxsize bigint,
    piecesize bigint,
    minpiecesize bigint,
    noinline boolean,
    nodag boolean,
    sourcestorageid bigint,
    sourcestoragename text,
    sourcestoragetype text,
    sourcestoragepath text,
    hasoutputstorage boolean
);


ALTER TABLE public.preparations_staging OWNER TO brian;

--
-- Name: providers; Type: TABLE; Schema: public; Owner: brian
--

CREATE TABLE public.providers (
    providerid text NOT NULL,
    providername text NOT NULL
);


ALTER TABLE public.providers OWNER TO brian;

--
-- Name: storages; Type: TABLE; Schema: public; Owner: brian
--

CREATE TABLE public.storages (
    storageid bigint NOT NULL,
    storagename text NOT NULL,
    storagetype text,
    storagepath text
);


ALTER TABLE public.storages OWNER TO brian;

--
-- Name: storages_staging; Type: TABLE; Schema: public; Owner: brian
--

CREATE TABLE public.storages_staging (
    storageid bigint,
    storagename text,
    storagetype text,
    storagepath text,
    issource boolean,
    sourceid bigint,
    sourcename text,
    sourcedeleteafterexport boolean,
    sourcemaxsize bigint,
    sourcepiecesize bigint,
    sourceminpiecesize bigint,
    sourcenoinline boolean,
    sourcenodag boolean
);


ALTER TABLE public.storages_staging OWNER TO brian;

--
-- Name: cars; Type: TABLE; Schema: singularity_raw; Owner: brian
--

CREATE TABLE singularity_raw.cars (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    piece_cid bytea,
    piece_size bigint,
    root_cid bytea,
    file_size bigint,
    storage_id bigint,
    storage_path text,
    num_of_files bigint,
    preparation_id bigint,
    attachment_id bigint,
    job_id bigint,
    piece_type text,
    min_piece_size_padding bigint
);


ALTER TABLE singularity_raw.cars OWNER TO brian;

--
-- Name: cars_id_seq; Type: SEQUENCE; Schema: singularity_raw; Owner: brian
--

CREATE SEQUENCE singularity_raw.cars_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE singularity_raw.cars_id_seq OWNER TO brian;

--
-- Name: cars_id_seq; Type: SEQUENCE OWNED BY; Schema: singularity_raw; Owner: brian
--

ALTER SEQUENCE singularity_raw.cars_id_seq OWNED BY singularity_raw.cars.id;


--
-- Name: preparations; Type: TABLE; Schema: singularity_raw; Owner: brian
--

CREATE TABLE singularity_raw.preparations (
    id bigint NOT NULL,
    name text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    delete_after_export boolean,
    max_size bigint,
    piece_size bigint,
    no_inline boolean,
    no_dag boolean,
    min_piece_size bigint
);


ALTER TABLE singularity_raw.preparations OWNER TO brian;

--
-- Name: storages; Type: TABLE; Schema: singularity_raw; Owner: brian
--

CREATE TABLE singularity_raw.storages (
    id bigint NOT NULL,
    name text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    type text,
    path text,
    config jsonb,
    client_config jsonb
);


ALTER TABLE singularity_raw.storages OWNER TO brian;

--
-- Name: union_missing_identifiers; Type: TABLE; Schema: union_contents_manual; Owner: brian
--

CREATE TABLE union_contents_manual.union_missing_identifiers (
    unionname text NOT NULL,
    identifier text NOT NULL
);


ALTER TABLE union_contents_manual.union_missing_identifiers OWNER TO brian;

--
-- Name: unionname_35mm_batch_1; Type: TABLE; Schema: union_contents_manual; Owner: brian
--

CREATE TABLE union_contents_manual.unionname_35mm_batch_1 (
    identifier text NOT NULL
);


ALTER TABLE union_contents_manual.unionname_35mm_batch_1 OWNER TO brian;

--
-- Name: unionname_35mm_batch_2; Type: TABLE; Schema: union_contents_manual; Owner: brian
--

CREATE TABLE union_contents_manual.unionname_35mm_batch_2 (
    identifier text NOT NULL
);


ALTER TABLE union_contents_manual.unionname_35mm_batch_2 OWNER TO brian;

--
-- Name: unionname_35mm_batch_4; Type: TABLE; Schema: union_contents_manual; Owner: brian
--

CREATE TABLE union_contents_manual.unionname_35mm_batch_4 (
    identifier text NOT NULL
);


ALTER TABLE union_contents_manual.unionname_35mm_batch_4 OWNER TO brian;

--
-- Name: unionname_h264_special_items; Type: TABLE; Schema: union_contents_manual; Owner: brian
--

CREATE TABLE union_contents_manual.unionname_h264_special_items (
    identifier text NOT NULL
);


ALTER TABLE union_contents_manual.unionname_h264_special_items OWNER TO brian;

--
-- Name: unionname_h264_special_items_2; Type: TABLE; Schema: union_contents_manual; Owner: brian
--

CREATE TABLE union_contents_manual.unionname_h264_special_items_2 (
    identifier text NOT NULL
);


ALTER TABLE union_contents_manual.unionname_h264_special_items_2 OWNER TO brian;

--
-- Name: unionname_h264_special_items_3; Type: TABLE; Schema: union_contents_manual; Owner: brian
--

CREATE TABLE union_contents_manual.unionname_h264_special_items_3 (
    identifier text NOT NULL
);


ALTER TABLE union_contents_manual.unionname_h264_special_items_3 OWNER TO brian;

--
-- Name: unionname_legacy_prelinger_01; Type: TABLE; Schema: union_contents_manual; Owner: brian
--

CREATE TABLE union_contents_manual.unionname_legacy_prelinger_01 (
    identifier text NOT NULL
);


ALTER TABLE union_contents_manual.unionname_legacy_prelinger_01 OWNER TO brian;

--
-- Name: unionname_legacy_prelinger_02; Type: TABLE; Schema: union_contents_manual; Owner: brian
--

CREATE TABLE union_contents_manual.unionname_legacy_prelinger_02 (
    identifier text NOT NULL
);


ALTER TABLE union_contents_manual.unionname_legacy_prelinger_02 OWNER TO brian;

--
-- Name: unionname_legacy_prelinger_03; Type: TABLE; Schema: union_contents_manual; Owner: brian
--

CREATE TABLE union_contents_manual.unionname_legacy_prelinger_03 (
    identifier text NOT NULL
);


ALTER TABLE union_contents_manual.unionname_legacy_prelinger_03 OWNER TO brian;

--
-- Name: unionname_legacy_prelinger_04; Type: TABLE; Schema: union_contents_manual; Owner: brian
--

CREATE TABLE union_contents_manual.unionname_legacy_prelinger_04 (
    identifier text NOT NULL
);


ALTER TABLE union_contents_manual.unionname_legacy_prelinger_04 OWNER TO brian;

--
-- Name: unionname_legacy_prelinger_05; Type: TABLE; Schema: union_contents_manual; Owner: brian
--

CREATE TABLE union_contents_manual.unionname_legacy_prelinger_05 (
    identifier text NOT NULL
);


ALTER TABLE union_contents_manual.unionname_legacy_prelinger_05 OWNER TO brian;

--
-- Name: unionname_legacy_prelinger_06; Type: TABLE; Schema: union_contents_manual; Owner: brian
--

CREATE TABLE union_contents_manual.unionname_legacy_prelinger_06 (
    identifier text NOT NULL
);


ALTER TABLE union_contents_manual.unionname_legacy_prelinger_06 OWNER TO brian;

--
-- Name: unionname_legacy_prelinger_07; Type: TABLE; Schema: union_contents_manual; Owner: brian
--

CREATE TABLE union_contents_manual.unionname_legacy_prelinger_07 (
    identifier text NOT NULL
);


ALTER TABLE union_contents_manual.unionname_legacy_prelinger_07 OWNER TO brian;

--
-- Name: unionname_legacy_prelinger_08; Type: TABLE; Schema: union_contents_manual; Owner: brian
--

CREATE TABLE union_contents_manual.unionname_legacy_prelinger_08 (
    identifier text NOT NULL
);


ALTER TABLE union_contents_manual.unionname_legacy_prelinger_08 OWNER TO brian;

--
-- Name: unionname_legacy_prelinger_09; Type: TABLE; Schema: union_contents_manual; Owner: brian
--

CREATE TABLE union_contents_manual.unionname_legacy_prelinger_09 (
    identifier text NOT NULL
);


ALTER TABLE union_contents_manual.unionname_legacy_prelinger_09 OWNER TO brian;

--
-- Name: unionname_legacy_prelinger_10; Type: TABLE; Schema: union_contents_manual; Owner: brian
--

CREATE TABLE union_contents_manual.unionname_legacy_prelinger_10 (
    identifier text NOT NULL
);


ALTER TABLE union_contents_manual.unionname_legacy_prelinger_10 OWNER TO brian;

--
-- Name: unionname_legacy_prelinger_11; Type: TABLE; Schema: union_contents_manual; Owner: brian
--

CREATE TABLE union_contents_manual.unionname_legacy_prelinger_11 (
    identifier text NOT NULL
);


ALTER TABLE union_contents_manual.unionname_legacy_prelinger_11 OWNER TO brian;

--
-- Name: unionname_legacy_prelinger_12; Type: TABLE; Schema: union_contents_manual; Owner: brian
--

CREATE TABLE union_contents_manual.unionname_legacy_prelinger_12 (
    identifier text NOT NULL
);


ALTER TABLE union_contents_manual.unionname_legacy_prelinger_12 OWNER TO brian;

--
-- Name: unionname_legacy_prelinger_13; Type: TABLE; Schema: union_contents_manual; Owner: brian
--

CREATE TABLE union_contents_manual.unionname_legacy_prelinger_13 (
    identifier text NOT NULL
);


ALTER TABLE union_contents_manual.unionname_legacy_prelinger_13 OWNER TO brian;

--
-- Name: unionname_legacy_prelinger_14; Type: TABLE; Schema: union_contents_manual; Owner: brian
--

CREATE TABLE union_contents_manual.unionname_legacy_prelinger_14 (
    identifier text NOT NULL
);


ALTER TABLE union_contents_manual.unionname_legacy_prelinger_14 OWNER TO brian;

--
-- Name: unionname_legacy_prelinger_15; Type: TABLE; Schema: union_contents_manual; Owner: brian
--

CREATE TABLE union_contents_manual.unionname_legacy_prelinger_15 (
    identifier text NOT NULL
);


ALTER TABLE union_contents_manual.unionname_legacy_prelinger_15 OWNER TO brian;

--
-- Name: unionname_legacy_prelinger_16; Type: TABLE; Schema: union_contents_manual; Owner: brian
--

CREATE TABLE union_contents_manual.unionname_legacy_prelinger_16 (
    identifier text NOT NULL
);


ALTER TABLE union_contents_manual.unionname_legacy_prelinger_16 OWNER TO brian;

--
-- Name: unionname_prelinger_union_1; Type: TABLE; Schema: union_contents_manual; Owner: brian
--

CREATE TABLE union_contents_manual.unionname_prelinger_union_1 (
    identifier text NOT NULL
);


ALTER TABLE union_contents_manual.unionname_prelinger_union_1 OWNER TO brian;

--
-- Name: unionname_prelinger_union_11; Type: TABLE; Schema: union_contents_manual; Owner: brian
--

CREATE TABLE union_contents_manual.unionname_prelinger_union_11 (
    identifier text NOT NULL
);


ALTER TABLE union_contents_manual.unionname_prelinger_union_11 OWNER TO brian;

--
-- Name: unionname_prelinger_union_12; Type: TABLE; Schema: union_contents_manual; Owner: brian
--

CREATE TABLE union_contents_manual.unionname_prelinger_union_12 (
    identifier text NOT NULL
);


ALTER TABLE union_contents_manual.unionname_prelinger_union_12 OWNER TO brian;

--
-- Name: unionname_prelinger_union_13; Type: TABLE; Schema: union_contents_manual; Owner: brian
--

CREATE TABLE union_contents_manual.unionname_prelinger_union_13 (
    identifier text NOT NULL
);


ALTER TABLE union_contents_manual.unionname_prelinger_union_13 OWNER TO brian;

--
-- Name: unionname_prelinger_union_3; Type: TABLE; Schema: union_contents_manual; Owner: brian
--

CREATE TABLE union_contents_manual.unionname_prelinger_union_3 (
    identifier text NOT NULL
);


ALTER TABLE union_contents_manual.unionname_prelinger_union_3 OWNER TO brian;

--
-- Name: unionname_prelinger_union_4; Type: TABLE; Schema: union_contents_manual; Owner: brian
--

CREATE TABLE union_contents_manual.unionname_prelinger_union_4 (
    identifier text NOT NULL
);


ALTER TABLE union_contents_manual.unionname_prelinger_union_4 OWNER TO brian;

--
-- Name: unionname_prelinger_union_5; Type: TABLE; Schema: union_contents_manual; Owner: brian
--

CREATE TABLE union_contents_manual.unionname_prelinger_union_5 (
    identifier text NOT NULL
);


ALTER TABLE union_contents_manual.unionname_prelinger_union_5 OWNER TO brian;

--
-- Name: unionname_prelinger_union_6; Type: TABLE; Schema: union_contents_manual; Owner: brian
--

CREATE TABLE union_contents_manual.unionname_prelinger_union_6 (
    identifier text NOT NULL
);


ALTER TABLE union_contents_manual.unionname_prelinger_union_6 OWNER TO brian;

--
-- Name: unionname_prelinger_union_8; Type: TABLE; Schema: union_contents_manual; Owner: brian
--

CREATE TABLE union_contents_manual.unionname_prelinger_union_8 (
    identifier text NOT NULL
);


ALTER TABLE union_contents_manual.unionname_prelinger_union_8 OWNER TO brian;

--
-- Name: unionname_prelinger_union_9; Type: TABLE; Schema: union_contents_manual; Owner: brian
--

CREATE TABLE union_contents_manual.unionname_prelinger_union_9 (
    identifier text NOT NULL
);


ALTER TABLE union_contents_manual.unionname_prelinger_union_9 OWNER TO brian;

--
-- Name: pieces piecerecordid; Type: DEFAULT; Schema: public; Owner: brian
--

ALTER TABLE ONLY public.pieces ALTER COLUMN piecerecordid SET DEFAULT nextval('public.pieces_piecerecordid_seq'::regclass);


--
-- Name: cars id; Type: DEFAULT; Schema: singularity_raw; Owner: brian
--

ALTER TABLE ONLY singularity_raw.cars ALTER COLUMN id SET DEFAULT nextval('singularity_raw.cars_id_seq'::regclass);


--
-- Name: eot_2024_ateam_usgovernment_raw archiveteam_eot2024_usgovernment_pkey; Type: CONSTRAINT; Schema: ia_collections_ia_search; Owner: brian
--

ALTER TABLE ONLY ia_collections_ia_search.eot_2024_ateam_usgovernment_raw
    ADD CONSTRAINT archiveteam_eot2024_usgovernment_pkey PRIMARY KEY (identifier);


--
-- Name: eot_2024_ateam_voiceofamerica_raw archiveteam_eot2024_voiceofamerica_pkey; Type: CONSTRAINT; Schema: ia_collections_ia_search; Owner: brian
--

ALTER TABLE ONLY ia_collections_ia_search.eot_2024_ateam_voiceofamerica_raw
    ADD CONSTRAINT archiveteam_eot2024_voiceofamerica_pkey PRIMARY KEY (identifier);


--
-- Name: aruba_raw collection_aruba_raw_pkey; Type: CONSTRAINT; Schema: ia_collections_ia_search; Owner: brian
--

ALTER TABLE ONLY ia_collections_ia_search.aruba_raw
    ADD CONSTRAINT collection_aruba_raw_pkey PRIMARY KEY (identifier);


--
-- Name: eot_2024_interim_raw eot_2024_interim_raw_pkey; Type: CONSTRAINT; Schema: ia_collections_ia_search; Owner: brian
--

ALTER TABLE ONLY ia_collections_ia_search.eot_2024_interim_raw
    ADD CONSTRAINT eot_2024_interim_raw_pkey PRIMARY KEY (identifier);


--
-- Name: eot_2024_post_inauguration_raw eot_2024_post_inauguration_raw_pkey; Type: CONSTRAINT; Schema: ia_collections_ia_search; Owner: brian
--

ALTER TABLE ONLY ia_collections_ia_search.eot_2024_post_inauguration_raw
    ADD CONSTRAINT eot_2024_post_inauguration_raw_pkey PRIMARY KEY (identifier);


--
-- Name: eot_2024_pre_election_raw eot_2024_pre_election_raw_pkey; Type: CONSTRAINT; Schema: ia_collections_ia_search; Owner: brian
--

ALTER TABLE ONLY ia_collections_ia_search.eot_2024_pre_election_raw
    ADD CONSTRAINT eot_2024_pre_election_raw_pkey PRIMARY KEY (identifier);


--
-- Name: eot_2024_unt_raw eot_2024_unt_raw_pkey; Type: CONSTRAINT; Schema: ia_collections_ia_search; Owner: brian
--

ALTER TABLE ONLY ia_collections_ia_search.eot_2024_unt_raw
    ADD CONSTRAINT eot_2024_unt_raw_pkey PRIMARY KEY (identifier);


--
-- Name: eot_2024_webrecorder_raw eot_2024_webrecorder_raw_pkey; Type: CONSTRAINT; Schema: ia_collections_ia_search; Owner: brian
--

ALTER TABLE ONLY ia_collections_ia_search.eot_2024_webrecorder_raw
    ADD CONSTRAINT eot_2024_webrecorder_raw_pkey PRIMARY KEY (identifier);


--
-- Name: rohingya_archive_raw rohingya_archive_raw_pkey; Type: CONSTRAINT; Schema: ia_collections_ia_search; Owner: brian
--

ALTER TABLE ONLY ia_collections_ia_search.rohingya_archive_raw
    ADD CONSTRAINT rohingya_archive_raw_pkey PRIMARY KEY (identifier);


--
-- Name: us_fbis_raw us_fbis_raw_pkey; Type: CONSTRAINT; Schema: ia_collections_ia_search; Owner: brian
--

ALTER TABLE ONLY ia_collections_ia_search.us_fbis_raw
    ADD CONSTRAINT us_fbis_raw_pkey PRIMARY KEY (identifier);


--
-- Name: item_collection_map item_collection_map_pkey; Type: CONSTRAINT; Schema: item_mapping_collections_unions; Owner: brian
--

ALTER TABLE ONLY item_mapping_collections_unions.item_collection_map
    ADD CONSTRAINT item_collection_map_pkey PRIMARY KEY (identifier, collection);


--
-- Name: item_union_map item_union_map_pkey; Type: CONSTRAINT; Schema: item_mapping_collections_unions; Owner: brian
--

ALTER TABLE ONLY item_mapping_collections_unions.item_union_map
    ADD CONSTRAINT item_union_map_pkey PRIMARY KEY (identifier, unionname);


--
-- Name: items_all_unique items_all_unique_pkey; Type: CONSTRAINT; Schema: item_mapping_collections_unions; Owner: brian
--

ALTER TABLE ONLY item_mapping_collections_unions.items_all_unique
    ADD CONSTRAINT items_all_unique_pkey PRIMARY KEY (identifier);


--
-- Name: items items_pkey; Type: CONSTRAINT; Schema: item_mapping_collections_unions; Owner: brian
--

ALTER TABLE ONLY item_mapping_collections_unions.items
    ADD CONSTRAINT items_pkey PRIMARY KEY (identifier);


--
-- Name: collection_35mmstockfootage_raw collection_35mmstockfootage_raw_pkey; Type: CONSTRAINT; Schema: pa_collections_ia_search; Owner: brian
--

ALTER TABLE ONLY pa_collections_ia_search.collection_35mmstockfootage_raw
    ADD CONSTRAINT collection_35mmstockfootage_raw_pkey PRIMARY KEY (identifier);


--
-- Name: collection_legacy_prelinger_raw collection_legacy_prelinger_raw_pkey; Type: CONSTRAINT; Schema: pa_collections_ia_search; Owner: brian
--

ALTER TABLE ONLY pa_collections_ia_search.collection_legacy_prelinger_raw
    ADD CONSTRAINT collection_legacy_prelinger_raw_pkey PRIMARY KEY (identifier);


--
-- Name: ff_prelinger_raw ff_prelinger_raw_pkey; Type: CONSTRAINT; Schema: pa_collections_ia_search; Owner: brian
--

ALTER TABLE ONLY pa_collections_ia_search.ff_prelinger_raw
    ADD CONSTRAINT ff_prelinger_raw_pkey PRIMARY KEY (identifier);


--
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: brian
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (clientid);


--
-- Name: contents contents_pkey; Type: CONSTRAINT; Schema: public; Owner: brian
--

ALTER TABLE ONLY public.contents
    ADD CONSTRAINT contents_pkey PRIMARY KEY (storageid, identifier);


--
-- Name: deals deals_pkey; Type: CONSTRAINT; Schema: public; Owner: brian
--

ALTER TABLE ONLY public.deals
    ADD CONSTRAINT deals_pkey PRIMARY KEY (dealid);


--
-- Name: pieces pieces_pkey; Type: CONSTRAINT; Schema: public; Owner: brian
--

ALTER TABLE ONLY public.pieces
    ADD CONSTRAINT pieces_pkey PRIMARY KEY (piecerecordid);


--
-- Name: preparations preparations_pkey; Type: CONSTRAINT; Schema: public; Owner: brian
--

ALTER TABLE ONLY public.preparations
    ADD CONSTRAINT preparations_pkey PRIMARY KEY (prepid);


--
-- Name: providers providers_pkey; Type: CONSTRAINT; Schema: public; Owner: brian
--

ALTER TABLE ONLY public.providers
    ADD CONSTRAINT providers_pkey PRIMARY KEY (providerid);


--
-- Name: storages storages_pkey; Type: CONSTRAINT; Schema: public; Owner: brian
--

ALTER TABLE ONLY public.storages
    ADD CONSTRAINT storages_pkey PRIMARY KEY (storageid);


--
-- Name: cars cars_pkey; Type: CONSTRAINT; Schema: singularity_raw; Owner: brian
--

ALTER TABLE ONLY singularity_raw.cars
    ADD CONSTRAINT cars_pkey PRIMARY KEY (id);


--
-- Name: preparations preparations_pkey; Type: CONSTRAINT; Schema: singularity_raw; Owner: brian
--

ALTER TABLE ONLY singularity_raw.preparations
    ADD CONSTRAINT preparations_pkey PRIMARY KEY (id);


--
-- Name: storages storages_pkey; Type: CONSTRAINT; Schema: singularity_raw; Owner: brian
--

ALTER TABLE ONLY singularity_raw.storages
    ADD CONSTRAINT storages_pkey PRIMARY KEY (id);


--
-- Name: union_missing_identifiers union_missing_identifiers_pkey; Type: CONSTRAINT; Schema: union_contents_manual; Owner: brian
--

ALTER TABLE ONLY union_contents_manual.union_missing_identifiers
    ADD CONSTRAINT union_missing_identifiers_pkey PRIMARY KEY (unionname, identifier);


--
-- Name: unionname_35mm_batch_1 unionname_35mm_batch_1_pkey; Type: CONSTRAINT; Schema: union_contents_manual; Owner: brian
--

ALTER TABLE ONLY union_contents_manual.unionname_35mm_batch_1
    ADD CONSTRAINT unionname_35mm_batch_1_pkey PRIMARY KEY (identifier);


--
-- Name: unionname_35mm_batch_2 unionname_35mm_batch_2_pkey; Type: CONSTRAINT; Schema: union_contents_manual; Owner: brian
--

ALTER TABLE ONLY union_contents_manual.unionname_35mm_batch_2
    ADD CONSTRAINT unionname_35mm_batch_2_pkey PRIMARY KEY (identifier);


--
-- Name: unionname_35mm_batch_4 unionname_35mm_batch_4_pkey; Type: CONSTRAINT; Schema: union_contents_manual; Owner: brian
--

ALTER TABLE ONLY union_contents_manual.unionname_35mm_batch_4
    ADD CONSTRAINT unionname_35mm_batch_4_pkey PRIMARY KEY (identifier);


--
-- Name: unionname_h264_special_items_2 unionname_h264_special_items_2_pkey; Type: CONSTRAINT; Schema: union_contents_manual; Owner: brian
--

ALTER TABLE ONLY union_contents_manual.unionname_h264_special_items_2
    ADD CONSTRAINT unionname_h264_special_items_2_pkey PRIMARY KEY (identifier);


--
-- Name: unionname_h264_special_items_3 unionname_h264_special_items_3_pkey; Type: CONSTRAINT; Schema: union_contents_manual; Owner: brian
--

ALTER TABLE ONLY union_contents_manual.unionname_h264_special_items_3
    ADD CONSTRAINT unionname_h264_special_items_3_pkey PRIMARY KEY (identifier);


--
-- Name: unionname_h264_special_items unionname_h264_special_items_pkey; Type: CONSTRAINT; Schema: union_contents_manual; Owner: brian
--

ALTER TABLE ONLY union_contents_manual.unionname_h264_special_items
    ADD CONSTRAINT unionname_h264_special_items_pkey PRIMARY KEY (identifier);


--
-- Name: unionname_legacy_prelinger_01 unionname_legacy_prelinger_01_pkey; Type: CONSTRAINT; Schema: union_contents_manual; Owner: brian
--

ALTER TABLE ONLY union_contents_manual.unionname_legacy_prelinger_01
    ADD CONSTRAINT unionname_legacy_prelinger_01_pkey PRIMARY KEY (identifier);


--
-- Name: unionname_legacy_prelinger_02 unionname_legacy_prelinger_02_pkey; Type: CONSTRAINT; Schema: union_contents_manual; Owner: brian
--

ALTER TABLE ONLY union_contents_manual.unionname_legacy_prelinger_02
    ADD CONSTRAINT unionname_legacy_prelinger_02_pkey PRIMARY KEY (identifier);


--
-- Name: unionname_legacy_prelinger_03 unionname_legacy_prelinger_03_pkey; Type: CONSTRAINT; Schema: union_contents_manual; Owner: brian
--

ALTER TABLE ONLY union_contents_manual.unionname_legacy_prelinger_03
    ADD CONSTRAINT unionname_legacy_prelinger_03_pkey PRIMARY KEY (identifier);


--
-- Name: unionname_legacy_prelinger_04 unionname_legacy_prelinger_04_pkey; Type: CONSTRAINT; Schema: union_contents_manual; Owner: brian
--

ALTER TABLE ONLY union_contents_manual.unionname_legacy_prelinger_04
    ADD CONSTRAINT unionname_legacy_prelinger_04_pkey PRIMARY KEY (identifier);


--
-- Name: unionname_legacy_prelinger_05 unionname_legacy_prelinger_05_pkey; Type: CONSTRAINT; Schema: union_contents_manual; Owner: brian
--

ALTER TABLE ONLY union_contents_manual.unionname_legacy_prelinger_05
    ADD CONSTRAINT unionname_legacy_prelinger_05_pkey PRIMARY KEY (identifier);


--
-- Name: unionname_legacy_prelinger_06 unionname_legacy_prelinger_06_pkey; Type: CONSTRAINT; Schema: union_contents_manual; Owner: brian
--

ALTER TABLE ONLY union_contents_manual.unionname_legacy_prelinger_06
    ADD CONSTRAINT unionname_legacy_prelinger_06_pkey PRIMARY KEY (identifier);


--
-- Name: unionname_legacy_prelinger_07 unionname_legacy_prelinger_07_pkey; Type: CONSTRAINT; Schema: union_contents_manual; Owner: brian
--

ALTER TABLE ONLY union_contents_manual.unionname_legacy_prelinger_07
    ADD CONSTRAINT unionname_legacy_prelinger_07_pkey PRIMARY KEY (identifier);


--
-- Name: unionname_legacy_prelinger_08 unionname_legacy_prelinger_08_pkey; Type: CONSTRAINT; Schema: union_contents_manual; Owner: brian
--

ALTER TABLE ONLY union_contents_manual.unionname_legacy_prelinger_08
    ADD CONSTRAINT unionname_legacy_prelinger_08_pkey PRIMARY KEY (identifier);


--
-- Name: unionname_legacy_prelinger_09 unionname_legacy_prelinger_09_pkey; Type: CONSTRAINT; Schema: union_contents_manual; Owner: brian
--

ALTER TABLE ONLY union_contents_manual.unionname_legacy_prelinger_09
    ADD CONSTRAINT unionname_legacy_prelinger_09_pkey PRIMARY KEY (identifier);


--
-- Name: unionname_legacy_prelinger_10 unionname_legacy_prelinger_10_pkey; Type: CONSTRAINT; Schema: union_contents_manual; Owner: brian
--

ALTER TABLE ONLY union_contents_manual.unionname_legacy_prelinger_10
    ADD CONSTRAINT unionname_legacy_prelinger_10_pkey PRIMARY KEY (identifier);


--
-- Name: unionname_legacy_prelinger_11 unionname_legacy_prelinger_11_pkey; Type: CONSTRAINT; Schema: union_contents_manual; Owner: brian
--

ALTER TABLE ONLY union_contents_manual.unionname_legacy_prelinger_11
    ADD CONSTRAINT unionname_legacy_prelinger_11_pkey PRIMARY KEY (identifier);


--
-- Name: unionname_legacy_prelinger_12 unionname_legacy_prelinger_12_pkey; Type: CONSTRAINT; Schema: union_contents_manual; Owner: brian
--

ALTER TABLE ONLY union_contents_manual.unionname_legacy_prelinger_12
    ADD CONSTRAINT unionname_legacy_prelinger_12_pkey PRIMARY KEY (identifier);


--
-- Name: unionname_legacy_prelinger_13 unionname_legacy_prelinger_13_pkey; Type: CONSTRAINT; Schema: union_contents_manual; Owner: brian
--

ALTER TABLE ONLY union_contents_manual.unionname_legacy_prelinger_13
    ADD CONSTRAINT unionname_legacy_prelinger_13_pkey PRIMARY KEY (identifier);


--
-- Name: unionname_legacy_prelinger_14 unionname_legacy_prelinger_14_pkey; Type: CONSTRAINT; Schema: union_contents_manual; Owner: brian
--

ALTER TABLE ONLY union_contents_manual.unionname_legacy_prelinger_14
    ADD CONSTRAINT unionname_legacy_prelinger_14_pkey PRIMARY KEY (identifier);


--
-- Name: unionname_legacy_prelinger_15 unionname_legacy_prelinger_15_pkey; Type: CONSTRAINT; Schema: union_contents_manual; Owner: brian
--

ALTER TABLE ONLY union_contents_manual.unionname_legacy_prelinger_15
    ADD CONSTRAINT unionname_legacy_prelinger_15_pkey PRIMARY KEY (identifier);


--
-- Name: unionname_legacy_prelinger_16 unionname_legacy_prelinger_16_pkey; Type: CONSTRAINT; Schema: union_contents_manual; Owner: brian
--

ALTER TABLE ONLY union_contents_manual.unionname_legacy_prelinger_16
    ADD CONSTRAINT unionname_legacy_prelinger_16_pkey PRIMARY KEY (identifier);


--
-- Name: unionname_prelinger_union_11 unionname_prelinger_union_11_pkey; Type: CONSTRAINT; Schema: union_contents_manual; Owner: brian
--

ALTER TABLE ONLY union_contents_manual.unionname_prelinger_union_11
    ADD CONSTRAINT unionname_prelinger_union_11_pkey PRIMARY KEY (identifier);


--
-- Name: unionname_prelinger_union_12 unionname_prelinger_union_12_pkey; Type: CONSTRAINT; Schema: union_contents_manual; Owner: brian
--

ALTER TABLE ONLY union_contents_manual.unionname_prelinger_union_12
    ADD CONSTRAINT unionname_prelinger_union_12_pkey PRIMARY KEY (identifier);


--
-- Name: unionname_prelinger_union_13 unionname_prelinger_union_13_pkey; Type: CONSTRAINT; Schema: union_contents_manual; Owner: brian
--

ALTER TABLE ONLY union_contents_manual.unionname_prelinger_union_13
    ADD CONSTRAINT unionname_prelinger_union_13_pkey PRIMARY KEY (identifier);


--
-- Name: unionname_prelinger_union_1 unionname_prelinger_union_1_pkey; Type: CONSTRAINT; Schema: union_contents_manual; Owner: brian
--

ALTER TABLE ONLY union_contents_manual.unionname_prelinger_union_1
    ADD CONSTRAINT unionname_prelinger_union_1_pkey PRIMARY KEY (identifier);


--
-- Name: unionname_prelinger_union_3 unionname_prelinger_union_3_pkey; Type: CONSTRAINT; Schema: union_contents_manual; Owner: brian
--

ALTER TABLE ONLY union_contents_manual.unionname_prelinger_union_3
    ADD CONSTRAINT unionname_prelinger_union_3_pkey PRIMARY KEY (identifier);


--
-- Name: unionname_prelinger_union_4 unionname_prelinger_union_4_pkey; Type: CONSTRAINT; Schema: union_contents_manual; Owner: brian
--

ALTER TABLE ONLY union_contents_manual.unionname_prelinger_union_4
    ADD CONSTRAINT unionname_prelinger_union_4_pkey PRIMARY KEY (identifier);


--
-- Name: unionname_prelinger_union_5 unionname_prelinger_union_5_pkey; Type: CONSTRAINT; Schema: union_contents_manual; Owner: brian
--

ALTER TABLE ONLY union_contents_manual.unionname_prelinger_union_5
    ADD CONSTRAINT unionname_prelinger_union_5_pkey PRIMARY KEY (identifier);


--
-- Name: unionname_prelinger_union_6 unionname_prelinger_union_6_pkey; Type: CONSTRAINT; Schema: union_contents_manual; Owner: brian
--

ALTER TABLE ONLY union_contents_manual.unionname_prelinger_union_6
    ADD CONSTRAINT unionname_prelinger_union_6_pkey PRIMARY KEY (identifier);


--
-- Name: unionname_prelinger_union_8 unionname_prelinger_union_8_pkey; Type: CONSTRAINT; Schema: union_contents_manual; Owner: brian
--

ALTER TABLE ONLY union_contents_manual.unionname_prelinger_union_8
    ADD CONSTRAINT unionname_prelinger_union_8_pkey PRIMARY KEY (identifier);


--
-- Name: unionname_prelinger_union_9 unionname_prelinger_union_9_pkey; Type: CONSTRAINT; Schema: union_contents_manual; Owner: brian
--

ALTER TABLE ONLY union_contents_manual.unionname_prelinger_union_9
    ADD CONSTRAINT unionname_prelinger_union_9_pkey PRIMARY KEY (identifier);


--
-- Name: cars_attachment_id_idx; Type: INDEX; Schema: singularity_raw; Owner: brian
--

CREATE INDEX cars_attachment_id_idx ON singularity_raw.cars USING btree (attachment_id);


--
-- Name: cars_job_id_idx; Type: INDEX; Schema: singularity_raw; Owner: brian
--

CREATE INDEX cars_job_id_idx ON singularity_raw.cars USING btree (job_id);


--
-- Name: cars_preparation_id_idx; Type: INDEX; Schema: singularity_raw; Owner: brian
--

CREATE INDEX cars_preparation_id_idx ON singularity_raw.cars USING btree (preparation_id);


--
-- Name: cars_storage_id_idx; Type: INDEX; Schema: singularity_raw; Owner: brian
--

CREATE INDEX cars_storage_id_idx ON singularity_raw.cars USING btree (storage_id);


--
-- Name: idx_cars_attachment_id; Type: INDEX; Schema: singularity_raw; Owner: brian
--

CREATE INDEX idx_cars_attachment_id ON singularity_raw.cars USING btree (attachment_id);


--
-- Name: idx_cars_job_id; Type: INDEX; Schema: singularity_raw; Owner: brian
--

CREATE INDEX idx_cars_job_id ON singularity_raw.cars USING btree (job_id);


--
-- Name: idx_cars_piece_c_id; Type: INDEX; Schema: singularity_raw; Owner: brian
--

CREATE INDEX idx_cars_piece_c_id ON singularity_raw.cars USING btree (piece_cid);


--
-- Name: idx_cars_preparation_id; Type: INDEX; Schema: singularity_raw; Owner: brian
--

CREATE INDEX idx_cars_preparation_id ON singularity_raw.cars USING btree (preparation_id);


--
-- Name: idx_cars_storage_id; Type: INDEX; Schema: singularity_raw; Owner: brian
--

CREATE INDEX idx_cars_storage_id ON singularity_raw.cars USING btree (storage_id);


--
-- Name: item_collection_map item_collection_map_identifier_fkey; Type: FK CONSTRAINT; Schema: item_mapping_collections_unions; Owner: brian
--

ALTER TABLE ONLY item_mapping_collections_unions.item_collection_map
    ADD CONSTRAINT item_collection_map_identifier_fkey FOREIGN KEY (identifier) REFERENCES item_mapping_collections_unions.items_all_unique(identifier);


--
-- Name: item_union_map item_union_map_identifier_fkey; Type: FK CONSTRAINT; Schema: item_mapping_collections_unions; Owner: brian
--

ALTER TABLE ONLY item_mapping_collections_unions.item_union_map
    ADD CONSTRAINT item_union_map_identifier_fkey FOREIGN KEY (identifier) REFERENCES item_mapping_collections_unions.items_all_unique(identifier);


--
-- Name: contents fk_contents_storage; Type: FK CONSTRAINT; Schema: public; Owner: brian
--

ALTER TABLE ONLY public.contents
    ADD CONSTRAINT fk_contents_storage FOREIGN KEY (storageid) REFERENCES public.storages(storageid);


--
-- Name: deals fk_deals_clients; Type: FK CONSTRAINT; Schema: public; Owner: brian
--

ALTER TABLE ONLY public.deals
    ADD CONSTRAINT fk_deals_clients FOREIGN KEY (clientid) REFERENCES public.clients(clientid);


--
-- Name: deals fk_deals_providers; Type: FK CONSTRAINT; Schema: public; Owner: brian
--

ALTER TABLE ONLY public.deals
    ADD CONSTRAINT fk_deals_providers FOREIGN KEY (provider) REFERENCES public.providers(providerid);


--
-- Name: pieces fk_pieces_prepid; Type: FK CONSTRAINT; Schema: public; Owner: brian
--

ALTER TABLE ONLY public.pieces
    ADD CONSTRAINT fk_pieces_prepid FOREIGN KEY (prepid) REFERENCES public.preparations(prepid);


--
-- Name: pieces fk_pieces_storage; Type: FK CONSTRAINT; Schema: public; Owner: brian
--

ALTER TABLE ONLY public.pieces
    ADD CONSTRAINT fk_pieces_storage FOREIGN KEY (storageid) REFERENCES public.storages(storageid);


--
-- Name: preparations fk_preparations_storage; Type: FK CONSTRAINT; Schema: public; Owner: brian
--

ALTER TABLE ONLY public.preparations
    ADD CONSTRAINT fk_preparations_storage FOREIGN KEY (storageid) REFERENCES public.storages(storageid);


--
-- Name: pieces pieces_prepid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: brian
--

ALTER TABLE ONLY public.pieces
    ADD CONSTRAINT pieces_prepid_fkey FOREIGN KEY (prepid) REFERENCES public.preparations(prepid);


--
-- Name: pieces pieces_storageid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: brian
--

ALTER TABLE ONLY public.pieces
    ADD CONSTRAINT pieces_storageid_fkey FOREIGN KEY (storageid) REFERENCES public.storages(storageid);


--
-- Name: preparations preparations_storageid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: brian
--

ALTER TABLE ONLY public.preparations
    ADD CONSTRAINT preparations_storageid_fkey FOREIGN KEY (storageid) REFERENCES public.storages(storageid);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO role_readonly;
GRANT ALL ON SCHEMA public TO brian;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: analytics_owner
--

ALTER DEFAULT PRIVILEGES FOR ROLE analytics_owner IN SCHEMA public GRANT SELECT ON TABLES TO role_readonly;
ALTER DEFAULT PRIVILEGES FOR ROLE analytics_owner IN SCHEMA public GRANT INSERT,DELETE,UPDATE ON TABLES TO role_readwrite;


--
-- PostgreSQL database dump complete
--

\unrestrict CYDiDcaJCelHivsXBtMQmKRk7JXGlyuSpzAeAujsiIthB7DCpyMGJpNV8UvZ7o5

