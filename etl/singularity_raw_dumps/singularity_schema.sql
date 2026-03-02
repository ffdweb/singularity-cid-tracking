--
-- PostgreSQL database dump
--

\restrict dhhx7Gixb7S9HWHOz1sfs5ZzcxDqqaKZEXEfmM2I2p1UxTaCGxKEHDRJtSX1mI8

-- Dumped from database version 16.6
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
-- Name: public; Type: SCHEMA; Schema: -; Owner: singularity
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO singularity;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: car_blocks; Type: TABLE; Schema: public; Owner: singularity
--

CREATE TABLE public.car_blocks (
    id bigint NOT NULL,
    cid bytea,
    car_offset bigint,
    car_block_length integer,
    varint bytea,
    raw_block bytea,
    file_offset bigint,
    car_id bigint,
    file_id bigint
)
WITH (autovacuum_vacuum_scale_factor='0.01');


ALTER TABLE public.car_blocks OWNER TO singularity;

--
-- Name: car_blocks_id_seq; Type: SEQUENCE; Schema: public; Owner: singularity
--

CREATE SEQUENCE public.car_blocks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.car_blocks_id_seq OWNER TO singularity;

--
-- Name: car_blocks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: singularity
--

ALTER SEQUENCE public.car_blocks_id_seq OWNED BY public.car_blocks.id;


--
-- Name: cars; Type: TABLE; Schema: public; Owner: singularity
--

CREATE TABLE public.cars (
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


ALTER TABLE public.cars OWNER TO singularity;

--
-- Name: cars_id_seq; Type: SEQUENCE; Schema: public; Owner: singularity
--

CREATE SEQUENCE public.cars_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cars_id_seq OWNER TO singularity;

--
-- Name: cars_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: singularity
--

ALTER SEQUENCE public.cars_id_seq OWNED BY public.cars.id;


--
-- Name: deals; Type: TABLE; Schema: public; Owner: singularity
--

CREATE TABLE public.deals (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    last_verified_at timestamp with time zone,
    deal_id bigint,
    state text,
    provider text,
    proposal_id text,
    label text,
    piece_cid bytea,
    piece_size bigint,
    start_epoch integer,
    end_epoch integer,
    sector_start_epoch integer,
    price text,
    verified boolean,
    error_message text,
    schedule_id bigint,
    client_id character varying(15)
);


ALTER TABLE public.deals OWNER TO singularity;

--
-- Name: deals_id_seq; Type: SEQUENCE; Schema: public; Owner: singularity
--

CREATE SEQUENCE public.deals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.deals_id_seq OWNER TO singularity;

--
-- Name: deals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: singularity
--

ALTER SEQUENCE public.deals_id_seq OWNED BY public.deals.id;


--
-- Name: directories; Type: TABLE; Schema: public; Owner: singularity
--

CREATE TABLE public.directories (
    id bigint NOT NULL,
    cid bytea,
    data bytea,
    name text,
    exported boolean,
    attachment_id bigint,
    parent_id bigint
);


ALTER TABLE public.directories OWNER TO singularity;

--
-- Name: directories_id_seq; Type: SEQUENCE; Schema: public; Owner: singularity
--

CREATE SEQUENCE public.directories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.directories_id_seq OWNER TO singularity;

--
-- Name: directories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: singularity
--

ALTER SEQUENCE public.directories_id_seq OWNED BY public.directories.id;


--
-- Name: file_ranges; Type: TABLE; Schema: public; Owner: singularity
--

CREATE TABLE public.file_ranges (
    id bigint NOT NULL,
    "offset" bigint,
    length bigint,
    cid bytea,
    job_id bigint,
    file_id bigint
);


ALTER TABLE public.file_ranges OWNER TO singularity;

--
-- Name: file_ranges_id_seq; Type: SEQUENCE; Schema: public; Owner: singularity
--

CREATE SEQUENCE public.file_ranges_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.file_ranges_id_seq OWNER TO singularity;

--
-- Name: file_ranges_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: singularity
--

ALTER SEQUENCE public.file_ranges_id_seq OWNED BY public.file_ranges.id;


--
-- Name: files; Type: TABLE; Schema: public; Owner: singularity
--

CREATE TABLE public.files (
    id bigint NOT NULL,
    cid bytea,
    path text,
    hash text,
    size bigint,
    last_modified_nano bigint,
    attachment_id bigint,
    directory_id bigint
);


ALTER TABLE public.files OWNER TO singularity;

--
-- Name: files_id_seq; Type: SEQUENCE; Schema: public; Owner: singularity
--

CREATE SEQUENCE public.files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.files_id_seq OWNER TO singularity;

--
-- Name: files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: singularity
--

ALTER SEQUENCE public.files_id_seq OWNED BY public.files.id;


--
-- Name: globals; Type: TABLE; Schema: public; Owner: singularity
--

CREATE TABLE public.globals (
    key text NOT NULL,
    value text
);


ALTER TABLE public.globals OWNER TO singularity;

--
-- Name: jobs; Type: TABLE; Schema: public; Owner: singularity
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    type text,
    state text,
    error_message text,
    error_stack_trace text,
    worker_id character varying(63),
    attachment_id bigint
);


ALTER TABLE public.jobs OWNER TO singularity;

--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: singularity
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.jobs_id_seq OWNER TO singularity;

--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: singularity
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- Name: output_attachments; Type: TABLE; Schema: public; Owner: singularity
--

CREATE TABLE public.output_attachments (
    id bigint NOT NULL,
    preparation_id bigint,
    storage_id bigint
);


ALTER TABLE public.output_attachments OWNER TO singularity;

--
-- Name: output_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: singularity
--

CREATE SEQUENCE public.output_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.output_attachments_id_seq OWNER TO singularity;

--
-- Name: output_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: singularity
--

ALTER SEQUENCE public.output_attachments_id_seq OWNED BY public.output_attachments.id;


--
-- Name: overpadded_jobs; Type: TABLE; Schema: public; Owner: singularity
--

CREATE TABLE public.overpadded_jobs (
    job_id bigint,
    car_id bigint,
    preparation_id bigint,
    source_attachment_id bigint,
    source_storage_id bigint,
    source_name text,
    preparation_name text,
    piece_size bigint,
    file_size bigint,
    ideal_size numeric,
    padding_ratio numeric
);


ALTER TABLE public.overpadded_jobs OWNER TO singularity;

--
-- Name: preparations; Type: TABLE; Schema: public; Owner: singularity
--

CREATE TABLE public.preparations (
    id bigint NOT NULL,
    name text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    delete_after_export boolean,
    max_size bigint,
    piece_size bigint,
    no_inline boolean,
    no_dag boolean,
    min_piece_size bigint
);


ALTER TABLE public.preparations OWNER TO singularity;

--
-- Name: preparations_id_seq; Type: SEQUENCE; Schema: public; Owner: singularity
--

CREATE SEQUENCE public.preparations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.preparations_id_seq OWNER TO singularity;

--
-- Name: preparations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: singularity
--

ALTER SEQUENCE public.preparations_id_seq OWNED BY public.preparations.id;


--
-- Name: schedules; Type: TABLE; Schema: public; Owner: singularity
--

CREATE TABLE public.schedules (
    id bigint NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    url_template text,
    http_headers json,
    provider text,
    price_per_gb_epoch numeric,
    price_per_gb numeric,
    price_per_deal numeric,
    total_deal_number bigint,
    total_deal_size bigint,
    verified boolean,
    keep_unsealed boolean,
    announce_to_ipni boolean,
    start_delay bigint,
    duration bigint,
    state text,
    schedule_cron text,
    schedule_cron_perpetual boolean,
    schedule_deal_number bigint,
    schedule_deal_size bigint,
    max_pending_deal_number bigint,
    max_pending_deal_size bigint,
    notes text,
    error_message text,
    allowed_piece_cids json,
    force boolean,
    preparation_id bigint,
    announce_to_ip_ni boolean,
    allowed_piece_c_ids json
);


ALTER TABLE public.schedules OWNER TO singularity;

--
-- Name: schedules_id_seq; Type: SEQUENCE; Schema: public; Owner: singularity
--

CREATE SEQUENCE public.schedules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.schedules_id_seq OWNER TO singularity;

--
-- Name: schedules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: singularity
--

ALTER SEQUENCE public.schedules_id_seq OWNED BY public.schedules.id;


--
-- Name: source_attachments; Type: TABLE; Schema: public; Owner: singularity
--

CREATE TABLE public.source_attachments (
    id bigint NOT NULL,
    preparation_id bigint,
    storage_id bigint,
    last_scanned_path text
);


ALTER TABLE public.source_attachments OWNER TO singularity;

--
-- Name: source_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: singularity
--

CREATE SEQUENCE public.source_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.source_attachments_id_seq OWNER TO singularity;

--
-- Name: source_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: singularity
--

ALTER SEQUENCE public.source_attachments_id_seq OWNED BY public.source_attachments.id;


--
-- Name: storages; Type: TABLE; Schema: public; Owner: singularity
--

CREATE TABLE public.storages (
    id bigint NOT NULL,
    name text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    type text,
    path text,
    config json,
    client_config json
);


ALTER TABLE public.storages OWNER TO singularity;

--
-- Name: storages_id_seq; Type: SEQUENCE; Schema: public; Owner: singularity
--

CREATE SEQUENCE public.storages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.storages_id_seq OWNER TO singularity;

--
-- Name: storages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: singularity
--

ALTER SEQUENCE public.storages_id_seq OWNED BY public.storages.id;


--
-- Name: wallet_assignments; Type: TABLE; Schema: public; Owner: singularity
--

CREATE TABLE public.wallet_assignments (
    preparation_id bigint NOT NULL,
    wallet_id character varying(15) NOT NULL
);


ALTER TABLE public.wallet_assignments OWNER TO singularity;

--
-- Name: wallets; Type: TABLE; Schema: public; Owner: singularity
--

CREATE TABLE public.wallets (
    id character varying(15) NOT NULL,
    address text,
    private_key text
);


ALTER TABLE public.wallets OWNER TO singularity;

--
-- Name: workers; Type: TABLE; Schema: public; Owner: singularity
--

CREATE TABLE public.workers (
    id text NOT NULL,
    last_heartbeat timestamp with time zone,
    hostname text,
    type text
);


ALTER TABLE public.workers OWNER TO singularity;

--
-- Name: car_blocks id; Type: DEFAULT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.car_blocks ALTER COLUMN id SET DEFAULT nextval('public.car_blocks_id_seq'::regclass);


--
-- Name: cars id; Type: DEFAULT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.cars ALTER COLUMN id SET DEFAULT nextval('public.cars_id_seq'::regclass);


--
-- Name: deals id; Type: DEFAULT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.deals ALTER COLUMN id SET DEFAULT nextval('public.deals_id_seq'::regclass);


--
-- Name: directories id; Type: DEFAULT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.directories ALTER COLUMN id SET DEFAULT nextval('public.directories_id_seq'::regclass);


--
-- Name: file_ranges id; Type: DEFAULT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.file_ranges ALTER COLUMN id SET DEFAULT nextval('public.file_ranges_id_seq'::regclass);


--
-- Name: files id; Type: DEFAULT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.files ALTER COLUMN id SET DEFAULT nextval('public.files_id_seq'::regclass);


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- Name: output_attachments id; Type: DEFAULT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.output_attachments ALTER COLUMN id SET DEFAULT nextval('public.output_attachments_id_seq'::regclass);


--
-- Name: preparations id; Type: DEFAULT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.preparations ALTER COLUMN id SET DEFAULT nextval('public.preparations_id_seq'::regclass);


--
-- Name: schedules id; Type: DEFAULT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.schedules ALTER COLUMN id SET DEFAULT nextval('public.schedules_id_seq'::regclass);


--
-- Name: source_attachments id; Type: DEFAULT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.source_attachments ALTER COLUMN id SET DEFAULT nextval('public.source_attachments_id_seq'::regclass);


--
-- Name: storages id; Type: DEFAULT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.storages ALTER COLUMN id SET DEFAULT nextval('public.storages_id_seq'::regclass);


--
-- Name: car_blocks car_blocks_pkey; Type: CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.car_blocks
    ADD CONSTRAINT car_blocks_pkey PRIMARY KEY (id);


--
-- Name: cars cars_pkey; Type: CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.cars
    ADD CONSTRAINT cars_pkey PRIMARY KEY (id);


--
-- Name: deals deals_deal_id_key; Type: CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.deals
    ADD CONSTRAINT deals_deal_id_key UNIQUE (deal_id);


--
-- Name: deals deals_pkey; Type: CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.deals
    ADD CONSTRAINT deals_pkey PRIMARY KEY (id);


--
-- Name: directories directories_pkey; Type: CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.directories
    ADD CONSTRAINT directories_pkey PRIMARY KEY (id);


--
-- Name: file_ranges file_ranges_pkey; Type: CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.file_ranges
    ADD CONSTRAINT file_ranges_pkey PRIMARY KEY (id);


--
-- Name: files files_pkey; Type: CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);


--
-- Name: globals globals_pkey; Type: CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.globals
    ADD CONSTRAINT globals_pkey PRIMARY KEY (key);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: output_attachments output_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.output_attachments
    ADD CONSTRAINT output_attachments_pkey PRIMARY KEY (id);


--
-- Name: preparations preparations_name_key; Type: CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.preparations
    ADD CONSTRAINT preparations_name_key UNIQUE (name);


--
-- Name: preparations preparations_pkey; Type: CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.preparations
    ADD CONSTRAINT preparations_pkey PRIMARY KEY (id);


--
-- Name: schedules schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT schedules_pkey PRIMARY KEY (id);


--
-- Name: source_attachments source_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.source_attachments
    ADD CONSTRAINT source_attachments_pkey PRIMARY KEY (id);


--
-- Name: storages storages_name_key; Type: CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.storages
    ADD CONSTRAINT storages_name_key UNIQUE (name);


--
-- Name: storages storages_pkey; Type: CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.storages
    ADD CONSTRAINT storages_pkey PRIMARY KEY (id);


--
-- Name: wallet_assignments wallet_assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.wallet_assignments
    ADD CONSTRAINT wallet_assignments_pkey PRIMARY KEY (preparation_id, wallet_id);


--
-- Name: wallets wallets_pkey; Type: CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT wallets_pkey PRIMARY KEY (id);


--
-- Name: workers workers_pkey; Type: CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.workers
    ADD CONSTRAINT workers_pkey PRIMARY KEY (id);


--
-- Name: cars_attachment_id_idx; Type: INDEX; Schema: public; Owner: singularity
--

CREATE INDEX cars_attachment_id_idx ON public.cars USING btree (attachment_id);


--
-- Name: cars_job_id_idx; Type: INDEX; Schema: public; Owner: singularity
--

CREATE INDEX cars_job_id_idx ON public.cars USING btree (job_id);


--
-- Name: cars_preparation_id_idx; Type: INDEX; Schema: public; Owner: singularity
--

CREATE INDEX cars_preparation_id_idx ON public.cars USING btree (preparation_id);


--
-- Name: cars_storage_id_idx; Type: INDEX; Schema: public; Owner: singularity
--

CREATE INDEX cars_storage_id_idx ON public.cars USING btree (storage_id);


--
-- Name: directory_source_parent; Type: INDEX; Schema: public; Owner: singularity
--

CREATE INDEX directory_source_parent ON public.directories USING btree (attachment_id, parent_id);


--
-- Name: idx_car_blocks_c_id; Type: INDEX; Schema: public; Owner: singularity
--

CREATE INDEX idx_car_blocks_c_id ON public.car_blocks USING btree (cid);


--
-- Name: idx_car_blocks_car_id; Type: INDEX; Schema: public; Owner: singularity
--

CREATE INDEX idx_car_blocks_car_id ON public.car_blocks USING btree (car_id);


--
-- Name: idx_cars_attachment_id; Type: INDEX; Schema: public; Owner: singularity
--

CREATE INDEX idx_cars_attachment_id ON public.cars USING btree (attachment_id);


--
-- Name: idx_cars_job_id; Type: INDEX; Schema: public; Owner: singularity
--

CREATE INDEX idx_cars_job_id ON public.cars USING btree (job_id);


--
-- Name: idx_cars_piece_c_id; Type: INDEX; Schema: public; Owner: singularity
--

CREATE INDEX idx_cars_piece_c_id ON public.cars USING btree (piece_cid);


--
-- Name: idx_cars_preparation_id; Type: INDEX; Schema: public; Owner: singularity
--

CREATE INDEX idx_cars_preparation_id ON public.cars USING btree (preparation_id);


--
-- Name: idx_cars_storage_id; Type: INDEX; Schema: public; Owner: singularity
--

CREATE INDEX idx_cars_storage_id ON public.cars USING btree (storage_id);


--
-- Name: idx_deals_piece_c_id; Type: INDEX; Schema: public; Owner: singularity
--

CREATE INDEX idx_deals_piece_c_id ON public.deals USING btree (piece_cid);


--
-- Name: idx_file_ranges_file_id; Type: INDEX; Schema: public; Owner: singularity
--

CREATE INDEX idx_file_ranges_file_id ON public.file_ranges USING btree (file_id);


--
-- Name: idx_file_ranges_job_id; Type: INDEX; Schema: public; Owner: singularity
--

CREATE INDEX idx_file_ranges_job_id ON public.file_ranges USING btree (job_id);


--
-- Name: idx_files_attachment_id; Type: INDEX; Schema: public; Owner: singularity
--

CREATE INDEX idx_files_attachment_id ON public.files USING btree (attachment_id);


--
-- Name: idx_files_directory_id; Type: INDEX; Schema: public; Owner: singularity
--

CREATE INDEX idx_files_directory_id ON public.files USING btree (directory_id);


--
-- Name: idx_files_path; Type: INDEX; Schema: public; Owner: singularity
--

CREATE INDEX idx_files_path ON public.files USING btree (path);


--
-- Name: idx_jobs_attachment_id; Type: INDEX; Schema: public; Owner: singularity
--

CREATE INDEX idx_jobs_attachment_id ON public.jobs USING btree (attachment_id);


--
-- Name: idx_jobs_worker_id; Type: INDEX; Schema: public; Owner: singularity
--

CREATE INDEX idx_jobs_worker_id ON public.jobs USING btree (worker_id);


--
-- Name: idx_pending; Type: INDEX; Schema: public; Owner: singularity
--

CREATE INDEX idx_pending ON public.deals USING btree (state, client_id);


--
-- Name: idx_wallets_address; Type: INDEX; Schema: public; Owner: singularity
--

CREATE INDEX idx_wallets_address ON public.wallets USING btree (address);


--
-- Name: job_type_state; Type: INDEX; Schema: public; Owner: singularity
--

CREATE INDEX job_type_state ON public.jobs USING btree (type, state);


--
-- Name: jobs_attachment_id_idx; Type: INDEX; Schema: public; Owner: singularity
--

CREATE INDEX jobs_attachment_id_idx ON public.jobs USING btree (attachment_id);


--
-- Name: jobs_worker_id_idx; Type: INDEX; Schema: public; Owner: singularity
--

CREATE INDEX jobs_worker_id_idx ON public.jobs USING btree (worker_id);


--
-- Name: prep_output; Type: INDEX; Schema: public; Owner: singularity
--

CREATE UNIQUE INDEX prep_output ON public.output_attachments USING btree (preparation_id, storage_id);


--
-- Name: prep_source; Type: INDEX; Schema: public; Owner: singularity
--

CREATE UNIQUE INDEX prep_source ON public.source_attachments USING btree (preparation_id, storage_id);


--
-- Name: car_blocks fk_car_blocks_car; Type: FK CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.car_blocks
    ADD CONSTRAINT fk_car_blocks_car FOREIGN KEY (car_id) REFERENCES public.cars(id) ON DELETE SET NULL;


--
-- Name: car_blocks fk_car_blocks_file; Type: FK CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.car_blocks
    ADD CONSTRAINT fk_car_blocks_file FOREIGN KEY (file_id) REFERENCES public.files(id) ON DELETE CASCADE;


--
-- Name: cars fk_cars_attachment; Type: FK CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.cars
    ADD CONSTRAINT fk_cars_attachment FOREIGN KEY (attachment_id) REFERENCES public.source_attachments(id) ON DELETE SET NULL;


--
-- Name: cars fk_cars_job; Type: FK CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.cars
    ADD CONSTRAINT fk_cars_job FOREIGN KEY (job_id) REFERENCES public.jobs(id) ON DELETE SET NULL;


--
-- Name: cars fk_cars_preparation; Type: FK CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.cars
    ADD CONSTRAINT fk_cars_preparation FOREIGN KEY (preparation_id) REFERENCES public.preparations(id) ON DELETE SET NULL;


--
-- Name: cars fk_cars_storage; Type: FK CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.cars
    ADD CONSTRAINT fk_cars_storage FOREIGN KEY (storage_id) REFERENCES public.storages(id) ON DELETE SET NULL;


--
-- Name: deals fk_deals_schedule; Type: FK CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.deals
    ADD CONSTRAINT fk_deals_schedule FOREIGN KEY (schedule_id) REFERENCES public.schedules(id) ON DELETE SET NULL;


--
-- Name: deals fk_deals_wallet; Type: FK CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.deals
    ADD CONSTRAINT fk_deals_wallet FOREIGN KEY (client_id) REFERENCES public.wallets(id) ON DELETE SET NULL;


--
-- Name: directories fk_directories_attachment; Type: FK CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.directories
    ADD CONSTRAINT fk_directories_attachment FOREIGN KEY (attachment_id) REFERENCES public.source_attachments(id) ON DELETE SET NULL;


--
-- Name: directories fk_directories_parent; Type: FK CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.directories
    ADD CONSTRAINT fk_directories_parent FOREIGN KEY (parent_id) REFERENCES public.directories(id) ON DELETE CASCADE;


--
-- Name: files fk_files_attachment; Type: FK CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT fk_files_attachment FOREIGN KEY (attachment_id) REFERENCES public.source_attachments(id) ON DELETE SET NULL;


--
-- Name: files fk_files_directory; Type: FK CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT fk_files_directory FOREIGN KEY (directory_id) REFERENCES public.directories(id) ON DELETE CASCADE;


--
-- Name: file_ranges fk_files_file_ranges; Type: FK CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.file_ranges
    ADD CONSTRAINT fk_files_file_ranges FOREIGN KEY (file_id) REFERENCES public.files(id) ON DELETE CASCADE;


--
-- Name: jobs fk_jobs_attachment; Type: FK CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT fk_jobs_attachment FOREIGN KEY (attachment_id) REFERENCES public.source_attachments(id) ON DELETE SET NULL;


--
-- Name: file_ranges fk_jobs_file_ranges; Type: FK CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.file_ranges
    ADD CONSTRAINT fk_jobs_file_ranges FOREIGN KEY (job_id) REFERENCES public.jobs(id) ON DELETE SET NULL;


--
-- Name: jobs fk_jobs_worker; Type: FK CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT fk_jobs_worker FOREIGN KEY (worker_id) REFERENCES public.workers(id) ON DELETE SET NULL;


--
-- Name: output_attachments fk_output_attachments_preparation; Type: FK CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.output_attachments
    ADD CONSTRAINT fk_output_attachments_preparation FOREIGN KEY (preparation_id) REFERENCES public.preparations(id) ON DELETE CASCADE;


--
-- Name: output_attachments fk_output_attachments_storage; Type: FK CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.output_attachments
    ADD CONSTRAINT fk_output_attachments_storage FOREIGN KEY (storage_id) REFERENCES public.storages(id) ON DELETE CASCADE;


--
-- Name: schedules fk_schedules_preparation; Type: FK CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.schedules
    ADD CONSTRAINT fk_schedules_preparation FOREIGN KEY (preparation_id) REFERENCES public.preparations(id) ON DELETE CASCADE;


--
-- Name: source_attachments fk_source_attachments_preparation; Type: FK CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.source_attachments
    ADD CONSTRAINT fk_source_attachments_preparation FOREIGN KEY (preparation_id) REFERENCES public.preparations(id) ON DELETE CASCADE;


--
-- Name: source_attachments fk_source_attachments_storage; Type: FK CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.source_attachments
    ADD CONSTRAINT fk_source_attachments_storage FOREIGN KEY (storage_id) REFERENCES public.storages(id) ON DELETE CASCADE;


--
-- Name: wallet_assignments fk_wallet_assignments_preparation; Type: FK CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.wallet_assignments
    ADD CONSTRAINT fk_wallet_assignments_preparation FOREIGN KEY (preparation_id) REFERENCES public.preparations(id);


--
-- Name: wallet_assignments fk_wallet_assignments_wallet; Type: FK CONSTRAINT; Schema: public; Owner: singularity
--

ALTER TABLE ONLY public.wallet_assignments
    ADD CONSTRAINT fk_wallet_assignments_wallet FOREIGN KEY (wallet_id) REFERENCES public.wallets(id);


--
-- PostgreSQL database dump complete
--

\unrestrict dhhx7Gixb7S9HWHOz1sfs5ZzcxDqqaKZEXEfmM2I2p1UxTaCGxKEHDRJtSX1mI8

