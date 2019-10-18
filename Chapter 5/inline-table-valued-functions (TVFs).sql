USE TSQLV4;

DROP FUNCTION IF EXISTS dbo.GetCustOrders;
GO

CREATE FUNCTION dbo.GetCustOrders
(@cid AS INT) RETURNS TABLE
AS
RETURN
    SELECT orderid, custid, empid, orderdate, requireddate,
    shippeddate, shipperid, freight, shipname, shipaddress, shipcity,
    shipregion, shippostalcode, shipcountry
FROM Sales.Orders
WHERE custid = @cid;
GO

SELECT orderid, custid
FROM dbo.GetCustOrders(1) AS O;

DROP FUNCTION IF EXISTS dbo.GetCustOrders;
GO