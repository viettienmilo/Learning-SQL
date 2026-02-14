USE sakila;
/*
 Using the following table definitions and data, write a query that returns 
 each customer name along with their total payments: 
 Customer: 
 Customer_id Name 
 ----------- ---------------
 1           John Smith 
 2           Kathy Jones 
 3           Greg Oliver 
 Payment: 
 Payment_id Customer_id Amount 
 ---------- ----------- --------
 101         1           8.99 
 102         3           4.99 
 103         1           7.99 
 Include all customers, even if no payment records exist for that customer.
 */
SELECT customer.name,
    SUM(payment.amount)
FROM customer
    LEFT OUTER JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id;
-- 10.2 Reformulate your query from Exercise 10 -1 to use the other
-- outer join type (e.g., if you used a left outer join in Exercise 10 -1,
-- use a right outer join this time) such that the results are identical 
-- to Exercise 10-1.
SELECT customer.name,
    SUM(payment.amount)
FROM payment
    RIGHT OUTER JOIN customer ON customer.customer_id = payment.customer_id;
GROUP BY customer.customer_id;
-- Devise a query that will generate the set {1, 2, 3, ..., 99, 100}. (Hint: 
-- use a cross join with at least two from clause subqueries.)
SELECT (1 + ones.num + tens.num * 10) AS numbers
FROM (
        SELECT 0 AS num
        UNION ALL
        SELECT 1 AS num
        UNION ALL
        SELECT 2 AS num
        UNION ALL
        SELECT 3 AS num
        UNION ALL
        SELECT 4 AS num
        UNION ALL
        SELECT 5 AS num
        UNION ALL
        SELECT 6 AS num
        UNION ALL
        SELECT 7 AS num
        UNION ALL
        SELECT 8 AS num
        UNION ALL
        SELECT 9 AS num
    ) AS ones
    CROSS JOIN (
        SELECT 0 AS num
        UNION ALL
        SELECT 1 AS num
        UNION ALL
        SELECT 2 AS num
        UNION ALL
        SELECT 3 AS num
        UNION ALL
        SELECT 4 AS num
        UNION ALL
        SELECT 5 AS num
        UNION ALL
        SELECT 6 AS num
        UNION ALL
        SELECT 7 AS num
        UNION ALL
        SELECT 8 AS num
        UNION ALL
        SELECT 9 AS num
    ) AS tens
ORDER BY numbers;