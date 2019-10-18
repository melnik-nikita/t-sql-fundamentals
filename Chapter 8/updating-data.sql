USE TSQLV4;

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
    freight MONEY NOT NULL
        CONSTRAINT DFT_Orders_freight DEFAULT(0),
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
    unitprice MONEY NOT NULL
        CONSTRAINT DFT_OrderDetails_unitprice DEFAULT(0),
    qty SMALLINT NOT NULL
        CONSTRAINT DFT_OrderDetails_qty DEFAULT(1),
    discount NUMERIC(4, 3) NOT NULL
        CONSTRAINT DFT_OrderDetails_discount DEFAULT(0),
    CONSTRAINT PK_OrderDetails PRIMARY KEY(orderid, productid),
    CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY(orderid)
    REFERENCES dbo.Orders(orderid),
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

-- The Update statement
UPDATE dbo.OrderDetails
SET discount += 0.05
WHERE productid = 51;

UPDATE OD
    SET discount += 0.05
    FROM dbo.OrderDetails AS OD
    INNER JOIN dbo.Orders AS O
    ON OD.orderid = O.orderid
    WHERE O.custid = 1;

-- Same as above
UPDATE dbo.OrderDetails
SET discount += 0.05
WHERE EXISTS
(
    SELECT *
FROM dbo.Orders AS O
WHERE O.orderid = OrderDetails.orderid
    AND O.custid = 1
);

-- Assignment UPDATE
DROP TABLE IF EXISTS dbo.MySequences;

CREATE TABLE dbo.MySequences
(
    id VARCHAR(10) NOT NULL CONSTRAINT PK_MySequences PRIMARY KEY(id),
    val INT NOT NULL
);

INSERT INTO dbo.MySequences
VALUES('SEQ1', 0);

DECLARE @nextval AS INT;

UPDATE dbo.MySequences
SET @nextval = val += 1
WHERE id = 'SEQ1';

SELECT @nextval;

DROP TABLE IF EXISTS dbo.MySequences;
DROP TABLE IF EXISTS dbo.OrderDetails, dbo.Orders;
