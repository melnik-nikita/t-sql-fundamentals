USE TSQLV4;

UPDATE Production.Products
SET unitprice += 1.00
WHERE productid = 2;
