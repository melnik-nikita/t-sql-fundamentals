USE TSQLV4;

-- Step 1
BEGIN TRAN;

UPDATE Production.Products
SET unitprice += 1.00
WHERE productid = 2;

-- Step 2
SELECT orderid, productid, unitprice
FROM Sales.OrderDetails
WHERE productid = 2;
COMMIT TRAN;