-- Question : Average Post Hiatus (Part 1)

-- Solution
SELECT
    user_id,
    (MAX(post_date)::DATE - MIN(post_date)::DATE) AS days_between
FROM posts
WHERE LEFT(post_date::VARCHAR, 4) = '2021'
GROUP BY user_id
HAVING COUNT(DISTINCT post_id) >= 2;