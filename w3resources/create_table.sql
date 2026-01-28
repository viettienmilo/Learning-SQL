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