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
-- import data from csv file
SELECT @ @secure_file_priv;
--C:\ProgramData\MySQL\MySQL Server 9.4\Uploads\
LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 9.4\\Uploads\\us_retail_sales.csv" INTO TABLE retail_sales FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;
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
/* 
 Compare sales between year and kind_of_bussiness of 'Book store',
 'Sporting goods stores', 'Hobby, toy, and game stores'
 (Result in file c3_plot_1.csv) 
 */
SELECT YEAR(sales_month),
    kind_of_business,
    SUM(sales)
FROM retail_sales
WHERE kind_of_business IN (
        'Book stores',
        'Sporting goods stores',
        'Hobby, toy, and game stores'
    )
GROUP BY 1,
    2;
/*
 Compare sales between men and women clothing stores
 (Result in file c3_plot_2.csv)
 */
SELECT YEAR(sales_month),
    kind_of_business,
    SUM(sales)
FROM retail_sales
WHERE kind_of_business IN (
        "Men's clothing stores",
        "Women's clothing stores"
    )
GROUP BY 1,
    2;
-- pivot and compare sales between Men and Women group
-- (Result IN FILE c3_plot_3.csv)
WITH pivot_table AS (
    SELECT YEAR(sales_month) AS `Year`,
        SUM(
            CASE
                WHEN kind_of_business = "Men's clothing stores" THEN sales
            END
        ) AS `Men's sales`,
        SUM(
            CASE
                WHEN kind_of_business = "Women's clothing stores" THEN sales
            END
        ) AS `Women's sales`
    FROM retail_sales
    WHERE sales_month <= '2019-12-01'
    GROUP BY 1
)
SELECT Year,
    `Men's sales`,
    `Women's sales`,
    (`Women's sales` - `Men's sales`) AS `Women/Men Diff`,
    (`Women's sales` / `Men's sales`) AS `Women/Men Times`,
    (`Women's sales` / `Men's sales` - 1) * 100 AS `Women/Men %`
FROM pivot_table;
/* 
 Calculate percentage of sales of Men and Women clothing stores
 over total monthly sales, using window function
 */
SELECT sales_month,
    kind_of_business,
    sales,
    sales * 100 / SUM(sales) OVER (PARTITION BY sales_month)
FROM retail_sales
WHERE kind_of_business IN (
        'Men''s clothing stores',
        'Women''s clothing stores'
    );
/* 
 Calculate percentage of sales of Men and Women clothing stores
 over total yearly sales, using window function
 (Result IN FILE c3_plot_4.csv)
 */
SELECT sales_month,
    kind_of_business,
    sales,
    (
        sales * 100 / SUM(sales) OVER (
            PARTITION BY YEAR(sales_month),
            kind_of_business
        )
    ) AS Pct_Yearly
FROM retail_sales
WHERE kind_of_business IN (
        'Men''s clothing stores',
        'Women''s clothing stores'
    )
ORDER BY 2,
    1;