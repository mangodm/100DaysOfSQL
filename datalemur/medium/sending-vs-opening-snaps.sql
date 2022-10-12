-- Question : Sending vs. Opening Snaps

-- Solution
SELECT
    age_breakdown.age_bucket,
    ROUND(100.0 * SUM(CASE WHEN activity_type = 'send' THEN time_spent ELSE 0 END) /
    SUM(CASE WHEN activity_type IN ('send', 'open') THEN time_spent ELSE 0 END), 2) AS send_perc,
    ROUND(100.0 * SUM(CASE WHEN activity_type = 'open' THEN time_spent ELSE 0 END) /
    SUM(CASE WHEN activity_type IN ('send', 'open') THEN time_spent ELSE 0 END), 2) AS open_perc
FROM activities
INNER JOIN age_breakdown
    ON activities.user_id = age_breakdown.user_id
GROUP BY age_breakdown.age_bucket;