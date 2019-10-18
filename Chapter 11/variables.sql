USE TSQLV4;

DECLARE @i AS INT;
SET @i = 10;

DECLARE @empname AS NVARCHAR(61);
SET @empname = (SELECT firstname + N' ' + lastname
FROM HR.Employees
WHERE empid = 3);

SELECT @empname AS empname;

DECLARE @firstname AS NVARCHAR(20), @lastname AS NVARCHAR(40);

SELECT @firstname = firstname, @lastname = lastname
FROM HR.Employees
WHERE empid = 3;

SELECT @firstname as firstname, @lastname as lastname ;