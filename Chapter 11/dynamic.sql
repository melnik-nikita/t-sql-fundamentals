USE TSQLV4;

-- EXEC command
DECLARE @sql AS VARCHAR(100);
SET @sql = 'PRINT ''This message was printed by a dynamic SQL batch'';';
EXEC(@sql);
GO

-- sp_executesql stored procedure
DECLARE @sql AS NVARCHAR(100);
SET @sql = N'SELECT orderid, custid, empid, orderdate FROM  Sales.Orders WHERE orderid = @orderid;';

EXEC sp_executesql
    @stmt = @sql,
    @params = N'@orderid AS INT',
    @orderid = 10248;
GO
