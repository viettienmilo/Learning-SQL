USE sakila;
-- 8.1 Construct a query that counts the number of rows in the payment table.
SELECT COUNT(*)
FROM payment;
-- 8.2 Modify your query from Exercise 8-1 to count the number of payments 
-- made by each customer. Show the customer ID and the total amount paid for 
-- each customer.
SELECT customer_id,
    COUNT(payment_id),
    SUM(amount)
FROM payment
GROUP BY customer_id;
-- 8.3 Modify your query from Exercise 8 -2 to include only those customers 
-- who have made at least 40 payments.
SELECT customer_id AS CUSTOMER_ID,
    COUNT(payment_id) AS NUM_OF_PAYMENTS,
    SUM(amount) AS TOTAL_PAYMENT
FROM payment
GROUP BY customer_id
HAVING NUM_OF_PAYMENTS >= 40;