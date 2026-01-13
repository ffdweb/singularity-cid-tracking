-- all client x provider totals

SELECT
    c.clientid,
    CASE
        WHEN c.active THEN c.clientowner || '-active'
        ELSE c.clientowner || '-legacy'
    END AS client_owner_status,
    p.providerid,
    p.providername,
    SUM(d.piecesize) AS total_data_bytes,
    ROUND(SUM(d.piecesize) / 1099511627776.0, 2) AS total_data_tebibytes
FROM deals d
JOIN clients c ON d.clientid = c.clientid
JOIN providers p ON d.provider = p.providerid
WHERE d.state = 'active'
GROUP BY c.clientid, client_owner_status, p.providerid, p.providername
ORDER BY total_data_bytes DESC;



-- all client x provider by month

SELECT
    TO_CHAR(TO_TIMESTAMP(1598306400 + d.startepoch * 30), 'YYYY-MM') AS month,
    c.clientid,
    CASE
        WHEN c.active THEN c.clientowner || '-active'
        ELSE c.clientowner || '-legacy'
    END AS client_owner_status,
    p.providerid,
    p.providername,
    SUM(d.piecesize) AS total_data_bytes,
    ROUND(SUM(d.piecesize) / 1099511627776.0, 2) AS total_data_tebibytes
FROM deals d
JOIN clients c ON d.clientid = c.clientid
JOIN providers p ON d.provider = p.providerid
WHERE d.state = 'active'
GROUP BY
    month,
    c.clientid,
    client_owner_status,
    p.providerid,
    p.providername
ORDER BY
    month ASC,
    c.clientid,
    p.providerid;
    
    
    
-- check invoices
-- substitute provider id and ::timestamp

SELECT
    c.clientid,
    CASE
        WHEN c.active THEN c.clientowner || '-active'
        ELSE c.clientowner || '-legacy'
    END AS client_owner_status,
    SUM(d.piecesize) AS total_data_bytes,
    ROUND(SUM(d.piecesize) / 1099511627776.0, 2) AS total_data_tebibytes
FROM deals d
JOIN clients c ON d.clientid = c.clientid
WHERE d.provider = 'f02639429'
  AND d.state = 'active'
  AND TO_TIMESTAMP(1598306400 + d.startepoch * 30) <= '2026-01-01'::timestamp
GROUP BY c.clientid, client_owner_status
ORDER BY c.clientid;


--preps with legacy prelinger active deals

SELECT DISTINCT p.prepid, p.name
FROM preparations p
JOIN pieces pi ON pi.prepid = p.prepid
JOIN deals d ON d.piececid = pi.piececid
WHERE d.clientid = 'f02208630'
  AND d.state = 'active'
ORDER BY p.prepid;


-- deals for client wallet with earliest expiration (here inactive prelinger)
-- deals_full from lotus needs refresh.

SELECT
    p.prepid,
    p.name AS preparation_name,
    MIN(df.endepoch) AS earliest_expiring_endepoch,
    TO_TIMESTAMP(1598306400 + MIN(df.endepoch) * 30) AS earliest_expiring_timestamp
FROM preparations p
JOIN pieces pi
    ON pi.prepid = p.prepid
JOIN deals_full df
    ON df.piececid = pi.piececid
WHERE df.client = 'f02208630'
  AND df.endepoch > 0  -- Filter out slashed or invalid deals
GROUP BY p.prepid, p.name
ORDER BY p.prepid;
