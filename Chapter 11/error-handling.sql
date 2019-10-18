USE TSQLV4;

DROP TABLE IF EXISTS dbo.Employees;
CREATE TABLE dbo.Employees
(
    empid INT NOT NULL,
    empname VARCHAR(25) NOT NULL,
    mgrid INT NULL,
    CONSTRAINT PK_Employees PRIMARY KEY(empid),
    CONSTRAINT CHK_Employees_empid CHECK(empid > 0),
    CONSTRAINT FK_Employees_Employees
FOREIGN KEY(mgrid) REFERENCES dbo.Employees(empid)
);

BEGIN TRY 
    INSERT INTO dbo.Employees
    (empid, empname, mgrid)
VALUES(1, 'Emp1', NULL)
END TRY
BEGIN CATCH
    IF ERROR_NUMBER() = 2627
    BEGIN
    PRINT '     Handling PK violation...';
END;
    ELSE IF ERROR_NUMBER() = 547
    BEGIN
    PRINT '     Handling CHECK/FK constraing violation...';
END;
ELSE IF ERROR_NUMBER() = 515
    BEGIN
    PRINT '     Handling NULL violation...';
END;
ELSE IF ERROR_NUMBER() = 245
    BEGIN
    PRINT '     Handling conversion error...';
END;
ELSE 
BEGIN
    PRINT 'Re-throwing error...';
    THROW;
END;

PRINT '     Error Number  : ' + CAST(ERROR_NUMBER() AS VARCHAR(10));
PRINT '     Error Message : ' + ERROR_MESSAGE();
PRINT '     Error Severity: ' + CAST(ERROR_SEVERITY() AS VARCHAR(10));
PRINT '     Error State   : ' + CAST(ERROR_STATE() AS VARCHAR(10));
PRINT '     Error Line    : ' + CAST(ERROR_LINE() AS VARCHAR(10));
PRINT '     Error Proc    : ' + COALESCE(ERROR_PROCEDURE(), 'Not within proc');
END CATCH;