-- preps fully sealed by provider

SELECT p.PrepID,
       p.Name
FROM preparations p
JOIN (
    SELECT pc.PrepID,
           COUNT(*) AS total_pieces,
           COUNT(DISTINCT d.PieceCID) AS pieces_with_active_deal
    FROM pieces pc
    LEFT JOIN deals d
        ON pc.PieceCID = d.PieceCID
        AND d.Provider = 'f02011071'
        AND d.State = 'active'
    GROUP BY pc.PrepID
) stats
  ON p.PrepID = stats.PrepID
WHERE stats.total_pieces = stats.pieces_with_active_deal
ORDER BY p.PrepID ASC;
