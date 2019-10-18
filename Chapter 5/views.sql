USE TSQLV4;

DROP VIEW IF EXISTS Sales.USACusts;
GO

CREATE VIEW Sales.USACusts
WITH
    ENCRYPTION
AS
    SELECT
        custid, companyname, contactname, contacttitle, address,
        city, region, postalcode, country, phone, fax
    FROM Sales.Customers
    WHERE country = N'USA';
    GO

-- Get definition of view
SELECT OBJECT_DEFINITION(OBJECT_ID('Sales.USACusts'));


DROP VIEW IF EXISTS Sales.USACusts;
GO