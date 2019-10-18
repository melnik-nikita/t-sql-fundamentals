USE TSQLV4;

DROP TABLE IF EXISTS dbo.Orders, dbo.Custormers;

CREATE TABLE dbo.Customers
(
    custid INT NOT NULL,
    companyname NVARCHAR(40) NOT NULL,
    contactname NVARCHAR(30) NOT NULL,
    contacttitle NVARCHAR(30) NOT NULL,
    address NVARCHAR(60) NOT NULL,
    city NVARCHAR(15) NOT NULL,
    region NVARCHAR(15) NULL,
    postalcode NVARCHAR(10) NULL,
    country NVARCHAR(15) NOT NULL,
    phone NVARCHAR(24) NOT NULL,
    fax NVARCHAR(24) NULL,
    CONSTRAINT PK_Customers PRIMARY KEY(custid)
);

CREATE TABLE dbo.Orders
(
    orderid INT NOT NULL,
    custid INT NULL,
    empid INT NOT NULL,
    orderdate DATE NOT NULL,
    requireddate DATE NOT NULL,
    shippeddate DATE NULL,
    shipperid INT NOT NULL,
    freight MONEY NOT NULL
        CONSTRAINT DFT_Orders_freight DEFAULT(0),
    shipname NVARCHAR(40) NOT NULL,
    shipaddress NVARCHAR(60) NOT NULL,
    shipcity NVARCHAR(15) NOT NULL,
    shipregion NVARCHAR(15) NULL,
    shippostalcode NVARCHAR(10) NULL,
    shipcountry NVARCHAR(15) NOT NULL,
    CONSTRAINT PK_Orders PRIMARY KEY(orderid),
    CONSTRAINT FK_Orders_Customers FOREIGN KEY(custid)
    REFERENCES dbo.Customers(custid)
);
GO

INSERT INTO dbo.Customers
SELECT *
FROM Sales.Customers;
INSERT INTO dbo.Orders
SELECT *
FROM Sales.Orders;


-- The Delete statement
DELETE FROM dbo.Orders
WHERE orderdate < '20150101';

-- THe Truncate statement
TRUNCATE TABLE dbo.T1;

-- Delete based on JOIN
DELETE FROM O
FROM dbo.Orders AS O
    INNER JOIN dbo.Customers AS C
    ON O.custid = C.custid
    WHERE C.country = N'USA';

DROP TABLE IF EXISTS dbo.Orders, dbo.Custormers;
