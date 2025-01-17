USE TSQLV4;

-- Step 1
BEGIN TRAN;

UPDATE Sales.OrderDetails
SET unitprice += 1.00
WHERE productid = 2;

-- Step 2
SELECT productid, unitprice
FROM Production.Products
WHERE productid = 2;
COMMIT TRAN;

-- Cleanup
UPDATE Production.Products SET unitprice = 19.00
WHERE productid = 2;
UPDATE Sales.OrderDetails SET unitprice = 19.00
WHERE productid = 2
    AND orderid >= 10500;
UPDATE Sales.OrderDetails SET unitprice = 15.20
WHERE productid = 2 AND orderid < 10500;