-- Question : Page With No Likes

-- Solution
SELECT page_id
FROM pages
WHERE page_id NOT IN (SELECT DISTINCT page_id
                      FROM page_likes)
ORDER BY page_id;