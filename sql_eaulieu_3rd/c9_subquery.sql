USE sakila;
-- 9.1 Construct a query against the film table that uses a filter condition with 
-- a noncorrelated subquery against the category table to find all action films 
-- (category.name = 'Action').
SELECT *
FROM film
WHERE film_id IN (
        SELECT film_id
        FROM film_category fc
            INNER JOIN category c ON fc.category_id = c.category_id
        WHERE c.name = 'Action'
    );
-- 9.2 Rework the query from Exercise 9 -1 using a correlated subquery against the 
-- category and film_category tables to achieve the same results.
SELECT *
FROM film f
WHERE EXISTS (
        SELECT 1
        FROM film_category fc
            INNER JOIN category c ON fc.category_id = c.category_id
        WHERE c.name = 'Action'
            AND f.film_id = fc.film_id
    );
/* Join the following query to a subquery against the film_actor table to show the 
 level of each actor:
 SELECT 'Hollywood Star' level, 30 min_roles, 99999 max_roles
 UNION ALL
 SELECT 'Prolific Actor' level, 20 min_roles, 29 max_roles
 UNION ALL
 SELECT 'Newcomer' level, 1 min_roles, 19 max_roles 
 The subquery against the film_actor table should count the number of rows for each 
 actor using  group by actor_id, and the count should be compared to the 
 min_roles / max_roles columns to determine which level each actor belongs to. 
 */
SELECT actor_roles.actor_id,
    role_lvl.lvl
FROM (
        -- get num of roles of each actor id
        SELECT actor_id,
            COUNT(actor_id) AS role_num
        FROM film_actor
        GROUP BY actor_id
    ) AS actor_roles
    INNER JOIN (
        -- role level table
        SELECT 'Hollywood Star' lvl,
            30 min_roles,
            99999 max_roles
        UNION ALL
        SELECT 'Prolific Actor' lvl,
            20 min_roles,
            29 max_roles
        UNION ALL
        SELECT 'Newcomer' lvl,
            1 min_roles,
            19 max_roles
    ) AS role_lvl -- 
    -- compare role_num with min_roles/max_roles
    ON actor_roles.role_num BETWEEN role_lvl.min_roles AND role_lvl.max_roles;