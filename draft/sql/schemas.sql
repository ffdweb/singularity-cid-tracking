analytics=> \d+ deals
                                                   Table "public.deals"
   Column   |         Type          | Collation | Nullable | Default | Storage  | Compression | Stats target | Description 
------------+-----------------------+-----------+----------+---------+----------+-------------+--------------+-------------
 dealid     | bigint                |           | not null |         | plain    |             |              | 
 state      | character varying(50) |           | not null |         | extended |             |              | 
 provider   | character varying(50) |           | not null |         | extended |             |              | 
 piececid   | text                  |           | not null |         | extended |             |              | 
 piecesize  | bigint                |           | not null |         | plain    |             |              | 
 startepoch | bigint                |           | not null |         | plain    |             |              | 
 price      | bigint                |           | not null |         | plain    |             |              | 
 verified   | boolean               |           | not null |         | plain    |             |              | 
 clientid   | character varying(50) |           | not null |         | extended |             |              | 
Indexes:
    "deals_pkey" PRIMARY KEY, btree (dealid)
Foreign-key constraints:
    "fk_deals_clients" FOREIGN KEY (clientid) REFERENCES clients(clientid)
Access method: heap

analytics=> \d+ clients
                                                    Table "public.clients"
    Column     |         Type          | Collation | Nullable | Default | Storage  | Compression | Stats target | Description 
---------------+-----------------------+-----------+----------+---------+----------+-------------+--------------+-------------
 clientid      | character varying(20) |           | not null |         | extended |             |              | 
 clientaddress | text                  |           | not null |         | extended |             |              | 
 active        | boolean               |           | not null |         | plain    |             |              | 
 clientowner   | character varying(10) |           | not null |         | extended |             |              | 
Indexes:
    "clients_pkey" PRIMARY KEY, btree (clientid)
Referenced by:
    TABLE "deals" CONSTRAINT "fk_deals_clients" FOREIGN KEY (clientid) REFERENCES clients(clientid)
Access method: heap

analytics=> \d+ pieces
                                           Table "public.pieces"
  Column   |  Type   | Collation | Nullable | Default | Storage  | Compression | Stats target | Description 
-----------+---------+-----------+----------+---------+----------+-------------+--------------+-------------
 piececid  | text    |           | not null |         | extended |             |              | 
 piecesize | bigint  |           | not null |         | plain    |             |              | 
 rootcid   | text    |           | not null |         | extended |             |              | 
 filesize  | bigint  |           | not null |         | plain    |             |              | 
 storageid | bigint  |           | not null |         | plain    |             |              | 
 prepid    | bigint  |           | not null |         | plain    |             |              | 
 isdag     | boolean |           | not null |         | plain    |             |              | 
Indexes:
    "pieces_pkey" PRIMARY KEY, btree (piececid, prepid, storageid)
Access method: heap

analytics=> \d+ storages
                                           Table "public.storages"
   Column    |  Type  | Collation | Nullable | Default | Storage  | Compression | Stats target | Description 
-------------+--------+-----------+----------+---------+----------+-------------+--------------+-------------
 storageid   | bigint |           | not null |         | plain    |             |              | 
 storagename | text   |           | not null |         | extended |             |              | 
 type        | text   |           |          |         | extended |             |              | 
 path        | text   |           |          |         | extended |             |              | 
Indexes:
    "storages_pkey" PRIMARY KEY, btree (storageid)
Referenced by:
    TABLE "preparations" CONSTRAINT "preparations_storageid_fkey" FOREIGN KEY (storageid) REFERENCES storages(storageid)
Access method: heap

analytics=> \d+ preparations
                                        Table "public.preparations"
  Column   |  Type  | Collation | Nullable | Default | Storage  | Compression | Stats target | Description 
-----------+--------+-----------+----------+---------+----------+-------------+--------------+-------------
 prepid    | bigint |           | not null |         | plain    |             |              | 
 name      | text   |           | not null |         | extended |             |              | 
 storageid | bigint |           |          |         | plain    |             |              | 
Indexes:
    "preparations_pkey" PRIMARY KEY, btree (prepid)
Foreign-key constraints:
    "preparations_storageid_fkey" FOREIGN KEY (storageid) REFERENCES storages(storageid)
Referenced by:
    TABLE "items" CONSTRAINT "items_preparationid_fkey" FOREIGN KEY (preparationid) REFERENCES preparations(prepid)
Access method: heap

analytics=> \d+ items
                                                 Table "public.items"
    Column     |     Type      | Collation | Nullable | Default | Storage  | Compression | Stats target | Description 
---------------+---------------+-----------+----------+---------+----------+-------------+--------------+-------------
 identifier    | text          |           | not null |         | extended |             |              | 
 itemsizegib   | numeric(12,3) |           |          |         | main     |             |              | 
 preparationid | bigint        |           |          |         | plain    |             |              | 
 piecescount   | integer       |           |          |         | plain    |             |              | 
 packedsizegib | numeric(12,3) |           |          |         | main     |             |              | 
Indexes:
    "items_pkey" PRIMARY KEY, btree (identifier)
Foreign-key constraints:
    "items_preparationid_fkey" FOREIGN KEY (preparationid) REFERENCES preparations(prepid)
Access method: heap
