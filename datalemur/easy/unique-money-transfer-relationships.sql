-- Question : Unique Money Transfer Relationships

-- Solution
SELECT (COUNT(*) / 2)::INT AS unique_relationships
FROM (
SELECT
    DISTINCT p1.payer_id,
    p1.recipient_id
FROM payments AS p1 
INNER JOIN payments AS p2 
    ON p1.payer_id = p2.recipient_id
   AND p1.recipient_id = p2.payer_id) tmp ;