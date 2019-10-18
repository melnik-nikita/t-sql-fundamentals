use TSQLV4;

-- Cross join example
SELECT C.custid, E.empid
FROM Sales.Customers AS C
    CROSS JOIN HR.Employees AS E;

-- Self cross join
SELECT
    E1.empid, E1.firstname, E1.lastname,
    E2.empid, E2.firstname, E2.lastname
FROM HR.Employees AS E1
CROSS JOIN HR.Employees AS E2;

-- Producing tables of numbers

DROP TABLE IF EXISTS dbo.Digits;
CREATE TABLE dbo.Digits
(
    digit INT NOT NULL PRIMARY KEY
);

INSERT INTO dbo.Digits
    (digit)
VALUES
    (0),
    (1),
    (2),
    (3),
    (4),
    (5),
    (6),
    (7),
    (8),
    (9);
SELECT digit
FROM dbo.Digits;

SELECT D1.digit * 100 + D2.digit * 10 + D3.digit + 1 AS n
FROM dbo.Digits AS D1
CROSS JOIN dbo.Digits AS D2
CROSS JOIN dbo.Digits AS D3
ORDER BY n;