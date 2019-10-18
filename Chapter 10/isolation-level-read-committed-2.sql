USE TSQLV4;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

SELECT productid, unitprice
FROM Production.Products
WHERE productid = 2;

-- UPDATE Production.Products
-- SET unitprice = 19.00
-- WHERE productid = 2;