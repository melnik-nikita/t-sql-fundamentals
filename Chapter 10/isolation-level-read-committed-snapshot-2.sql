USE TSQLV4;

BEGIN TRAN;
SELECT productid, unitprice
FROM Production.Products
WHERE productid = 2;

COMMIT TRAN;