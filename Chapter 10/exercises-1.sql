USE TSQLV4;

-- Ex1
BEGIN TRAN;
UPDATE Sales.OrderDetails SET discount = 0.05
WHERE orderid = 10249;

ROLLBACK TRAN;

-- Ex2-1
BEGIN TRAN;
UPDATE Sales.OrderDetails SET discount += 0.05 WHERE orderid = 10249;
SELECT orderid, productid, unitprice, qty, discount
FROM Sales.OrderDetails
WHERE orderid = 10249;

ROLLBACK TRAN;

-- Ex2-2
BEGIN TRAN;
UPDATE Sales.OrderDetails SET discount += 0.05 WHERE orderid = 10249;
SELECT orderid, productid, unitprice, qty, discount
FROM Sales.OrderDetails
WHERE orderid = 10249;

COMMIT TRAN;

-- Ex2-3
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
BEGIN TRAN;
SELECT orderid, productid, unitprice, qty, discount
FROM Sales.OrderDetails
WHERE orderid = 10249;

SELECT orderid, productid, unitprice, qty, discount
FROM Sales.OrderDetails
WHERE orderid = 10249;
COMMIT TRAN;

-- Ex2-4
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN TRAN;
SELECT orderid, productid, unitprice, qty, discount
FROM Sales.OrderDetails
WHERE orderid = 10249;

SELECT orderid, productid, unitprice, qty, discount
FROM Sales.OrderDetails
WHERE orderid = 10249;
COMMIT TRAN;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Ex2-5
ALTER DATABASE TSQLV4 SET ALLOW_SNAPSHOT_ISOLATION ON;

BEGIN TRAN;
UPDATE Sales.OrderDetails SET discount += 0.05 WHERE orderid = 10249;
SELECT orderid, productid, unitprice, qty, discount
FROM Sales.OrderDetails
WHERE orderid = 10249;

COMMIT TRAN;

-- Ex2-6
ALTER DATABASE TSQLV4 SET ALLOW_SNAPSHOT_ISOLATION OFF;
ALTER DATABASE TSQLV4 SET READ_COMMITTED_SNAPSHOT OFF;

-- Ex3
BEGIN TRAN;
UPDATE Production.Products SET unitprice += 1.00
WHERE productid = 2;

SELECT productid, unitprice
FROM Production.Products
WHERE productid = 3;
COMMIT TRAN;