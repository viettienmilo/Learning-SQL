/*
 Here is the structure of the table "countries".
 
 +--------------+---------------+------+-----+---------+-------+
 | Field        | Type          | Null | Key | Default | Extra |
 +--------------+---------------+------+-----+---------+-------+
 | COUNTRY_ID   | varchar(2)    | YES  |     | NULL    |       |
 | COUNTRY_NAME | varchar(40)   | YES  |     | NULL    |       |
 | REGION_ID    | decimal(10,0) | YES  |     | NULL    |       |
 +--------------+---------------+------+-----+---------+-------+	
 */
use excercise_db;
DROP TABLE IF EXISTS countries;
CREATE TABLE IF NOT EXISTS countries (
    country_id VARCHAR(2),
    country_name VARCHAR(40),
    region_id DECIMAL(10, 0)
) ENGINE = InnoDB;
-- 1. Write a MySQL query to insert a record with your own value into the table 
-- countries against each columns.
INSERT INTO countries
VALUES ('US', 'United States of America', 2),
    ('VN', 'Viet Nam', 4);
-- 2. Write a MySQL query to insert one row into the table countries against the 
-- column country_id and country_name.
INSERT INTO countries (country_id, country_name)
VALUES ('CN', 'China');
-- 3. Write a MySQL query to create duplicate of countries table named country_new 
-- with all structure and data.
DROP TABLE IF EXISTS country_new;
CREATE TABLE country_new AS
SELECT *
FROM countries;
-- 4. Write a MySQL query to insert NULL values against region_id column for a row 
-- of countries table.
INSERT INTO countries
VALUES ('IN', 'India', NULL);
-- 5. Write a MySQL query to insert 3 rows by a single insert statement.
INSERT INTO countries
VALUES ('JP', 'Japan', 3),
    ('FR', 'France', 4),
    ('DE', 'Germany', 4);
-- 6. Write a MySQL query insert rows from country_new table to countries table.
-- ==> Same to 3.
-- 7. Write a MySQL query to insert one row in jobs table to ensure that no 
-- duplicate value will be entered in the job_id column.
INSERT INTO jobs
VALUES (1, 'Programmer', 5000, 10000);
-- 8. Write a MySQL query to insert one row in jobs table to ensure that no 
-- duplicate value will be entered in the job_id column.
INSERT INTO jobs
VALUES (2, 'Developer', 6000, 12000);
-- 9. Write a MySQL query to insert a record into the table countries to ensure that, 
-- a country_id and region_id combination will be entered once in the table.
INSERT INTO countries
VALUES ('RU', 'Russia', 5);
-- 10. Write a MySQL query to insert rows into the table countries in which the value 
-- of country_id column will be unique and auto incremented.
CREATE TABLE IF NOT EXISTS countries_2 (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(40),
    region_id DECIMAL(10, 0)
) ENGINE = InnoDB;
INSERT INTO countries_2 (country_name, region_id)
VALUES ('United States of America', 2),
    ('Viet Nam', 3),
    ('China', 3),
    ('Japan', 3),
    ('France', 4),
    ('Germany', 4),
    ('Russia', 5);
-- 11. Write a MySQL query to insert records into the table countries to ensure that 
-- the country_id column will not contain any duplicate data and this will be 
-- automatically incremented and the column country_name will be filled up by 'N/A' 
-- if no value assigned for that column.
ALTER TABLE countries_2
MODIFY country_name VARCHAR(40) DEFAULT 'N/A';
INSERT INTO countries_2 (region_id)
VALUES (2),
    (3),
    (4),
    (5);
-- 12. Write a MySQL query to insert rows in the job_history table in which one column
--  job_id is containing those values which are exists in job_id column of jobs table.
ALTER TABLE job_history
ADD FOREIGN KEY (job_id) REFERENCES jobs(job_id);
ALTER TABLE employees
MODIFY COLUMN employee_id INT AUTO_INCREMENT;
INSERT INTO employees (first_name, last_name, job_id, salary)
VALUES (
        'John',
        'Doe',
        1,
        5000
    );
ALTER TABLE job_history DROP COLUMN department_id;
INSERT INTO job_history (employee_id, start_date, end_date, job_id)
VALUES (1, '2020-01-01', '2020-12-31', 1);
-- 13. Write a MySQL query to insert rows into the table employees in which a set of 
-- columns department_id and manager_id contains a unique value and that combined 
-- values must have exists into the table departments.
INSERT INTO employees (first_name, last_name, department_id, manager_id)
VALUES (
        'Jane',
        'Smith',
        1,
        1
    );
-- 14. Write a MySQL query to insert rows into the table employees in which a set of 
-- columns department_id and job_id contains the values which must have exists into 
-- the table departments and jobs.
INSERT INTO employees (first_name, last_name, department_id, job_id)
VALUES (
        'Bob',
        'Johnson',
        1,
        1
    );