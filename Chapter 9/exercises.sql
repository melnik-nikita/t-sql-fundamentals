USE TSQLV4;

-- Ex1
CREATE TABLE dbo.Departments
(
    deptid INT NOT NULL CONSTRAINT PK_Departments PRIMARY KEY NONCLUSTERED,
    deptname VARCHAR(25) NOT NULL,
    mgrid INT NOT NULL,
    validfrom DATETIME2(0) GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
    validto DATETIME2(0) GENERATED ALWAYS AS ROW END HIDDEN NOT NULL,
    PERIOD FOR SYSTEM_TIME (validfrom, validto)
)
    WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.DepartmentsHistory));

-- Ex2
INSERT INTO dbo.Departments
    (deptid, deptname, mgrid)
VALUES(1, 'HR', 7),
    (2, 'IT', 5),
    (3, 'Sales', 11),
    (4, 'Marketing', 13);

BEGIN TRAN

UPDATE dbo.Departments
SET deptname = 'Sales and Marketing'
WHERE deptid = 3;

DELETE FROM dbo.Departments
WHERE deptid = 4;

COMMIT TRAN;

SELECT deptid, deptname, mgrid, validfrom, validto
FROM dbo.Departments;

SELECT deptid, deptname, mgrid, validfrom, validto
FROM dbo.DepartmentsHistory;
-- Ex3-2
SELECT deptid, deptname, mgrid, validfrom, validto
FROM dbo.Departments FOR SYSTEM_TIME FROM '2019-10-10 12:04:28' TO '2019-10-10 12:08:39';
-- Ex3-3
SELECT deptid, deptname, mgrid, validfrom, validto
FROM dbo.Departments FOR SYSTEM_TIME BETWEEN '2019-10-10 12:04:28' AND '2019-10-10 12:08:39';

-- Ex4
ALTER TABLE dbo.Departments SET (SYSTEM_VERSIONING = OFF);
DROP TABLE dbo.DepartmentsHistory, dbo.Departments;