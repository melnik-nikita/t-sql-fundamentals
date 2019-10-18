USE TSQLV4;

-- Ex1
-- SET TRANSACTION ISOLATION LEVEL SNAPSHOT;

-- BEGIN TRAN;

-- SELECT productid, unitprice
-- FROM Production.Products
-- WHERE productid = 2;

-- COMMIT TRAN;

-- UPDATE Production.Products
-- SET unitprice = 19.00
-- WHERE productid = 2;

-- Ex2
UPDATE Production.Products
SET unitprice = 25.00
WHERE productid = 2;