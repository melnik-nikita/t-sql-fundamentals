USE TSQLV4;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

BEGIN TRAN;

SELECT productid, unitprice
FROM Production.Products
WHERE productid = 2;

COMMIT TRAN;