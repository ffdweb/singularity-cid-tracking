-- piece statuses per provider by preparation
SELECT 
    p.prepid,
    p.piececid,
    BOOL_OR(d.state = 'active' AND d.provider = 'f02011071') AS f02011071,
    BOOL_OR(d.state = 'active' AND d.provider = 'f02639429') AS f02639429,
    BOOL_OR(d.state = 'active' AND d.provider = 'f03468521') AS f03468521
FROM pieces p
LEFT JOIN deals d ON d.piececid = p.piececid
WHERE p.prepid = 410
GROUP BY p.prepid, p.piececid
ORDER BY p.piececid;


-- all active t/f by provider for all preparations
SELECT
    p.prepid,
    COUNT(DISTINCT p.piececid) AS total_pieces,
    COUNT(DISTINCT CASE WHEN d.provider = 'f02011071' AND d.state = 'active' THEN p.piececid END) = COUNT(DISTINCT p.piececid) AS all_f02011071,
    COUNT(DISTINCT CASE WHEN d.provider = 'f02639429' AND d.state = 'active' THEN p.piececid END) = COUNT(DISTINCT p.piececid) AS all_f02639429,
    COUNT(DISTINCT CASE WHEN d.provider = 'f03468521' AND d.state = 'active' THEN p.piececid END) = COUNT(DISTINCT p.piececid) AS all_f03468521
FROM pieces p
LEFT JOIN deals d ON d.piececid = p.piececid
GROUP BY p.prepid
ORDER BY p.prepid;
