use TSQLV4;

DROP TABLE IF EXISTS dbo.Orders;
DROP TABLE IF EXISTS dbo.Employees;
-- For sql server < 2016
-- IF OBJECT_ID(N'dbo.Employees', N'U') IS NOT NULL
--     DROP TABLE dbo.Employees;

-- Create table

CREATE TABLE dbo.Employees
(
    empid INT not NULL,
    firsname VARCHAR(30) NOT NULL,
    lastname VARCHAR(30) NOT NULL,
    hiredate DATE NOT NULL,
    mgrid INT NULL,
    ssn VARCHAR(20) NOT NULL,
    salary MONEY NOT NULL
);

-- Primary key
ALTER TABLE dbo.Employees
    ADD CONSTRAINT PK_Employees
    PRIMARY KEY(empid);

-- Unique index
ALTER TABLE dbo.Employees
    ADD CONSTRAINT UNQ_Employees_ssn
    UNIQUE(ssn);

-- ALLOW multiple nulls per column for index
CREATE UNIQUE INDEX idx_ssn_notnull ON dbo.Employees(ssn)
    WHERE ssn IS NOT NULL;

-- Foreign Key Constraints
DROP TABLE IF EXISTS dbo.Orders;

CREATE TABLE dbo.Orders
(
    orderid INT NOT NULL,
    empid INT NOT NULL,
    custid VARCHAR(10) NOT NULL,
    orderts DATETIME2 NOT NULL,
    qty INT NOT NULL,
    CONSTRAINT PK_Orders
        PRIMARY KEY(orderid)
);

ALTER TABLE dbo.Orders
    ADD CONSTRAINT FK_Orders_Employees
    FOREIGN KEY(empid)
    REFERENCES dbo.Employees(empid);

ALTER TABLE dbo.Employees
    ADD CONSTRAINT FK_Employees_Employees
    FOREIGN KEY(mgrid)
    REFERENCES dbo.Employees(empid);

-- Check Constraints
ALTER TABLE dbo.Employees
    ADD CONSTRAINT CHK_Employees_salary
    CHECK (salary > 0.00);

-- Default constraint
ALTER TABLE dbo.Orders
    ADD CONSTRAINT DTF_Orders_orderts
    DEFAULT(SYSDATETIME()) FOR orderts;

-- Table info
-- exec sp_help Employees;
-- exec sp_help Orders;

-- Cleanup
DROP TABLE IF EXISTS dbo.Orders;
DROP TABLE IF EXISTS dbo.Employees;

DROP TABLE IF EXISTS dbo.Referencing;
DROP TABLE IF EXISTS dbo.Referenced;
CREATE TABLE dbo.Referenced
(
    id INT NOT NULL,
    name VARCHAR(30) NOT NULL,
    CONSTRAINT PK_Referenced
    PRIMARY KEY(id)
);

CREATE TABLE dbo.Referencing
(
    id INT NOT NULL,
    referencedId INT,
    name VARCHAR(30) NOT NULL,
    CONSTRAINT PK_Referencing
        PRIMARY KEY(id),
    CONSTRAINT FK_Referencing_referencedId
        FOREIGN KEY(referencedId)
        REFERENCES dbo.Referenced(id)
        ON DELETE SET NULL
        ON UPDATE SET DEFAULT
);

INSERT INTO dbo.Referenced
VALUES
    (1, 'referenced1'),
    (2, 'referenced2'),
    (3, 'referenced3'),
    (4, 'referenced4'),
    (5, 'referenced5');

INSERT INTO dbo.Referencing
VALUES
    (1, 1, 'referencing1'),
    (2, 2, 'referencing2'),
    (3, 3, 'referencing3'),
    (4, 4, 'referencing4'),
    (5, 5, 'referencing5');

DELETE FROM dbo.Referenced
WHERE id = 3;

UPDATE dbo.Referenced
SET id = 777 WHERE id = 5;

SELECT *
FROM dbo.Referencing;
SELECT *
FROM dbo.Referenced;

DROP TABLE IF EXISTS dbo.Referencing;
DROP TABLE IF EXISTS dbo.Referenced;