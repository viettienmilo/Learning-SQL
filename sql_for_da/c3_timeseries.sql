CREATE DATABASE IF NOT EXISTS sql_da;
USE sql_da;
--- create table
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales (
    sales_month date,
    naics_code varchar(256),
    kind_of_business varchar(256),
    reason_for_null varchar(256),
    sales decimal(10, 2)
);
-- preview data
SELECT *
FROM retail_sales
LIMIT 10;
-- total rows
SELECT COUNT(*)
FROM retail_sales;
-- earliest/latest date
SELECT MIN(sales_month) AS EARLIEST_DATE,
    MAX(sales_month) AS LATEST_DATE
FROM retail_sales;
/*#############################################
 TRENDING ANALYSIS
 ##############################################*/
-- The trend of total retail and food services sales in the US
SELECT sales_month,
    sales
FROM retail_sales
WHERE kind_of_business = 'Retail and food services sales, total';
-- Group by year
SELECT YEAR(sales_month),
    SUM(sales)
FROM retail_sales
GROUP BY 1;