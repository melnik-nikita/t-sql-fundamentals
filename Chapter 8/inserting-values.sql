USE TSQLV4;

DROP TABLE IF EXISTS dbo.Orders;
CREATE TABLE dbo.Orders
(
    orderid INT NOT NULL CONSTRAINT PK_Orders PRIMARY KEY,
    orderdate DATE NOT NULL CONSTRAINT DFT_orderdate DEFAULT(SYSDATETIME()),
    empid INT NOT NULL,
    custid VARCHAR(10) NOT NULL
);

-- INSERT VALUES statement
INSERT INTO dbo.Orders
    (orderid, orderdate, empid, custid)
VALUES(10001, '20160212', 3, 'A');

INSERT INTO dbo.Orders
    (orderid, orderdate, empid, custid)
VALUES
    (10003, '20160213', 4, 'B'),
    (10004, '20160214', 1, 'A'),
    (10005, '20160213', 1, 'C'),
    (10006, '20160215', 3, 'C');

-- INSERT SELECT statement
INSERT INTO dbo.Orders
    (orderid, orderdate, empid, custid)
SELECT orderid, orderdate, empid, custid
FROM Sales.Orders
WHERE shipcountry = N'UK';

-- INSERT EXEC statement

DROP PROC IF EXISTS Sales.GetOrders;
GO

CREATE PROC Sales.GetOrders
    @country AS NVARCHAR(40)
AS
SELECT orderid, orderdate, empid, custid
FROM Sales.Orders
WHERE shipcountry = @country
GO

EXEC Sales.GetOrders @country = N'France';

INSERT INTO dbo.Orders
    (orderid, orderdate, empid, custid)
EXEC Sales.GetOrders @country = N'France';

-- SELECT INTO statement

DROP TABLE IF EXISTS dbo.Orders;

SELECT orderid, orderdate, empid, custid
INTO dbo.Orders
FROM Sales.Orders;

SELECT *
FROM dbo.Orders;
-- Sequence

CREATE SEQUENCE dbo.SeqOrderIDs AS INT
MINVALUE 1
CYCLE;

ALTER SEQUENCE dbo.SeqOrderIDs
NO CYCLE;

SELECT NEXT VALUE FOR dbo.SeqOrderIDs;

DROP TABLE IF EXISTS dbo.T1;

CREATE TABLE dbo.T1
(
    keycol INT NOT NULL CONSTRAINT PK_T1 PRIMARY KEY,
    datacol VARCHAR(10) NOT NULL
);

DECLARE @neworderid AS INT = NEXT VALUE FOR dbo.SeqOrderIDs;
INSERT INTO dbo.T1
    (keycol, datacol)
VALUES(@neworderid, 'a');

INSERT INTO dbo.T1
    (keycol, datacol)
VALUES(NEXT VALUE FOR dbo.SeqOrderIDs, 'b');

UPDATE dbo.T1
SET keycol = NEXT VALUE FOR dbo.SeqOrderIDs;

-- Get info about sequences
SELECT current_value
FROM sys.sequences
WHERE OBJECT_ID = OBJECT_ID(N'dbo.SeqOrderIDs');

-- Sequence used with OVER clause
INSERT INTO dbo.T1
    (keycol, datacol)
SELECT
    NEXT VALUE FOR dbo.SeqOrderIDs OVER(ORDER BY hiredate),
    LEFT(firstname, 1) + LEFT(lastname, 1)
FROM HR.Employees;

-- Sequence for defautl value
ALTER TABLE dbo.T1
ADD CONSTRAINT DFT_T1_keycol
DEFAULT (NEXT VALUE FOR dbo.SeqOrderIDs)
FOR keycol;

INSERT INTO dbo.T1
    (datacol)
VALUES('c');

SELECT *
FROM dbo.T1;

DROP TABLE IF EXISTS dbo.T1;
DROP SEQUENCE IF EXISTS dbo.SeqOrderIDs;