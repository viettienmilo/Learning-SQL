USE superstore;
-- 1. Write an sql query to get all the orders where customers name has "a" 
-- as second character and "d" as fourth character
SELECT *
FROM orders
WHERE customer_name LIKE '_a_d%';
-- 2. write a sql to get all the orders placed in the month of dec 2020
SELECT *
FROM orders
WHERE order_date BETWEEN '2020-12-01' AND '2020-12-31';
-- 3. write a query to get all the orders where ship_mode is neither in 
-- 'Standard Class' nor in 'First Class' and ship_date is after nov 2020
SELECT *
FROM orders
WHERE ship_mode NOT IN ('Standard Class', 'First Class')
    AND ship_date > '2020/11/30';
-- 4. write a query to get all the orders where customer name neither start 
-- with "A" and nor ends with "n"
SELECT *
FROM orders
WHERE customer_name NOT LIKE 'A%n';
-- 5. write a query to get all the orders where profit is negative
SELECT *
FROM orders
WHERE profit < 0;
-- 6. write a query to get all the orders where either quantity is less 
-- than 3 or profit is 0
SELECT *
FROM orders
WHERE quantity < 3
    OR profit = 0;
-- 7. Your manager handles the sales for South region and he wants you to 
-- create a report of all the orders in his region where some discount is 
-- provided to the customers
SELECT *
FROM orders
WHERE region = 'South'
    AND discount > 0;
-- 8. Write a query to find top 5 orders with highest sales in furniture 
-- category
SELECT *
FROM orders
WHERE category = 'Furniture'
ORDER BY sales DESC
LIMIT 5;
-- 9. Write a query to find all the records in technology and furniture 
-- category for the orders placed in the year 2020 only
SELECT *
FROM orders
WHERE category IN ('Technology', 'Furniture')
    AND YEAR(order_date) = 2020;
-- 10. Write a query to find all the orders where order date is in year 
-- 2020 but ship date is in 2021
SELECT *
FROM orders
WHERE YEAR(order_date) = 2020
    AND YEAR(ship_date) = 2021;
-- 11. Write a update statement to update city as null for order ids : 
-- CA-2020-161389 , US-2021-156909
UPDATE orders
SET city = NULL
WHERE order_id IN ('CA-2020-161389', 'US-2021-156909');
SELECT *
FROM orders
WHERE order_id IN ('CA-2020-161389', 'US-2021-156909');
-- 12. Write a query to find orders where city is null (2 rows)
SELECT *
FROM orders
WHERE city IS NULL;
-- 13. Write a query to get total profit, first order date and latest 
-- order date for each category
SELECT DISTINCT category,
    SUM(profit) AS `TOTAL PROFIT`,
    MIN(order_date) AS `FIRST ORDER DATE`,
    MAX(order_date) AS `LATEST ORDER DATE`
FROM orders
GROUP BY category
ORDER BY category;
-- 14. Write a query to find sub-categories where average profit is more 
-- than the half of the max profit in that sub-category
SELECT sub_category,
    AVG(profit),
    MAX(profit)
FROM orders
GROUP BY sub_category
HAVING AVG(profit) > 0.5 * MAX(profit);
-- 15. Create the exams table with below script; and write a query to find 
-- students who have got same marks in Physics and Chemistry
CREATE TABLE IF NOT EXISTS exams (
    student_id INT,
    subject VARCHAR(20),
    marks INT
) Engine = InnoDB;
INSERT INTO exams
VALUES (1, 'Chemistry', 91),
    (1, 'Physics', 91),
    (1, 'Maths', 92),
    (2, 'Chemistry', 80),
    (2, 'Physics', 90),
    (3, 'Chemistry', 80),
    (3, 'Maths', 80),
    (4, 'Chemistry', 71),
    (4, 'Physics', 54),
    (5, 'Chemistry', 79);
SELECT *
FROM exams
WHERE subject = 'Physics'
    AND marks = (
        SELECT marks
        FROM exams e
        WHERE e.student_id = exams.student_id
            AND subject = 'Chemistry'
    );
-- using self join
SELECT e1.*,
    e1.marks as PHYSICS,
    e2.marks as CHEMISTRY
FROM exams e1
    INNER JOIN exams e2 ON e1.student_id = e2.student_id
WHERE e1.subject = 'Physics'
    AND e2.subject = 'Chemistry'
    AND e1.marks = e2.marks;
-- 16. Write a query to find out all the students marks in chemistry 
-- subject
SELECT *
FROM exams
WHERE subject = 'Chemistry';
-- 17. write a query to find total number of products in each category.
SELECT DISTINCT category,
    COUNT(product_id) AS NUM_OF_PRODUCTS
FROM orders
GROUP BY category;
-- 18. write a query to find top 5 sub categories in west region by 
-- total quantity sold.
SELECT sub_category,
    SUM(quantity) AS SUM_QUANTITY,
    region
FROM orders
WHERE region = 'West'
GROUP BY sub_category
ORDER BY SUM(quantity) DESC
LIMIT 5;
-- 19. Write a query to find total sales for each region and ship mode 
-- combination for orders in year 2020
SELECT region,
    ship_mode,
    SUM(sales) AS TOTAL_SALES
FROM orders
WHERE YEAR(order_date) = 2020
GROUP BY region,
    ship_mode
ORDER BY region,
    ship_mode;
-- 20. Write a query to find total sales for each region
SELECT region,
    SUM(sales) AS TOTAL_SALES
FROM orders
GROUP BY region
ORDER BY region;