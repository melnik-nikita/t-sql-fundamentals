USE TSQLV4;

DROP TABLE IF EXISTS dbo.EmpCustOrders;

CREATE TABLE dbo.EmpCustOrders
(
    empid INT NOT NULL
        CONSTRAINT PK_EmpCustOrders PRIMARY KEY,
    A VARCHAR(5) NULL,
    B VARCHAR(5) NULL,
    C VARCHAR(5) NULL,
    D VARCHAR(5) NULL
);

INSERT INTO dbo.EmpCustOrders
    (empid, A, B, C, D)
SELECT empid, A, B, C, D
FROM (SELECT empid, custid, qty
    FROM dbo.Orders) AS D
    PIVOT(SUM(qty) FOR custid IN(A, B, C, D)) AS P;

SELECT *
FROM dbo.EmpCustOrders;

-- Unpivoting using APPLY operator
-- Step 1
SELECT *
FROM dbo.EmpCustOrders CROSS JOIN (VALUES('A'),
        ('B'),
        ('C'),
        ('D')) AS C(custid);
-- Step 2
SELECT empid, custid, qty
FROM dbo.EmpCustOrders
CROSS APPLY (VALUES('A', A),
        ('B', B),
        ('C', C),
        ('D', D)) AS C(custid, qty);
-- Step 3 (eliminate null qty)
SELECT empid, custid, qty
FROM dbo.EmpCustOrders
CROSS APPLY (VALUES('A', A),
        ('B', B),
        ('C', C),
        ('D', D)) AS C(custid, qty)
WHERE qty IS NOT NULL;

-- Unpivoting using UNPIVOT operator
SELECT empid, custid, qty
FROM dbo.EmpCustOrders
UNPIVOT(qty FOR custid IN(A, B, C, D)) AS U;

DROP TABLE IF EXISTS dbo.EmpCustOrders;
DROP TABLE IF EXISTS dbo.Orders;
