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

-- 02.
-- Description
-- Top 3 genres by country

-- Solution
WITH country_category_count_list AS (

    SELECT
        country.country,
        category.name AS category_name,
        COUNT(*) AS rental_count,
        RANK() OVER (PARTITION BY country ORDER BY COUNT(*) DESC) AS rn
    FROM rental
    INNER JOIN inventory 
        ON rental.inventory_id = inventory.inventory_id
    INNER JOIN film
        ON inventory.film_id = film.film_id
    INNER JOIN film_category
        ON film.film_id = film_category.film_id
    INNER JOIN category
        ON film_category.category_id = category.category_id
    INNER JOIN customer
        ON rental.customer_id = customer.customer_id
    INNER JOIN address
        ON customer.address_id = address.address_id
    INNER JOIN city
        ON address.city_id = city.city_id
    INNER JOIN country
        ON city.country_id = country.country_id
    WHERE country.country IN ('India', 'China', 'United States')
    GROUP BY category.name, country.country
    
)

SELECT *
FROM country_category_count_list
WHERE rn <= 3
ORDER BY country, rn;

-- 03. 
-- Description
-- Top 10 countries, ranked by number of rental counts

-- Solution
WITH country_category_count_list AS (

    SELECT
        country.country,
        COUNT(*) AS rental_count,
        RANK() OVER (ORDER BY COUNT(*) DESC) AS rn
    FROM rental
    INNER JOIN inventory
        ON rental.inventory_id = inventory.inventory_id
    INNER JOIN film
        ON inventory.film_id = film.film_id
    INNER JOIN film_category
        ON film.film_id = film_category.film_id
    INNER JOIN category
        ON film_category.category_id = category.category_id
    INNER JOIN customer
        ON rental.customer_id = customer.customer_id
    INNER JOIN address
        ON customer.address_id = address.address_id
    INNER JOIN city
        ON address.city_id = city.city_id
    INNER JOIN country
        ON city.country_id = country.country_id
    GROUP BY country.country

)

SELECT *
FROM country_category_count_list
WHERE rn <= 10
ORDER BY rental_count DESC;

-- 04. 
-- Description
-- Daily/Hourly usage patterns

-- Solution
WITH rental_log_with_dow AS (

    SELECT
        DATE_PART('isodow', rental_date) AS dow,
        rental_date,
        SUBSTRING(CAST(rental_date AS VARCHAR), 12, 2) || ':00:00' AS index_time
    FROM rental
    INNER JOIN inventory
        ON rental.inventory_id = inventory.inventory_id
    INNER JOIN film
        ON inventory.film_id = film.film_id
    INNER JOIN film_category
        ON film.film_id = film_category.film_id
    INNER JOIN category
        ON film_category.category_id = category.category_id
    INNER JOIN customer
        ON rental.customer_id = customer.customer_id
    INNER JOIN address
        ON customer.address_id = address.address_id
    INNER JOIN city
        ON address.city_id = city.city_id
    INNER JOIN country
        ON city.country_id = country.country_id
    WHERE country.country = 'India'


)

SELECT
    index_time,
    COUNT(CASE dow WHEN 7 THEN 1 END) AS SUN,
    COUNT(CASE dow WHEN 1 THEN 1 END) AS MON,
    COUNT(CASE dow WHEN 2 THEN 1 END) AS TUE,
    COUNT(CASE dow WHEN 3 THEN 1 END) AS WED,
    COUNT(CASE dow WHEN 4 THEN 1 END) AS THU,
    COUNT(CASE dow WHEN 5 THEN 1 END) AS FRI,
    COUNT(CASE dow WHEN 6 THEN 1 END) AS SAT
FROM rental_log_with_dow
GROUP BY index_time;