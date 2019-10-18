USE TSQLV4;

-- Catalog views

-- SELECT SCHEMA_NAME(schema_id) AS table_schema_name, name AS table_name
-- FROM sys.tables;

-- SELECT
--     name AS column_name,
--     TYPE_NAME(system_type_id) AS column_type,
--     max_length,
--     collation_name,
--     is_nullable
-- FROM sys.columns
-- WHERE object_id = OBJECT_ID(N'Sales.Orders');

-- Information schema views

-- SELECT TABLE_SCHEMA, TABLE_NAME
-- FROM INFORMATION_SCHEMA.TABLES
-- WHERE TABLE_TYPE = N'BASE TABLE';

-- System stored procedures and functions

-- EXEC sys.sp_tables;
-- EXEC sys.sp_help @objname = N'Sales.Orders';
-- EXEC SYS.sp_columns
--     @table_name = N'Orders',
--     @table_owner = N'Sales';
-- EXEC sys.sp_helpconstraint
--     @objname = N'Sales.Orders';
SELECT SERVERPROPERTY('ProductLevel');
SELECT DATABASEPROPERTYEX(N'TSQLV4', 'Collation');
SELECT OBJECTPROPERTY(OBJECT_ID(N'Sales.Orders'), 'TAbleHasPrimaryKey');
SELECT COLUMNPROPERTY(OBJECT_ID(N'Sales.Orders'), N'shipcountry', 'AllowsNull');