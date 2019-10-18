USE TSQLV4;

-- Ex1
SELECT
    custid, orderid, qty,
    RANK() OVER(PARTITION BY custid ORDER BY qty) AS rnk,
    DENSE_RANK() OVER(PARTITION BY custid ORDER BY qty) AS drnk
FROM dbo.Orders;

-- Ex2
SELECT val, ROW_NUMBER() OVER(ORDER BY val) AS rownum
FROM Sales.OrderValues
GROUP BY val;

-- I can't find any other way to achieve this

-- Ex3
SELECT
    custid, orderid, qty,
    qty - LAG(qty) OVER(PARTITION BY custid ORDER BY orderdate) as diffprev,
    qty - LEAD(qty) OVER(PARTITION BY custid ORDER BY orderdate) as diffnext
FROM dbo.Orders;

-- Ex4
SELECT empid, [2014] AS cnt2014, [2015] AS cnt2015, [2016] AS cnt2016
FROM (SELECT empid, YEAR(orderdate) AS year
    FROM dbo.Orders) AS D
PIVOT(COUNT(year) FOR year IN([2014], [2015], [2016])) AS P;

--Ex5
DROP TABLE IF EXISTS dbo.EmpYearOrders;

CREATE TABLE dbo.EmpYearOrders
(
    empid INT NOT NULL
        CONSTRAINT PK_EmpYearOrders PRIMARY KEY,
    cnt2014 INT NULL,
    cnt2015 INT NULL,
    cnt2016 INT NULL
);

INSERT INTO dbo.EmpYearOrders
    (empid, cnt2014, cnt2015, cnt2016)
SELECT empid, [2014] AS cnt2014, [2015] AS cnt2015, [2016] AS cnt2016
FROM (SELECT empid, YEAR(orderdate) AS orderyear
    FROM dbo.Orders) AS D
    PIVOT(COUNT(orderyear)
          FOR orderyear IN([2014], [2015], [2016])) AS P;

SELECT *
FROM dbo.EmpYearOrders;

SELECT
    empid, orderyear, numorders
FROM dbo.EmpYearOrders
UNPIVOT(numorders FOR orderyear IN([cnt2014], [cnt2015], [cnt2016])) AS U
WHERE numorders <> 0;

DROP TABLE IF EXISTS dbo.EmpYearOrders;

-- Ex6
SELECT
    GROUPING_ID(empid, custid, YEAR(orderdate)) AS groupingset,
    empid, custid, YEAR(orderdate) AS orderyear, SUM(qty) AS sumqty
FROM dbo.Orders
GROUP BY 
GROUPING SETS(
    (empid, custid, YEAR(orderdate)),
    (empid, YEAR(orderdate)),
    (custid, YEAR(orderdate))
);

DROP TABLE IF EXISTS dbo.Orders;