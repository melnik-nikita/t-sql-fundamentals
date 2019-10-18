USE TSQLV4;

-- INSERT WITH OUTPUT
DROP TABLE IF EXISTS dbo.T1;

CREATE TABLE dbo.T1
(
    keycol INT NOT NULL IDENTITY(1,1) CONSTRAINT PK_T1 PRIMARY KEY,
    datacol NVARCHAR(40) NOT NULL
);

INSERT INTO dbo.T1
    (datacol)
OUTPUT
inserted.*
SELECT lastname
FROM HR.Employees
WHERE country = N'USA';

DROP TABLE IF EXISTS dbo.T1;

DROP TABLE IF EXISTS dbo.OrderDetails, dbo.ProductsAudit, dbo.Products,
dbo.Orders, dbo.Customers, dbo.T1, dbo.MySequences, dbo.CustomersStage;
