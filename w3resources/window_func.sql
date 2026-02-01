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
-- 11. Find the Median Salary in Each Department
-- Write a MySQL query to find the median salary in each department 
-- using a window function.
USE excercise_db;
WITH median_salary as (
    SELECT DEPARTMENT_ID,
        SALARY,
        ROW_NUMBER() OVER (
            PARTITION BY DEPARTMENT_ID
            ORDER BY SALARY
        ) AS ROW_NUM,
        COUNT(*) OVER (PARTITION BY DEPARTMENT_ID) AS DEPT_COUNT
    FROM employees
)
SELECT DEPARTMENT_ID,
    ROUND(AVG(SALARY), 2) AS DEPT_MEDIAN
FROM median_salary
WHERE ROW_NUM IN (
        FLOOR((DEPT_COUNT + 1) / 2),
        CEIL((DEPT_COUNT + 1) / 2)
    )
GROUP BY DEPARTMENT_ID;
-- 12. Calculate the Salary Difference from Company Average
-- Write a MySQL query to calculate the difference between each 
-- employee's salary and the average salary of the entire company 
-- using a window function.
SELECT EMPLOYEE_ID,
    LAST_NAME,
    SALARY,
    SALARY - ROUND(AVG(SALARY) OVER(), 2) AS DIFF_FROM_COMPANY_AVG
FROM employees
ORDER BY EMPLOYEE_ID;
-- 13. Using Certificates for Database Authentication
-- Write a MySQL query to find the cumulative distribution of 
-- sales using a window function.
USE northwind;
SELECT OrderID,
    SALES,
    CUME_DIST() OVER(
        ORDER BY SALES
    ) AS CUME_DIST_SALES
FROM (
        SELECT OrderId,
            SUM(UnitPrice * Quantity) AS SALES
        FROM `order details`
        GROUP BY OrderID
    ) AS SALE_TABLE;
-- 14. Calculate the Percentile Rank of Each Employee's Salary
-- Write a MySQL query to calculate the percentile rank of each 
-- employee's salary using a window function.
USE excercise_db;
SELECT EMPLOYEE_ID,
    LAST_NAME,
    SALARY,
    PERCENT_RANK() OVER (
        ORDER BY SALARY
    ) AS PERCENT_RANK_SALARY
FROM employees
ORDER BY SALARY;
-- 15. Find the Lead and Lag Values for Sales
-- Write a MySQL query to find the lead and lag values for sales 
-- using a window function.
USE northwind;
SELECT OrderID,
    SALES,
    LAG(SALES, 1) OVER (
        ORDER BY SALES
    ) AS PREV_SALES,
    LEAD(SALES, 1) OVER (
        ORDER BY SALES
    ) AS NEXT_SALES
FROM (
        SELECT OrderID,
            SUM(UnitPrice * Quantity) AS SALES
        FROM `order details`
        GROUP BY OrderID
    ) AS SALE_TABLE;
-- 16. Calculate the Difference between Current and Next Salary
-- Write a MySQL query to calculate the difference between the 
-- current salary and the next salary for each employee using a 
-- window function.
USE excercise_db;
SELECT EMPLOYEE_ID,
    LAST_NAME,
    SALARY,
    SALARY - LEAD(SALARY, 1) OVER (
        ORDER BY EMPLOYEE_ID
    ) AS SAL_NEXT_DIFF
FROM employees
ORDER BY EMPLOYEE_ID;
-- 17. Calculate the Cumulative Sum of Sales by Quarter
-- Write a MySQL query to calculate the cumulative sum of sales for 
-- each quarter using a window function.
USE northwind;
SELECT SALE_QTR,
    QTR_SALES,
    SUM(QTR_SALES) OVER (
        ORDER BY QTR_SALES rows unbounded preceding
    ) AS CUM_SUM_QTR_SALES
FROM (
        SELECT QUARTER(OrderDate) as SALE_QTR,
            SUM(UnitPrice * Quantity) AS QTR_SALES
        FROM `order details`
            INNER JOIN orders USING(OrderID)
        GROUP BY QUARTER(OrderDate)
    ) AS SALE_TABLE
GROUP BY SALE_QTR;
-- 18. Find the Top 5 Highest Sales by Region
-- Write a MySQL query to find the top 5 highest sales in each region 
-- using a window function.
WITH sale_table AS (
    SELECT Country,
        UnitPrice * Quantity,
        DENSE_RANK() OVER (
            PARTITION BY Country
            ORDER BY UnitPrice * Quantity DESC
        ) AS RNK
    FROM invoices
)
SELECT *
FROM sale_table
WHERE RNK <= 5
ORDER BY Country;
-- 19. Calculate the Average Sales Over a Rolling 3-Month Window
-- Write a MySQL query to calculate the average sales over a rolling 
-- 3-month window using a window function.
SELECT SALE_YEAR,
    SALE_MONTH,
    MONTH_SALES,
    AVG(MONTH_SALES) OVER (
        ORDER BY SALE_MONTH rows between 1 preceding and 1 following
    ) AS ROLL_AVG
FROM (
        SELECT YEAR(OrderDate) AS SALE_YEAR,
            MONTHNAME(OrderDate) AS SALE_MONTH,
            SUM(UnitPrice * Quantity) AS MONTH_SALES
        FROM invoices
        GROUP BY YEAR(OrderDate),
            MONTHNAME(OrderDate)
    ) AS S
ORDER BY SALE_YEAR;
-- 20. Find the Employees with the Highest Salary in Each Department
-- Write a MySQL query to find the employees with the highest salary 
-- in each department using a window function.
USE excercise_db;
WITH SALARY_TABLE AS (
    SELECT EMPLOYEE_ID,
        LAST_NAME,
        DEPARTMENT_ID,
        SALARY,
        RANK() OVER (
            PARTITION BY DEPARTMENT_ID -- ORDER BY SALARY DESC
            ORDER BY SALARY DESC
        ) AS RNK
    FROM employees
)
SELECT *
FROM SALARY_TABLE
WHERE RNK = 1;