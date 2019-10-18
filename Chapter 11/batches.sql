-- Valid batch
PRINT 'First batch';
USE TSQLV4;
GO
-- Invalid batch
PRINT 'Second batch';
SELECT custid
FROM Sales.Customers;
SELECT orderid FOM
Sales.Orders;
GO
-- Valid batch
PRINT 'Third batch';
SELECT empid
FROM HR.Employees;