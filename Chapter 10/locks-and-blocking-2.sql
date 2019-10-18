USE TSQLV4;

SET LOCK_TIMEOUT 5000;

SELECT productid, unitprice
FROM Production.Products
WHERE productid = 2;

SET LOCK_TIMEOUT -1;
KILL 58;