-- 01. 
-- Description
-- Write a query that displays a table with 4 columns: actor's full name, film title, length of movie, 
-- and a column name "filmlen_groups" that classifies movies based on their length. 
-- Filmlen_groups should include 4 categories: 1 hour or less, Between 1-2 hours, Between 2-3 hours, More than 3 hours.

-- Solution
SELECT
    CONCAT(actor.first_name, ' ', actor.last_name) AS full_name,
    film.title,
    film.length,
    CASE
        WHEN length < 60 THEN '1 hour or less'
        WHEN length < 120 THEN '1-2 hours'
        WHEN length < 180 THEN '2-3 hours'
        ELSE 'more than 3 hours'
    END AS filmlen_groups
FROM film
INNER JOIN film_actor
    ON film.film_id = film_actor.film_id
INNER JOIN actor
    ON film_actor.actor_id = actor.actor_id;

-- 02.
-- Description
-- Now, we bring in the advanced SQL query concepts! 
-- Revise the query you wrote above to create a count of movies in each of the 4 filmlen_groups: 
-- 1 hour or less, Between 1-2 hours, Between 2-3 hours, More than 3 hours.

-- Solution
WITH film_list AS (

    SELECT
        film.film_id,
        CASE
            WHEN length <= 60 THEN '1 hour or less'
            WHEN length <= 120 THEN '1-2 hours'
            WHEN length <= 180 THEN '2-3 hours'
            ELSE 'more than 3 hours'
        END AS filmlen_groups
    FROM film

)

SELECT
    filmlen_groups,
    COUNT(*)
FROM film_list
GROUP BY filmlen_groups;
