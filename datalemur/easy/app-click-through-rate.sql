-- Question : App Click-through Rate (CTR)

-- Solution
SELECT
    app_id,
    ROUND((SUM(CASE WHEN event_type = 'click' THEN 1 ELSE 0 END)::NUMERIC / SUM(CASE WHEN event_type = 'impression' THEN 1 ELSE 0 END)) * 100.0, 2) AS ctr
FROM events
WHERE LEFT(timestamp::VARCHAR, 4) = '2022'
GROUP BY app_id;