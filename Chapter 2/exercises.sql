USE TSQLV4;

-- Ex1
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE MONTH(orderdate) = 6 AND YEAR(orderdate) = 2015;

-- Ex2
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE orderdate = EOMONTH(orderdate);

-- Ex3
SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname LIKE N'%e%e%';

-- Ex4
SELECT orderid, SUM(qty * unitprice) as totalvalue
FROM Sales.OrderDetails
GROUP BY orderid
HAVING SUM(qty * unitprice) > 10000
ORDER BY totalvalue DESC;

-- Ex5
SELECT empid, lastname
FROM HR.Employees
WHERE lastname COLLATE Latin1_General_CS_AS LIKE N'[abcdefghijklmnopqrstuvwxyz]%';

-- Ex6
-- SELECT empid, COUNT(*) AS numorders
-- FROM Sales.Orders
-- WHERE orderdate < '20160501'
-- GROUP BY empid;

-- SELECT empid, COUNT(*) AS numorders
-- FROM Sales.Orders
-- GROUP BY empid
-- HAVING MAX(orderdate) < '20160501';

-- The difference is that in first query first filter out the table where order date is
-- less than the 20160501 and only after that we group the result set and counting
-- number of orders
-- The second query filters the group clause by order date, so the order date of 
-- employee is less that 20160501 and only after that counts the sum of orders

-- Ex7
SELECT TOP 3
    shipcountry, AVG(freight) AS avgfreight
FROM Sales.Orders
WHERE YEAR(orderdate) = '2015'
GROUP BY shipcountry
ORDER BY avgfreight DESC;

-- This is faster
SELECT TOP 3
    shipcountry, AVG(freight) AS avgfreight
FROM Sales.Orders
WHERE orderdate >= '20150101' AND orderdate < '20160101'
GROUP BY shipcountry
ORDER BY avgfreight DESC;

-- Ex8
SELECT custid, orderdate, orderid,
    ROW_NUMBER() OVER (PARTITION BY custid ORDER BY orderdate)
FROM Sales.Orders;

-- Ex9
SELECT empid, firstname, lastname, titleofcourtesy,
    CASE titleofcourtesy
    WHEN 'Ms.' THEN 'Female'
    WHEN 'Mrs.' THEN 'Female'
    WHEN 'Mr.' THEN 'Male'
    ELSE 'Unknown'
    END AS gender
FROM HR.Employees;

-- Ex10
SELECT custid, region
FROM Sales.Customers
ORDER BY CASE WHEN region IS NULL THEN 1 ELSE 0 END, region;
