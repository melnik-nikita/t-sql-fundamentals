USE TSQLV4;

BEGIN TRAN;
UPDATE Production.Products
SET unitprice += 1.00
WHERE productid = 2;

ROLLBACK TRAN;