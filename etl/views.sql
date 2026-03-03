CREATE OR REPLACE VIEW public.deals_by_provider_month AS
SELECT
    d.provider,
    pr.providername,
    TO_CHAR(DATE_TRUNC('month', TO_TIMESTAMP(1598306400 + d.startepoch * 30)), 'YYYY-MM') AS deal_month,
    COUNT(*) AS deal_count
FROM public.deals d
JOIN public.providers pr ON d.provider = pr.providerid
WHERE d.state = 'active'
GROUP BY d.provider, pr.providername, deal_month
ORDER BY d.provider, deal_month;

CREATE OR REPLACE VIEW public.deals_by_client_month AS
SELECT
    d.clientid,
    TO_CHAR(DATE_TRUNC('month', TO_TIMESTAMP(1598306400 + d.startepoch * 30)), 'YYYY-MM') AS deal_month,
    COUNT(*) AS deal_count
FROM public.deals d
JOIN public.clients c ON d.clientid = c.clientid
WHERE d.state = 'active'
GROUP BY d.clientid, deal_month
ORDER BY d.clientid, deal_month;

CREATE OR REPLACE VIEW public.milad_total_by_month AS
WITH monthly AS (
    SELECT
        d.provider,
        DATE_TRUNC(
            'month',
            TO_TIMESTAMP(1598306400 + d.startepoch * 30)
        ) AS deal_month,
        COUNT(*) AS deals_this_month,
        SUM(d.piecesize) AS bytes_this_month
    FROM public.deals d
    WHERE d.provider = 'f02639429'
      AND d.state = 'active'
    GROUP BY d.provider, deal_month
)
SELECT
    provider,
    TO_CHAR(deal_month, 'YYYY-MM') AS deal_month,
    deals_this_month,
    ROUND(bytes_this_month / 1099511627776.0, 2) AS tib_this_month,
    SUM(deals_this_month) OVER (
        PARTITION BY provider
        ORDER BY deal_month
    ) AS running_deals_total,
    ROUND(
        SUM(bytes_this_month) OVER (
            PARTITION BY provider
            ORDER BY deal_month
        ) / 1099511627776.0,
        2
    ) AS running_tib_total
FROM monthly
ORDER BY deal_month;

CREATE OR REPLACE VIEW public.milad_total_by_month_excl_f02208630 AS
WITH monthly AS (
    SELECT
        d.provider,
        DATE_TRUNC(
            'month',
            TO_TIMESTAMP(1598306400 + d.startepoch * 30)
        ) AS deal_month,
        COUNT(*) AS deals_this_month,
        SUM(d.piecesize) AS bytes_this_month
    FROM public.deals d
    WHERE d.provider = 'f02639429'
      AND d.state = 'active'
      AND d.clientid != 'f02208630'
    GROUP BY d.provider, deal_month
)
SELECT
    provider,
    TO_CHAR(deal_month, 'YYYY-MM') AS deal_month,
    deals_this_month,
    ROUND(bytes_this_month / 1099511627776.0, 2) AS tib_this_month,
    SUM(deals_this_month) OVER (
        PARTITION BY provider
        ORDER BY deal_month
    ) AS running_deals_total,
    ROUND(
        SUM(bytes_this_month) OVER (
            PARTITION BY provider
            ORDER BY deal_month
        ) / 1099511627776.0,
        2
    ) AS running_tib_total
FROM monthly
ORDER BY deal_month;

CREATE OR REPLACE VIEW public.dcent_total_by_month AS
WITH monthly AS (
    SELECT
        d.provider,
        DATE_TRUNC('month', TO_TIMESTAMP((1598306400 + (d.startepoch * 30))::double precision)) AS deal_month,
        COUNT(*) AS deals_this_month,
        SUM(d.piecesize) AS bytes_this_month
    FROM deals d
    WHERE d.provider = 'f03468521'
      AND d.state = 'active'
    GROUP BY d.provider, DATE_TRUNC('month', TO_TIMESTAMP((1598306400 + (d.startepoch * 30))::double precision))
)
SELECT
    provider,
    TO_CHAR(deal_month, 'YYYY-MM') AS deal_month,
    deals_this_month,
    ROUND(bytes_this_month / 1099511627776.0, 2) AS tib_this_month,
    SUM(deals_this_month) OVER (PARTITION BY provider ORDER BY deal_month) AS running_deals_total,
    ROUND(SUM(bytes_this_month) OVER (PARTITION BY provider ORDER BY deal_month) / 1099511627776.0, 2) AS running_tib_total
FROM monthly
ORDER BY TO_CHAR(deal_month, 'YYYY-MM');

CREATE OR REPLACE VIEW public.tillie_total_by_month AS
WITH monthly AS (
    SELECT
        d.provider,
        DATE_TRUNC('month', TO_TIMESTAMP((1598306400 + (d.startepoch * 30))::double precision)) AS deal_month,
        COUNT(*) AS deals_this_month,
        SUM(d.piecesize) AS bytes_this_month
    FROM deals d
    WHERE d.provider = 'f02011071'
      AND d.state = 'active'
    GROUP BY d.provider, DATE_TRUNC('month', TO_TIMESTAMP((1598306400 + (d.startepoch * 30))::double precision))
)
SELECT
    provider,
    TO_CHAR(deal_month, 'YYYY-MM') AS deal_month,
    deals_this_month,
    ROUND(bytes_this_month / 1099511627776.0, 2) AS tib_this_month,
    SUM(deals_this_month) OVER (PARTITION BY provider ORDER BY deal_month) AS running_deals_total,
    ROUND(SUM(bytes_this_month) OVER (PARTITION BY provider ORDER BY deal_month) / 1099511627776.0, 2) AS running_tib_total
FROM monthly
ORDER BY TO_CHAR(deal_month, 'YYYY-MM');

CREATE OR REPLACE VIEW public.ia_deals_by_month AS
WITH monthly AS (
    SELECT
        d.clientid,
        DATE_TRUNC('month', TO_TIMESTAMP((1598306400 + (d.startepoch * 30))::double precision)) AS deal_month,
        COUNT(*) AS deals_this_month
    FROM deals d
    JOIN clients c ON d.clientid = c.clientid
    WHERE d.state = 'active'
      AND d.clientid = ANY (ARRAY['f01131298', 'f03510418'])
    GROUP BY d.clientid, DATE_TRUNC('month', TO_TIMESTAMP((1598306400 + (d.startepoch * 30))::double precision))
)
SELECT
    clientid,
    TO_CHAR(deal_month, 'YYYY-MM') AS deal_month,
    deals_this_month AS deal_count
FROM monthly
ORDER BY TO_CHAR(deal_month, 'YYYY-MM'), clientid;

CREATE OR REPLACE VIEW public.prelinger_deals_by_month AS
WITH monthly AS (
    SELECT
        d.clientid,
        DATE_TRUNC('month', TO_TIMESTAMP((1598306400 + (d.startepoch * 30))::double precision)) AS deal_month,
        COUNT(*) AS deals_this_month
    FROM deals d
    JOIN clients c ON d.clientid = c.clientid
    WHERE d.state = 'active'
      AND d.clientid = ANY (ARRAY['f02208630', 'f03091977'])
    GROUP BY d.clientid, DATE_TRUNC('month', TO_TIMESTAMP((1598306400 + (d.startepoch * 30))::double precision))
)
SELECT
    clientid,
    TO_CHAR(deal_month, 'YYYY-MM') AS deal_month,
    deals_this_month AS deal_count
FROM monthly
ORDER BY TO_CHAR(deal_month, 'YYYY-MM'), clientid;

CREATE OR REPLACE VIEW public.vw_input_identifier_pieces AS
WITH input AS (
    SELECT my_identifier FROM input_identifier LIMIT 1
),
u AS (
    SELECT pum.unionname
    FROM item_mapping.prelinger_union_map pum
    JOIN input i ON pum.identifier = i.my_identifier
),
prep AS (
    SELECT p.prepid
    FROM preparations p
    JOIN u ON p.name = u.unionname
)
SELECT
    prep.prepid,
    pcs.piece_cid,
    pcs.piece_size,
    pcs.is_dag
FROM prep
JOIN pieces pcs ON pcs.preparation_id = prep.prepid;

CREATE OR REPLACE VIEW public.vw_input_identifier_piece_provider_status AS
WITH base AS (
    SELECT
        vw_input_identifier_pieces.prepid,
        vw_input_identifier_pieces.piece_cid,
        vw_input_identifier_pieces.piece_size,
        vw_input_identifier_pieces.is_dag
    FROM vw_input_identifier_pieces
),
active_deals AS (
    SELECT deals.piececid, deals.provider
    FROM deals
    WHERE deals.state = 'active'
      AND deals.provider = ANY (ARRAY['f02011071', 'f02639429', 'f03468521'])
    GROUP BY deals.piececid, deals.provider
)
SELECT
    b.prepid,
    b.piece_cid,
    b.piece_size,
    b.is_dag,
    COALESCE(bool_or(ad.provider = 'f02011071'), false) AS f02011071_active,
    COALESCE(bool_or(ad.provider = 'f02639429'), false) AS f02639429_active,
    COALESCE(bool_or(ad.provider = 'f03468521'), false) AS f03468521_active
FROM base b
LEFT JOIN active_deals ad ON ad.piececid = b.piece_cid
GROUP BY b.prepid, b.piece_cid, b.piece_size, b.is_dag;
