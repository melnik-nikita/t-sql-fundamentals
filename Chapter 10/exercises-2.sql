USE TSQLV4;

-- Ex1
SET LOCK_TIMEOUT -1; 
GO

SELECT orderid, productid, unitprice, qty, discount
FROM Sales.OrderDetails
WHERE orderid = 10249;

SET LOCK_TIMEOUT 1800; 
GO

-- Ex2-1
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SELECT orderid, productid, unitprice, qty, discount
FROM Sales.OrderDetails
WHERE orderid = 10249;

-- Ex2-2
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT orderid, productid, unitprice, qty, discount
FROM Sales.OrderDetails
WHERE orderid = 10249;

UPDATE Sales.OrderDetails SET discount = 0.00
WHERE orderid = 10249;

-- Ex2-3
UPDATE Sales.OrderDetails SET discount += 0.05 WHERE orderid = 10249;

UPDATE Sales.OrderDetails SET discount = 0.00
WHERE orderid = 10249;

-- Ex2-4
INSERT INTO Sales.OrderDetails
    (orderid, productid, unitprice, qty, discount)
VALUES(10249, 2, 19.00, 10, 0.00);

DELETE FROM Sales.OrderDetails WHERE orderid = 10249
    AND productid = 2;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Ex2-5
SET TRANSACTION ISOLATION LEVEL SNAPSHOT;
BEGIN TRAN;
SELECT orderid, productid, unitprice, qty, discount
FROM Sales.OrderDetails
WHERE orderid = 10249;

COMMIT TRAN;
SELECT orderid, productid, unitprice, qty, discount
FROM Sales.OrderDetails
WHERE orderid = 10249;

UPDATE Sales.OrderDetails SET discount = 0.00
WHERE orderid = 10249;


ALTER DATABASE TSQLV4 SET ALLOW_SNAPSHOT_ISOLATION OFF;
ALTER DATABASE TSQLV4 SET READ_COMMITTED_SNAPSHOT OFF;
-- Ex3
BEGIN TRAN;
UPDATE Production.Products SET unitprice += 1.00
WHERE productid = 3;

SELECT productid, unitprice
FROM Production.Products
WHERE productid = 2;
COMMIT TRAN;

UPDATE Production.Products SET unitprice = 19.00
WHERE productid = 2;
UPDATE Production.Products SET unitprice = 10.00
WHERE productid = 3;