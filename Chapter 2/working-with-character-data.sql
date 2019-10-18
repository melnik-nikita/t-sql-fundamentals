USE TSQLV4;


-- Collation

-- Get list of supported collations
SELECT name, description
FROM sys.fn_helpcollations();

-- Select without and with collation
-- SELECT empid, firstname, lastname
-- FROM HR.Employees
-- WHERE lastname = N'davis';

-- SELECT empid, firstname, lastname
-- FROM HR.Employees
-- WHERE lastname COLLATE Latin1_General_CS_AS = N'davis';

-- String operators and functions

-- String concatenation(+, CONCAT)
-- SELECT TOP 10
--     custid, country, region, city,
--     (country + N',' + region + N',' + city) as locaiton
-- FROM Sales.Customers;

-- SELECT TOP 10
--     custid, country, region, city,
--     CONCAT(country, N',' + region, N',' + city) as locaiton
-- FROM Sales.Customers;

-- SELECT SUBSTRING('abcde', 1, 3);