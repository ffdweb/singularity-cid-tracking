Very rough working-inpublic scratch space for tracking FFDW data uploading projects that use Singularity

3rd party deals can be tracked as per https://github.com/data-preservation-programs/singularity/pull/550

Feel free to email ian@fil.org with any questions

---

Internal db schema:
```
table_name          type   has_sql
------------------  -----  -------
car_blocks          table  1      -flatten to pieces
cars                table  1      -flatten to pieces
deals               table  1      -keep
directories         table  1      -flatten to contents
file_ranges         table  1      -disregard
files               table  1      -flatten to contents
globals             table  1      -disregard
jobs                table  1      -disregard
output_attachments  table  1      -disregard
preparations        table  1      -keep
schedules           table  1      -disregard
source_attachments  table  1      -flatten to storages
storages            table  1      -flatten to storages
wallet_assignments  table  1      -disregard
wallets             table  1      -"clients"
workers             table  1      -disregard
```

---

Tracking Tables:
storages* (specifically source storages) - daily import via script and staging table
preps - daily import via script and staging table
pieces - daily import via script and staging table
deals - daily import via script and staging table
items* - import once per IA collection at time of packing from ia search results
contents - import once packing is complete to cross reference contents
clients - create once, update if needed
providers - create once, update if needed

*disambiguating: only interested in source storages for our use case
*disambiguating: "items" pulled from ia search CLI. "contents" pulled from singularity storage explore by parsing _meta.xml file names
