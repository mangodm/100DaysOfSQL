-- 01. 
-- Description
-- ABC analysis for rentals

-- Solution
WITH rentals_list AS (

    SELECT
        category.name AS category_name,
        COUNT(rental_id) AS rental_count
    FROM rental
    INNER JOIN inventory
        ON rental.inventory_id = inventory.inventory_id
    INNER JOIN film
        ON inventory.film_id = film.film_id
    INNER JOIN film_category
        ON film.film_id = film_category.film_id
    INNER JOIN category
        ON film_category.category_id = category.category_id
    GROUP BY category.name
    
), rentals_composition_ratio AS (

    SELECT 
        category_name,
        rental_count,
        100.0 * rental_count / SUM(rental_count) OVER() AS composition_ratio,
        100.0 * SUM(rental_count) OVER(ORDER BY rental_count DESC) / SUM(rental_count) OVER() AS cumulative_ratio
    FROM rentals_list
)

SELECT
    *,
    CASE
        WHEN cumulative_ratio BETWEEN 0 AND 70 THEN 'A'
        WHEN cumulative_ratio BETWEEN 70 AND 90 THEN 'B'
        ELSE 'C'
    END AS abc_rank
FROM rentals_composition_ratio
ORDER BY composition_ratio DESC;