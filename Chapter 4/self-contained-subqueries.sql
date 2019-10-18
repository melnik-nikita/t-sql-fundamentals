USE TSQLV4;

DECLARE @maxid AS INT = (SELECT MAX(orderid)
FROM Sales.Orders);

SELECT orderid, orderdate, empid, custid
FROM Sales.Orders
WHERE orderid = @maxid;

-- Example above can be converted to a scalar self contained subquery
SELECT orderid, orderdate, empid, custid
FROM Sales.Orders
WHERE orderid = (SELECT MAX(orderid)
FROM Sales.Orders);

SELECT orderid
FROM Sales.Orders
WHERE empid =
(SELECT E.empid
FROM HR.Employees AS E
WHERE E.lastname LIKE N'D%');

-- Multivalued subquery
SELECT orderid
FROM Sales.Orders
WHERE empid IN (SELECT E.empid
FROM HR.Employees AS E
WHERE E.lastname LIKE N'D%');

DROP TABLE IF EXISTS dbo.Orders;
CREATE TABLE dbo.Orders
(
    orderid INT NOT NULL CONSTRAINT PK_Orders PRIMARY KEY
);
INSERT INTO dbo.Orders
    (orderid)
SELECT orderid
FROM Sales.Orders
WHERE orderid % 2 = 0;

-- Usage of scalar and multivalued subquery in the same query
SELECT n
FROM dbo.Nums
WHERE n BETWEEN (SELECT MIN(O.orderid)
    FROM dbo.Orders AS O)
    AND (SELECT MAX(O.orderid)
    FROM dbo.Orders AS O)
    AND n NOT IN (SELECT O.orderid
    FROM dbo.Orders AS O);

DROP TABLE IF EXISTS dbo.Orders;