USE sakila;
/* 14.2
 Create a view definition that can be used by the following query to generate the given results:
 SELECT title,
 category_name,
 first_name,
 last_name
 FROM film_ctgry_actor
 WHERE last_name = 'FAWCETT';
 */
CREATE VIEW IF NOT EXISTS film_ctgry_actor AS (
    SELECT f.title,
        c.name as category_name,
        a.first_name,
        a.last_name
    FROM film f
        INNER JOIN film_category fc ON f.film_id = fc.film_id
        INNER JOIN category c ON fc.category_id = c.category_id
        INNER JOIN film_actor fa ON f.film_id = fa.film_id
        INNER JOIN actor a ON fa.actor_id = a.actor_id
);
---
SELECT title,
    category_name,
    first_name,
    last_name
FROM film_ctgry_actor
WHERE last_name = 'FAWCETT';
/* 14.2
 The film rental company manager would like to have a report that includes the name of every 
 country, along with the total payments for all customers who live in each country. Generate 
 a view definition that queries the country table and uses a scalar subquery to calculate a 
 value for a column named tot_payments.
 */
-- version 1: Australia is excluded (because of NULL) - 108 rows
SELECT co.country,
    SUM(p.amount) AS tot_payments
FROM country co
    INNER JOIN city ci ON co.country_id = ci.country_id
    INNER JOIN address ad ON ci.city_id = ad.city_id
    INNER JOIN customer c ON ad.address_id = c.address_id
    INNER JOIN payment p ON c.customer_id = p.customer_id
GROUP BY co.country;
-- version 2: Australia is included (NULL value) - 109 rows
CREATE VIEW IF NOT EXISTS country_tot_payments AS (
    SELECT co.country,
        (
            SELECT sum(p.amount)
            FROM city ci
                INNER JOIN address ad ON ci.city_id = ad.city_id
                INNER JOIN customer c ON ad.address_id = c.address_id
                INNER JOIN payment p ON c.customer_id = p.customer_id
            WHERE ci.country_id = co.country_id
        ) tot_payments
    FROM country co
);