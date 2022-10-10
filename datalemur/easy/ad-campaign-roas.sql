-- Question : Ad Campaign ROAS

-- Solution
SELECT
    advertiser_id,
    ROUND(SUM(revenue)::NUMERIC / SUM(spend), 2) AS ROAS
FROM ad_campaigns
GROUP BY advertiser_id
ORDER BY advertiser_id;