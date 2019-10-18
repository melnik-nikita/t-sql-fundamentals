USE TSQLV4;

DROP PROC IF EXISTS Sales.GetCustomerOrders;
GO

CREATE PROC Sales.GetCustomerOrders
    @custid AS INT,
    @fromdate AS DATETIME = '',
    @todate AS DATETIME = '',
    @numrows AS INT OUTPUT
AS
SET NOCOUNT ON;

SELECT orderid, empid, orderid, orderdate
FROM Sales.Orders
WHERE custid = @custid
    AND orderdate >= @fromdate
    AND orderdate <= @todate;

SET @numrows = @@ROWCOUNT;
GO

-- Usage
DECLARE @rc AS INT;

EXEC Sales.GetCustomerOrders
    @custid = 1,
    @fromdate = '20150101',
    @todate = '20160101',
    @numrows = @rc OUTPUT;

SELECT @rc AS numrows;
