USE TSQLV4;

-- Ex1
DROP TABLE IF EXISTS dbo.Customers;

CREATE TABLE dbo.Customers
(
    custid INT NOT NULL PRIMARY KEY,
    companyname NVARCHAR(40) NOT NULL,
    country NVARCHAR(15) NOT NULL,
    region NVARCHAR(15) NULL,
    city NVARCHAR(15) NOT NULL
);

INSERT INTO dbo.Customers
    (custid, companyname, country, region, city)
VALUES(100, N'Coho Winery', N'USA', N'WA', N'Redmond');

INSERT INTO dbo.Customers
    (custid, companyname, country, region, city)
SELECT DISTINCT C.custid, C.companyname, C.country, C.region, C.city
FROM Sales.Customers AS C
    INNER JOIN Sales.Orders AS O
    ON C.custid = O.custid;

SELECT *
INTO dbo.Orders
FROM Sales.Orders
WHERE orderdate >= '20140101' AND orderdate < '20170101';

-- Ex2
DELETE FROM dbo.Orders
OUTPUT deleted.orderid, deleted.orderdate
WHERE orderdate < '20140801';

-- Ex3
DELETE FROM dbo.Orders
FROM dbo.Orders AS O
    JOIN Sales.Customers AS C
    ON O.custid = C.custid
WHERE C.country = N'Brazil';

-- Ex4
SELECT *
FROM dbo.Customers;

UPDATE dbo.Customers
    SET region = N'<None>'
OUTPUT inserted.custid, deleted.region AS oldregion, inserted.region AS newregion
WHERE region IS NULL;

-- Ex5
SELECT *
FROM dbo.Orders
WHERE shipcountry = N'UK';

MERGE INTO dbo.Orders AS TGT
USING dbo.Customers AS SRC
    ON TGT.custid = SRC.custid
    WHEN MATCHED AND SRC.country = N'UK' THEN
    UPDATE SET TGT.shipcountry = SRC.country,
        TGT.shipregion = SRC.region,
        TGT.shipcity = SRC.city;

-- Ex6
DROP TABLE IF EXISTS dbo.OrderDetails, dbo.Orders;

CREATE TABLE dbo.Orders
(
    orderid INT NOT NULL,
    custid INT NULL,
    empid INT NOT NULL,
    orderdate DATE NOT NULL,
    requireddate DATE NOT NULL,
    shippeddate DATE NULL,
    shipperid INT NOT NULL,
    freight MONEY NOT NULL CONSTRAINT DFT_Orders_freight DEFAULT(0),
    shipname NVARCHAR(40) NOT NULL,
    shipaddress NVARCHAR(60) NOT NULL,
    shipcity NVARCHAR(15) NOT NULL,
    shipregion NVARCHAR(15) NULL,
    shippostalcode NVARCHAR(10) NULL,
    shipcountry NVARCHAR(15) NOT NULL,
    CONSTRAINT PK_Orders PRIMARY KEY(orderid)
);

CREATE TABLE dbo.OrderDetails
(
    orderid INT NOT NULL,
    productid INT NOT NULL,
    unitprice MONEY NOT NULL CONSTRAINT DFT_OrderDetails_unitprice DEFAULT(0),
    qty SMALLINT NOT NULL CONSTRAINT DFT_OrderDetails_qty DEFAULT(1),
    discount NUMERIC(4, 3) NOT NULL CONSTRAINT DFT_OrderDetails_discount DEFAULT(0),
    CONSTRAINT PK_OrderDetails PRIMARY KEY(orderid, productid),
    CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY(orderid) REFERENCES dbo.Orders(orderid),
    CONSTRAINT CHK_discount  CHECK (discount BETWEEN 0 AND 1),
    CONSTRAINT CHK_qty  CHECK (qty > 0),
    CONSTRAINT CHK_unitprice CHECK (unitprice >= 0)
);
GO

INSERT INTO dbo.Orders
SELECT *
FROM Sales.Orders;
INSERT INTO dbo.OrderDetails
SELECT *
FROM Sales.OrderDetails;

ALTER TABLE dbo.OrderDetails
DROP CONSTRAINT FK_OrderDetails_Orders;

TRUNCATE TABLE dbo.OrderDetails;
TRUNCATE TABLE dbo.Orders;

ALTER TABLE dbo.OrderDetails
ADD CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY(orderid) REFERENCES dbo.Orders(orderid);

SELECT *
FROM dbo.OrderDetails;
SELECT *
FROM dbo.Orders;

DROP TABLE IF EXISTS dbo.OrderDetails, dbo.Orders, dbo.Customers;