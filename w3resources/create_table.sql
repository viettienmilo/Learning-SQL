-- create sample database
CREATE DATABASE IF NOT EXISTS `excercise_db`;
USE excercise_db;
-- 1. Write a MySQL query to create a simple table 
-- countries including columns country_id, country_name and region_id.
CREATE TABLE countries (
    country_id INT,
    country_name VARCHAR(50),
    region_id INT
);
-- 2. Write a MySQL query to create a simple table 
-- countries including columns country_id, country_name and region_id 
-- which is already exists.
CREATE TABLE IF NOT EXISTS countries (
    country_id INT,
    country_name VARCHAR(50),
    region_id INT
);
-- 3. Write a MySQL query to create the structure of a table 
-- dup_countries similar to countries.
CREATE TABLE dup_countries LIKE countries;
-- 4. Write a MySQL query to create a duplicate copy of countries table 
-- including structure and data by name dup_countries.
CREATE TABLE IF NOT EXISTS dup_countries AS
SELECT *
FROM countries;
-- 5. Write a MySQL query to create a table countries set a constraint NULL.
CREATE TABLE IF NOT EXISTS countries (
    country_id INT NOT NULL,
    country_name VARCHAR(50) NOT NULL,
    region_id INT
);
-- 6. Write a MySQL query to create a table named jobs including columns 
-- job_id, job_title, min_salary, max_salary and check whether 
-- the max_salary amount exceeding the upper limit 25000.
CREATE TABLE IF NOT EXISTS jobs (
    job_id INT,
    job_title VARCHAR(50),
    min_salary INT,
    max_salary INT,
    CONSTRAINT max_salary CHECK (max_salary <= 25000)
);
-- 7. Write a MySQL query to create a table named countries including columns 
-- country_id, country_name and region_id and make sure that no countries 
-- except Italy, India and China will be entered in the table.
CREATE TABLE IF NOT EXISTS countries (
    country_id INT,
    country_name ENUM('Italy', 'India', 'China'),
    region_id INT
);
-- 8. Write a MySQL query to create a table named job_histry including
--  columns employee_id, start_date, end_date, job_id and department_id
--  and make sure that the value against column end_date will be entered
--  at the time of insertion to the format like '--/--/----'.
CREATE TABLE IF NOT EXISTS job_histry (
    employee_id INT NOT NULL,
    start_data DATE NOT NULL,
    end_date DATE NOT NULL CHECK (end_date LIKE '--/--/----'),
    job_id INT NOT NULL,
    department_id INT NOT NULL
);
-- 9. Write a MySQL query to create a table named countries including 
-- columns country_id,country_name and region_id and make sure that no
--  duplicate data against column country_id will be allowed at the time
--  of insertion.
CREATE TABLE IF NOT EXISTS countries (
    country_id INT UNIQUE,
    country_name VARCHAR(50),
    region_id INT
);
-- 10. Write a MySQL query to create a table named jobs including columns 
-- job_id, job_title, min_salary and max_salary, and make sure that, the 
-- default value for job_title is blank and min_salary is 8000 and 
-- max_salary is NULL will be entered automatically at the time of insertion
-- if no value assigned for the specified columns.
CREATE TABLE jobs (
    job_id INT,
    job_title VARCHAR(50) DEFAULT "",
    min_salary INT DEFAULT 8000,
    max_salary INT DEFAULT NULL
);
-- 11. Write a MySQL query to create a table named countries including 
-- columns country_id, country_name and region_id and make sure that the 
-- country_id column will be a key field which will not contain any duplicate 
-- data at the time of insertion.
CREATE TABLE IF NOT EXISTS countries (
    country_id INT PRIMARY KEY,
    country_name VARCHAR(50),
    region_id INT
);
-- 12. Write a MySQL query to create a table countries including columns 
-- country_id, country_name and region_id and make sure that the column 
-- country_id will be unique and store an auto incremented value.
DROP TABLE IF EXISTS countries;
CREATE TABLE IF NOT EXISTS countries (
    country_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    country_name VARCHAR(50),
    region_id INT
);
-- 13. Write a MySQL query to create a table countries including columns 
-- country_id, country_name and region_id and make sure that the combination 
-- of columns country_id and region_id will be unique.
DROP TABLE IF EXISTS countries;
CREATE TABLE IF NOT EXISTS countries (
    country_id INT NOT NULL,
    country_name VARCHAR(50) NOT NULL,
    region_id INT NOT NULL,
    PRIMARY KEY (country_id, region_id)
);
/*
 14. Write a MySQL query to create a table job_history including columns 
 employee_id, start_date, end_date, job_id and department_id and make sure that,
 the employee_id column does not contain any duplicate value at the time of 
 insertion and the foreign key column job_id contain only those values which 
 are exists in the jobs table.
 
 Here is the structure of the table jobs;
 
 +------------+--------------+------+-----+---------+-------+
 | Field      | Type         | Null | Key | Default | Extra |
 +------------+--------------+------+-----+---------+-------+
 | JOB_ID     | int(6)       | NO   | PRI |         |       |
 | JOB_TITLE  | varchar(35)  | NO   |     | NULL    |       |
 | MIN_SALARY | decimal(6,0) | YES  |     | NULL    |       |
 | MAX_SALARY | decimal(6,0) | YES  |     | NULL    |       |
 +------------+--------------+------+-----+---------+-------+
 */
DROP TABLE IF EXISTS jobs;
CREATE TABLE IF NOT EXISTS jobs (job_id INT);
DROP TABLE IF EXISTS job_history;
CREATE TABLE IF NOT EXISTS job_history (
    employee_id INT NOT NULL PRIMARY KEY,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    job_id INT NOT NULL,
    department_id INT NOT NULL,
    FOREIGN KEY (job_id) REFERENCES jobs(job_id)
);