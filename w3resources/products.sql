USE northwind;
-- 1. Write a MySQL query to get Product name and quantity/unit.
SELECT ProductName,
    QuantityPerUnit
FROM Products;
-- 2. Write a MySQL query to get current Product list (Product ID 
-- and name).
SELECT ProductID,
    ProductName
FROM Products
WHERE Discontinued = 0
ORDER BY ProductName;
-- 3. Write a MySQL query to get discontinued Product list 
-- (Product ID and name)
SELECT ProductID,
    ProductName
FROM Products
WHERE Discontinued = 1
ORDER BY ProductName;
-- 4. Write a MySQL query to get most expense and least expensive 
-- Product list (name and unit price).
SELECT ProductName,
    UnitPrice
FROM Products
WHERE UnitPrice IN (
        (
            SELECT MAX(UnitPrice)
            FROM Products
        ),
        (
            SELECT MIN(UnitPrice)
            FROM Products
        )
    );
-- 5. Write a MySQL query to get Product list (id, name, unit price) 
-- where current products cost less than $20.
SELECT ProductID,
    ProductName,
    UnitPrice
FROM Products
WHERE Discontinued = 0
    AND UnitPrice < 20;
-- 6. Write a MySQL query to get Product list (id, name, unit price) 
-- where products cost between $15 and $25.
SELECT ProductID,
    ProductName,
    UnitPrice
FROM Products
WHERE (Discontinued = 0)
    AND (
        UnitPrice BETWEEN 15 AND 25
    );
-- 7. Write a MySQL query to get Product list (name, unit price) of 
-- above average price.
SELECT ProductName,
    UnitPrice
FROM Products
WHERE (Discontinued = 0)
    AND (
        UnitPrice > (
            SELECT AVG(UnitPrice)
            FROM Products
        )
    );
-- 8. Write a MySQL query to get Product list (name, unit price) of 
-- ten most expensive products.
SELECT ProductName,
    UnitPrice
FROM Products
WHERE (Discontinued = 0)
ORDER BY UnitPrice DESC
LIMIT 10;
-- 9. Write a MySQL query to count current and discontinued products.
SELECT 'Current Products' AS TYPE,
    COUNT(*) AS `VALUE`
FROM Products
WHERE Discontinued = 0
GROUP BY Discontinued
UNION
SELECT 'Discontinued Products' AS TYPE,
    COUNT(*) AS `VALUE`
FROM Products
WHERE Discontinued = 1
GROUP BY Discontinued;
-- 10. Write a MySQL query to get Product list (name, units on order, 
-- units in stock) of stock is less than the quantity on order.
SELECT ProductName,
    UnitsOnOrder,
    UnitsInStock
FROM Products
WHERE UnitsInStock < UnitsOnOrder;