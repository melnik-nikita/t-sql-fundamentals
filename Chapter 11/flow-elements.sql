USE TSQLV4;

-- IF...ELSE
IF YEAR(SYSDATETIME()) <> YEAR(DATEADD(day, 1, SYSDATETIME()))
BEGIN
    PRINT 'Today is the last day of the year';
END;
ELSE
    PRINT 'Today is not the last day of the year';

-- WHILE
DECLARE @i AS INT = 1;
WHILE @i <= 10
BEGIN
    PRINT @i;
    SET @i +=1;
END;