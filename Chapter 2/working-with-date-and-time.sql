USE TSQLV4;

-- SELECT orderid, custid, empid, orderdate
-- FROM Sales.Orders
-- WHERE orderdate = '20160112';

-- SELECT orderid, custid, empid, orderdate
-- FROM Sales.Orders
-- WHERE orderdate = CAST('20160112' AS DATE);

-- SET LANGUAGE British;
-- SELECT CAST('02/12/2016' AS DATE);

-- SET LANGUAGE us_english;
-- SELECT CAST('02/12/2016' AS DATE);

-- Working with Date and Time separately

-- DROP TABLE IF EXISTS Sales.Orders2;
-- SELECT orderid, custid, empid, CAST(orderdate AS DATETIME) AS orderdate
-- INTO Sales.Orders2
-- FROM Sales.Orders;

-- ALTER TABLE Sales.Orders2
--     ADD CONSTRAINT CHK_Orders2_orderdate
--     CHECK(CONVERT(char(12), orderdate, 114) = '00:00:00:000');

-- SELECT *
-- FROM Sales.Orders2;

-- DROP TABLE IF EXISTS Sales.Orders2;

-- Date And Time functions

SELECT
    GETDATE() AS [GETDATE],
    CURRENT_TIMESTAMP AS  [CURRENT_TIMESTAMP],
    GETUTCDATE() as [GETUTCDATE],
    SYSDATETIME() as [SYSDATETIME],
    SYSUTCDATETIME() as [SYSUTCDATETIME],
    SYSDATETIMEOFFSET() as [SYSDATETIMEOFFSET];

SELECT
    CAST(SYSDATETIME() AS DATE) AS [current_date],
    CAST(SYSDATETIME() AS TIME) AS [current_time];

SELECT CAST('20160212' AS DATE);

SELECT CAST(SYSDATETIME() AS DATE);

SELECT CAST(SYSDATETIME() AS TIME);

SELECT CONVERT(CHAR(8), CURRENT_TIMESTAMP, 112);

-- To zero the time portion of a date
SELECT CONVERT(DATETIME, CONVERT(CHAR(8), CURRENT_TIMESTAMP, 112), 112) AS datetime_time_zeroed;
-- To zero the date portion to base date
SELECT CONVERT(DATETIME, CONVERT(CHAR(12), CURRENT_TIMESTAMP, 114), 114) AS datetime_date_zeroed;
-- PARSE function examples
SELECT PARSE('02/12/2016' AS DATETIME USING 'en-US') AS datetime_us;
SELECT PARSE('02/12/2016' AS DATETIME USING 'en-GB') AS datetime_gb;

SELECT SYSDATETIMEOFFSET() as datetime_offset;

-- SELECT name, current_utc_offset, is_currently_dst
-- FROM sys.time_zone_info;

SELECT DATENAME(month, '20160212')

-- Using EOMONTH funciton, returns a date of the last date of the month
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE orderdate = EOMONTH(orderdate);

