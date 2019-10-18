USE TSQLV4;

-- SELECT
--     empid,
--     YEAR(orderdate) as orderyear,
--     COUNT(*) AS numorders
-- FROM Sales.Orders
-- WHERE custid = 71
-- GROUP BY empid, YEAR(orderdate)
-- HAVING COUNT(*) > 1
-- ORDER BY empid, orderyear;

-- The From clause
-- select *
-- from Sales.Orders;

-- The Where clause
-- select
--     empid,
--     YEAR(orderdate) as orderyear
-- from Sales.Orders
-- where custid = 71
-- order by empid;

-- The Group By clause
-- select
--     empid,
--     YEAR(orderdate) as orderyear,
--     SUM(freight) as totalfreight,
--     COUNT(*) as numorders
-- from Sales.Orders
-- where custid = 71
-- group by empid, YEAR(orderdate);

-- The Having clause
-- SELECT empid, YEAR(orderdate) as orderyear, COUNT(*) as total
-- FROM Sales.Orders
-- WHERE custid = 71
-- GROUP BY empid, YEAR(orderdate)
-- HAVING COUNT(*) > 1;

-- The Select clause
-- Select aliases, below 3 queries results are all the same
-- SELECT empid, YEAR(orderdate) as orderyear
-- FROM Sales.Orders
-- WHERE custid = 71
-- GROUP BY empid, YEAR(orderdate)
-- HAVING COUNT(*) > 1;

-- SELECT empid, orderyear = YEAR(orderdate)
-- FROM Sales.Orders
-- WHERE custid = 71
-- GROUP BY empid, YEAR(orderdate)
-- HAVING COUNT(*) > 1;

-- SELECT empid, YEAR(orderdate) orderyear
-- FROM Sales.Orders
-- WHERE custid = 71
-- GROUP BY empid, YEAR(orderdate)
-- HAVING COUNT(*) > 1;

-- SELECT empid, YEAR(orderdate) as orderyear, COUNT(*) as numorders
-- FROM Sales.Orders
-- WHERE custid = 71
-- GROUP BY empid, YEAR(orderdate)
-- HAVING COUNT(*) > 1;

-- The Order By clause

-- select empid, YEAR(orderdate) as orderyear, COUNT(*) as numorders
-- from Sales.Orders
-- WHERE custid = 71
-- GROUP BY empid, YEAR(orderdate)
-- HAVING COUNT(*) > 1
-- ORDER BY empid, orderyear DESC;

-- The TOP and OFFSET-FETCH filters

-- SELECT TOP(5)
--     orderid, orderdate, custid, empid
-- FROM Sales.Orders
-- ORDER BY orderdate DESC;

-- -- With percent
-- SELECT TOP(1) PERCENT
--     orderid, orderdate, custid, empid
-- FROM Sales.Orders
-- ORDER BY orderdate DESC;

-- With Ties

-- SELECT TOP(5)
--     orderid, orderdate, custid, empid
-- FROM Sales.Orders
-- ORDER BY orderdate DESC, orderid DESC;

-- SELECT TOP(5) WITH TIES
--     orderid, orderdate, custid, empid
-- FROM Sales.Orders
-- ORDER BY orderdate DESC;

-- SELECT orderid, orderdate, custid, empid
-- FROM Sales.Orders
-- ORDER BY orderdate, orderid
-- OFFSET 50 ROWS FETCH NEXT 25 ROWS ONLY;

-- Window functions
-- SELECT
--     orderid,
--     custid,
--     val,
--     ROW_NUMBER() OVER(PARTITION BY custid ORDER BY val) as rownum
-- FROM Sales.OrderValues
-- ORDER BY custid, val;

-- Predicates and operators

-- SELECT orderid, empid, orderdate
-- FROM Sales.Orders
-- WHERE orderid IN(10248, 10249, 10250);

-- SELECT orderid, empid, orderdate
-- FROM Sales.Orders
-- WHERE orderid BETWEEN 10300 AND 10310;

-- SELECT empid, firstname, lastname
-- FROM HR.Employees
-- WHERE lastname LIKE N'D%';

-- Case Expression
-- SELECT productid, productname, categoryid,
--     CASE categoryid
--     WHEN 1 THEN 'One'
--     WHEN 2 THEN 'Two'
--     WHEN 3 THEN 'Three'
--     WHEN 4 THEN 'Four'
--     WHEN 5 THEN 'Five'
--     WHEN 6 THEN 'Six'
--     WHEN 7 THEN 'Seven'
--     WHEN 8 THEN 'Eight'
--     ELSE 'Unknown category'
--     END AS categoryname
-- FROM Production.Products;

-- NULLs

-- SELECT custid, country, region, city
-- FROM Sales.Customers
-- WHERE region = N'WA';

-- SELECT custid, country, region, city
-- FROM Sales.Customers
-- WHERE region <> N'WA';

-- SELECT custid, country, region, city
-- FROM Sales.Customers
-- WHERE region IS NULL;

-- SELECT custid, country, region, city
-- FROM Sales.Customers
-- WHERE region <> N'WA'
--     OR region IS NULL;