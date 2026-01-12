CREATE VIEW prep_piece_status AS
SELECT 
    p.prepid,
    p.piececid,
    d.state,
    d.provider
FROM pieces p
JOIN deals d ON d.piececid = p.piececid;

-- SELECT * FROM prep_piece_status WHERE prepid = 410;
