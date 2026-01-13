Very rough working-inpublic scratch space for tracking FFDW data uploading projects that use Singularity

3rd party deals can be tracked as per https://github.com/data-preservation-programs/singularity/pull/550

Feel free to email ian@fil.org with any questions

---

ETL Steps in this order

Manual: Clients, Providers

1) Storages
2) Preps
3) Pieces
4) Deals
5) Contents

disambiguating: "items" pulled from ia search or CLI. "contents" pulled from singularity storage explore by parsing _meta.xml file names

---

Main tracking tables from original brainstorm created and loaded as such

analytics=> \dn
                   List of schemas
               Name               |       Owner       
----------------------------------+-------------------
 items_import                     | brian
 lotus_import                     | brian
 pa_collection_lists              | brian
 public                           | pg_database_owner
 static_ia_collection_identifiers | brian
 union_lists                      | brian
(6 rows)

analytics=> \dt
                List of tables
 Schema |         Name         | Type  | Owner 
--------+----------------------+-------+-------
 public | clients              | table | brian
 public | contents             | table | brian
 public | contents_staging     | table | brian
 public | deals                | table | brian
 public | deals_staging        | table | brian
 public | pieces               | table | brian
 public | pieces_staging       | table | brian
 public | preparations         | table | brian
 public | preparations_staging | table | brian
 public | providers            | table | brian
 public | storages             | table | brian
 public | storages_staging     | table | brian
(12 rows)
