-- create superstore database
CREATE DATABASE IF NOT EXISTS superstore;
USE superstore;
-- create orders table
CREATE TABLE IF NOT EXISTS orders (
    row_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id VARCHAR(256) NOT NULL,
    order_date DATE NOT NULL,
    ship_date DATE NOT NULL,
    ship_mode VARCHAR(256) NOT NULL,
    customer_id VARCHAR(256) NOT NULL,
    customer_name VARCHAR(256) NOT NULL,
    segment VARCHAR(256) NOT NULL,
    country VARCHAR(256) NOT NULL,
    city VARCHAR(256),
    state VARCHAR(256) NOT NULL,
    postal_code VARCHAR(256),
    region VARCHAR(256) NOT NULL,
    product_id VARCHAR(256) NOT NULL,
    category VARCHAR(256) NOT NULL,
    sub_category VARCHAR(256) NOT NULL,
    product_name VARCHAR(256) NOT NULL,
    sales DECIMAL(10, 2) NOT NULL,
    quantity INT NOT NULL,
    discount DECIMAL(4, 2) NOT NULL,
    profit DECIMAL(10, 2) NOT NULL
) Engine = InnoDB;
-- load csv file
-- open secured folder
SHOW VARIABLES LIKE 'secure_file_priv';
-- C:\ProgramData\MySQL\MySQL Server 9.4\Uploads\
-- copy csv file to that folder then run:
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 9.4/Uploads/orders.csv" INTO TABLE orders CHARACTER SET latin1 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;
-- test imported data
SELECT *
FROM orders;