USE TSQLV4;

-- Ex1
-- SELECT orderid, orderdate, custid, empid,
--     DATEFROMPARTS(YEAR(orderdate), 12, 31) AS endofyear
-- FROM Sales.Orders
-- WHERE orderdate <> endofyear;

-- The above where clause is invalid because the endofyear column name
-- is not available to it, and where clause should contain
-- orderdate <> DATEFROMPARTS(YEAR(orderdate), 12, 31) AS endofyear
WITH
    C
    AS
    (
        SELECT orderid, orderdate, custid, empid,
            DATEFROMPARTS(YEAR(orderdate), 12, 31) AS endofyear
        FROM Sales.Orders
    )
SELECT orderid, orderdate, custid, empid, endofyear
FROM C
WHERE orderdate <> endofyear;

-- Ex2-1
SELECT empid, maxorderdate
FROM (
    SELECT
        empid, MAX(orderdate) AS maxorderdate
    FROM Sales.Orders
    GROUP BY empid 
) AS O

-- Ex2-2
WITH
    EmpMaxOrderDate
    AS
    (
        SELECT
            empid, MAX(orderdate) AS maxorderdate
        FROM Sales.Orders
        GROUP BY empid
    )
SELECT O1.empid, orderdate, orderid, custid
FROM Sales.Orders AS O1
    JOIN EmpMaxOrderDate ON 
        O1.empid = EmpMaxOrderDate.empid
        AND
        O1.orderdate = EmpMaxOrderDate.maxorderdate
ORDER BY O1.empid DESC;

-- Ex3-1
SELECT orderid, orderdate, custid, empid,
    ROW_NUMBER() OVER(ORDER BY orderdate) AS rownum
FROM Sales.Orders
ORDER BY orderdate;

WITH
    OrderedOrders
    AS
    (
        SELECT orderid, orderdate, custid, empid,
            ROW_NUMBER() OVER(ORDER BY orderdate) AS rownum
        FROM Sales.Orders
    )
SELECT orderid, orderdate, custid, empid, rownum
FROM OrderedOrders
WHERE rownum BETWEEN 11 AND 20;

-- Ex4
WITH
    ManagementChain
    AS
    (
                    SELECT empid, mgrid, firstname, lastname
            FROM HR.Employees
            WHERE empid = 9
        UNION ALL
            SELECT Chain.empid, Chain.mgrid, Chain.firstname, Chain.lastname
            FROM HR.Employees AS Chain
                JOIN ManagementChain AS MChain
                ON Chain.empid = MChain.mgrid
    )
SELECT empid, mgrid, firstname, lastname
FROM ManagementChain;

-- Ex5-1
DROP VIEW IF EXISTS Sales.VEmpOrders;
GO

CREATE VIEW Sales.VEmpOrders
AS
    SELECT empid, YEAR(O1.orderdate) AS orderyear, SUM(OD1.qty) AS qty
    FROM Sales.Orders AS O1
        JOIN Sales.OrderDetails AS OD1
        ON O1.orderid = OD1.orderid
    GROUP BY empid, YEAR(O1.orderdate)
GO

SELECT empid, orderyear, qty
FROM Sales.VEmpOrders
ORDER BY empid, orderyear;

-- Ex5-2
SELECT O1.empid, O1.orderyear, O1.qty,
    (SELECT SUM(O2.qty)
    FROM Sales.VEmpOrders AS O2
    WHERE O1.empid = O2.empid AND
        O1.orderyear >= O2.orderyear
) AS runqty
FROM Sales.VEmpOrders AS O1
ORDER BY empid, orderyear;

-- Ex6-1
DROP FUNCTION IF EXISTS Production.TopProducts;
GO

CREATE FUNCTION Production.TopProducts
(@supid AS INT, @n AS INT) RETURNS TABLE
AS 
RETURN
SELECT TOP(@n)
    productid, productname, unitprice
FROM Production.Products
WHERE supplierid = @supid
ORDER BY unitprice DESC;
GO

SELECT *
FROM Production.TopProducts(5,2);

-- Ex6-2

SELECT PS1.supplierid, PS1.companyname, productid, productname, unitprice
FROM Production.Suppliers AS PS1
CROSS APPLY Production.TopProducts(PS1.supplierid, 2)

DROP FUNCTION IF EXISTS Production.TopProducts;
GO
DROP VIEW IF EXISTS Sales.VEmpOrders;
GO