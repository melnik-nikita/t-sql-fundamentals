use TSQLV4;

-- Ex1
SELECT E.empid, E.firstname, E.lastname, N.n
FROM dbo.Nums AS N
CROSS JOIN HR.Employees as E
WHERE N.n <= 5;

-- Ex1-2(optional)
SELECT Emp.empid, DATEADD(day, Nums.n - 1, CAST('2016-06-12' AS DATE)) AS dt
FROM dbo.Nums AS Nums
    CROSS JOIN  HR.Employees AS Emp
WHERE 
    DATEADD (day, Nums.n - 1, CAST('2016-06-12' AS DATE)) >= '2016-06-12'
    AND
    DATEADD(day, Nums.n - 1, CAST('2016-06-12' AS DATE)) <= '2016-06-16'
ORDER BY Emp.empid;

-- Ex2
-- SELECT Customers.custid, Customers.companyName, Orders.Orderid, Orders.orderdate
-- FROM Sales.Customers AS C
--     INNER JOIN Sales.Orders AS O
--     ON Customers.custid = Orders.custid;
-- The problem with a query above is that it doesn't use aliases but actual tables
-- and this crashes the query as when tables is aliased the aliases should be used.
SELECT C.custid, C.companyName, O.Orderid, O.orderdate
FROM Sales.Customers AS C
    INNER JOIN Sales.Orders AS O
    ON C.custid = O.custid;

-- Ex3
SELECT
    Customers.custid,
    COUNT(DISTINCT Orders.orderid) AS numorders,
    SUM(OrderDetails.qty) AS totalqty
FROM Sales.Customers
    JOIN Sales.Orders ON Customers.custid = Orders.custid
    JOIN Sales.OrderDetails ON Orders.orderid = OrderDetails.orderid
WHERE Customers.country = N'USA'
GROUP BY Customers.custid;

-- Ex4
SELECT cust.custid, cust.companyname, orders.orderid, orders.orderdate
FROM Sales.Customers as cust
    LEFT OUTER JOIN Sales.Orders as orders ON cust.custid = orders.custid;

-- Ex5
SELECT cust.custid, cust.companyname
FROM Sales.Customers as cust
    LEFT OUTER JOIN Sales.Orders as orders ON cust.custid = orders.custid
WHERE orders.orderid IS NULL;

-- Ex6
SELECT cust.custid, cust.companyname, orders.orderid, orders.orderdate
FROM Sales.Customers as cust
    INNER JOIN Sales.Orders as orders ON cust.custid = orders.custid
WHERE orders.orderdate = '2016-02-12';

-- Ex7
SELECT cust.custid, cust.companyname, orders.orderid, orders.orderdate
FROM Sales.Customers as cust
    LEFT OUTER JOIN
    Sales.Orders as orders
    ON cust.custid = orders.custid
        AND
        orders.orderdate = '2016-02-12';

-- Ex8 Why below query is not a correct solution for Ex7
SELECT cust.custid, cust.companyname, orders.orderid, orders.orderdate
FROM Sales.Customers as cust
    LEFT OUTER JOIN
    Sales.Orders as orders ON cust.custid = orders.custid
WHERE orders.orderdate = '2016-02-12'
    OR Orders.orderid IS NULL;
-- It is incorrect because where clause filters the orders table,
-- not the result set of join, and as a result returns only rows
-- where orderdate in orders table equals to date or order id is null

-- Ex9
SELECT
    DISTINCT cust.custid, cust.companyname,
    CASE orders.orderdate WHEN '20160212' THEN 'YES' ELSE 'NO' END
FROM Sales.Customers as cust
    LEFT OUTER JOIN Sales.Orders as orders
    ON cust.custid = orders.custid
        AND orders.orderdate = '20160212'
ORDER BY cust.custid;