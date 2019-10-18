USE TSQLV4;

DROP TABLE IF EXISTS dbo.Orders;

CREATE TABLE dbo.Orders
(
    orderid INT NOT NULL,
    orderdate DATE NOT NULL,
    empid INT NOT NULL,
    custid VARCHAR(5) NOT NULL,
    qty INT NOT NULL,
    CONSTRAINT PK_Orders PRIMARY KEY(orderid)
);
GO

INSERT INTO dbo.Orders
    (
    orderid, orderdate, empid, custid, qty
    )
VALUES
    (30001, '20140802', 3, 'A', 10),
    (10001, '20141224', 2, 'A', 12),
    (10005, '20141224', 1, 'B', 20),
    (40001, '20150109', 2, 'A', 40),
    (10006, '20150118', 1, 'C', 14),
    (20001, '20150212', 2, 'B', 12),
    (40005, '20160212', 3, 'A', 10),
    (20002, '20160216', 1, 'C', 20),
    (30003, '20160418', 2, 'B', 15),
    (30004, '20140418', 3, 'C', 22),
    (30007, '20160907', 3, 'D', 30);
GO

-- Grouping sets

-- Base 4 separate results
SELECT empid, custid, SUM(qty) AS sumqty
FROM dbo.Orders
GROUP BY empid, custid;

SELECT empid, SUM(qty) AS sumqty
FROM dbo.Orders
GROUP BY empid;

SELECT custid, SUM(qty) AS sumqty
FROM dbo.Orders
GROUP BY custid;

SELECT SUM(qty) AS sumqty
FROM dbo.Orders;

-- Unified result set
    SELECT empid, custid, SUM(qty) AS sumqty
    FROM dbo.Orders
    GROUP BY empid, custid

UNION ALL

    SELECT empid, NULL, SUM(qty) AS sumqty
    FROM dbo.Orders
    GROUP BY empid

UNION ALL

    SELECT NULL, custid, SUM(qty) AS sumqty
    FROM dbo.Orders
    GROUP BY custid

UNION ALL

    SELECT NULL, NULL, SUM(qty) AS sumqty
    FROM dbo.Orders;

-- GROUPING SETS subclause, it's shorter and more optimized by sql server
SELECT empid, custid, SUM(qty) AS sumqty
FROM dbo.Orders
GROUP BY 
GROUPING SETS(
    (empid, custid),
    (empid),
    (custid),
    ()
);
-- The CUBE subclause
-- provides an abbreviated way to define multiple grouping sets.
-- CUBE(a,b,c) is equivalent to 
-- GROUPING SETS((a,b,c), (a,b), (a,c), (b,c), (a), (b), (c))
SELECT empid, custid, SUM(qty) AS sumqty
FROM dbo.Orders
GROUP BY CUBE(empid, custid);

-- The ROLLUP subclause
-- ROLLUP(a,b,c) equals to GROUP BY ((a,b,c), (a,b), (a), ())
SELECT YEAR(orderdate) AS orderyear, MONTH(orderdate) AS ordermonth,
    DAY(orderdate) AS orderday,
    SUM(qty) AS sumqty
FROM dbo.Orders
GROUP BY ROLLUP(YEAR(orderdate), MONTH(orderdate), DAY(orderdate));

-- GROUPING
-- 0 - means it participated
-- 1 - means it didn't


-- DROP TABLE IF EXISTS dbo.Orders;
