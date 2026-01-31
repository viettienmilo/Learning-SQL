USE excercise_db;
-- 1. Rank Employees by Salary
-- Write a MySQL query to rank employees based on their salary in 
-- descending order using a window function.
SELECT EMPLOYEE_ID,
    LAST_NAME,
    SALARY,
    RANK() OVER(
        ORDER BY SALARY DESC
    ) AS SALARY_RNK
FROM employees
ORDER BY SALARY_RNK;
-- 2. Calculate Running Total of Sales
-- Write a MySQL query to calculate the running total of sales for 
-- each month using a window function.
USE sakila;
SELECT MONTH(payment_date) AS MONTH,
    SUM(amount) AS MONTH_TOTAL,
    SUM(SUM(amount)) OVER (
        ORDER BY MONTH(payment_date) rows unbounded preceding
    ) AS RUNNING_TOTAL_SALARY
FROM payment
GROUP BY MONTH(payment_date);
-- 3. Partition Employees by Department and Rank by Salary
-- Write a MySQL query to partition employees by department and rank 
-- them by salary within each department.
USE excercise_db;
SELECT EMPLOYEE_ID,
    LAST_NAME,
    DEPARTMENT_ID,
    SALARY,
    RANK() OVER (
        PARTITION BY DEPARTMENT_ID
        ORDER BY SALARY DESC
    ) AS RNK
FROM employees
ORDER BY DEPARTMENT_ID;
-- 4. Calculate Moving Average of Sales
-- Write a MySQL query to calculate the 3-month moving average of 
-- sales using a window function.
USE sakila;
SELECT MONTH(payment_date),
    SUM(amount) AS MONTH_TOTAL,
    AVG(SUM(amount)) OVER (
        ORDER BY MONTH(payment_date) rows between 1 preceding AND 1 following
    ) AS MOVING_AVG
FROM payment
GROUP BY MONTH(payment_date)
ORDER BY MONTH(payment_date);
-- 5. Find the difference between Current and Previous Salary
-- Write a MySQL query to find the difference between the current 
-- salary and the previous salary for each employee using a window 
-- function.
USE excercise_db;
SELECT EMPLOYEE_ID,
    LAST_NAME,
    SALARY,
    SALARY - LAG(SALARY, 1) OVER (
        ORDER BY EMPLOYEE_ID
    ) AS SAL_DIFF
FROM employees
ORDER BY EMPLOYEE_ID;
-- 6. Calculate Cumulative Percentage of Total Sales
-- Write a MySQL query to calculate the cumulative percentage of 
-- total sales for each month using a window function.
USE sakila;
SELECT MTH,
    MTH_TOTAL,
    SUM(MTH_TOTAL) OVER (
        ORDER BY MTH rows unbounded preceding
    ) / SUM(MTH_TOTAL) OVER() * 100 AS ACCU_PCT
FROM (
        SELECT MONTH(payment_date) AS MTH,
            SUM(amount) AS MTH_TOTAL
        FROM payment
        GROUP BY MONTH(payment_date)
    ) AS M
ORDER BY MTH;
-- 7. Find the Top 3 Highest Paid Employees in Each Department
-- Write a MySQL query to find the top 3 highest paid employees 
-- in each department using a window function.
USE excercise_db;
WITH TOP_3_SALARY AS (
    SELECT EMPLOYEE_ID,
        LAST_NAME,
        DEPARTMENT_ID,
        SALARY,
        DENSE_RANK() OVER (
            PARTITION BY DEPARTMENT_ID
            ORDER BY SALARY DESC
        ) AS RNK
    FROM employees
)
SELECT *
FROM TOP_3_SALARY
WHERE RNK <= 3;
-- 8. Calculate the Salary Difference from Department Average
-- Write a MySQL query to calculate the difference between each 
-- employee's salary and the average salary of their department 
-- using a window function.
SELECT EMPLOYEE_ID,
    LAST_NAME,
    SALARY,
    SALARY - ROUND(AVG(SALARY) OVER (PARTITION BY DEPARTMENT_ID), 2) AS DIFF_FROM_DEPT_AVG
FROM employees
ORDER BY DEPARTMENT_ID;
-- 9. Find the First and Last Sale Date for Each Customer
-- Write a MySQL query to find the first and last sale date for 
-- each customer using a window function.
USE sakila;
SELECT customer_id,
    MIN(payment_date) AS FIRST_SALE,
    MAX(payment_date) AS LAST_SALE
FROM payment
GROUP BY customer_id;
-- 10. Calculate the Percentage of Total Sales for each Product
-- Write a MySQL query to calculate the percentage of total sales 
-- for each product using a window function.
USE northwind;
SELECT ProductID,
    ProductName,
    SUM(o.UnitPrice * Quantity) AS PRODUCT_SALES,
    SUM(o.UnitPrice * Quantity) / SUM(SUM(o.UnitPrice * Quantity)) OVER() * 100 AS PCT_OF_TOTAL_SALES,
    RANK() OVER(
        ORDER BY SUM(o.UnitPrice * Quantity) DESC
    ) AS SALES_RNK
FROM `order details` o
    INNER JOIN products p USING(ProductID)
GROUP BY ProductID
ORDER BY PCT_OF_TOTAL_SALES DESC;