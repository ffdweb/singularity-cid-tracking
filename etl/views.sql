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
