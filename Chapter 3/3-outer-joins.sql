use TSQLV4;

-- Outer join example
-- SELECT C.custid, C.companyname, O.orderid
-- FROM Sales.Customers AS C
-- LEFT OUTER JOIN Sales.Orders AS O
--     ON C.custid = O.custid;

-- Customers without any orders
SELECT C.custid, C.companyname, O.orderid
FROM Sales.Customers AS C
    LEFT OUTER JOIN Sales.Orders AS O
    ON C.custid = O.custid
WHERE O.custid IS NULL;