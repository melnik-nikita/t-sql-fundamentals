USE TSQLV4;

-- ALTER DATABASE TSQLV4 SET ALLOW_SNAPSHOT_ISOLATION ON;
-- Ex1
-- BEGIN TRAN;

-- UPDATE Production.Products
-- SET unitprice -= 1.00
-- WHERE productid = 2;

-- SELECT productid, unitprice
-- FROM Production.Products
-- WHERE productid = 2;

-- COMMIT TRAN;

-- Ex2
SET TRANSACTION ISOLATION LEVEL SNAPSHOT;

BEGIN TRAN;

SELECT productid, unitprice
FROM Production.Products
WHERE productid = 2;

UPDATE Production.Products
SET unitprice = 19.00
WHERE productid = 2;

COMMIT TRAN;

