USE Northwind

-- Write SQL statements to extract the data required for the following charts (create these in Excel): 

/*  3.1 List all Employees from the Employees table and who they report to. 
    No Excel required. Please mention the Employee Names and the ReportTo names.  */

SELECT CONCAT(e.FirstName, ' ', e.LastName) AS "EmployeeName", 
(SELECT CONCAT(e2.FirstName, ' ', e2.LastName) FROM Employees e2
WHERE e2.EmployeeID = e.ReportsTo) AS "ReportsTo"
FROM Employees e

--Connor Solution LEFT JOIN method
SELECT CONCAT(e.FirstName, ' ', e.LastName) AS "Employee Name",
    CONCAT(e2.FirstName, ' ', e2.LastName) AS "Reports To"
FROM Employees e
LEFT JOIN Employees e2
ON e.ReportsTo = e2.EmployeeID;

/*  3.2 List all Suppliers with total sales over $10,000 in the Order Details table. Include the 
    Company Name from the Suppliers Table and present as a bar chart.  */

SELECT s.CompanyName,
SUM(od.Quantity*od.UnitPrice) AS "totalSales"
FROM [Order Details] od
INNER JOIN Products p ON od.ProductID = p.ProductID
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID
GROUP BY s.CompanyName
HAVING SUM(od.Quantity*od.UnitPrice) > 10000
ORDER BY totalSales

/*  3.3 List the Top 10 Customers YTD for the latest year in the Orders file. Based on total 
    value of orders shipped. */

--  The Order by statement order priority matters.
SELECT TOP 10 c.CompanyName, o.OrderDate, 
FORMAT(SUM(od.Quantity*od.UnitPrice*(1-od.Discount)), 'C') AS "OrderValue"
FROM Orders o 
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate)=(SELECT MAX(YEAR(orderDate)) FROM Orders)
GROUP BY c.CompanyName, o.OrderDate
ORDER BY SUM(od.Quantity*od.UnitPrice*(1-od.Discount)) DESC

-- Astha Solution
SELECT TOP 10 o.CustomerID ,FORMAT(SUM(od.Quantity*od.UnitPrice*(1-od.Discount)), 'C') AS "TotalValueOfOrdersShipped"
FROM [Order Details] od INNER JOIN Orders o 
ON o.OrderID=od.OrderID
WHERE YEAR(o.OrderDate)=(SELECT MAX(YEAR(o1.OrderDate)) FROM Orders o1)
AND o.ShippedDate IS NOT NULL
GROUP BY o.CustomerID
ORDER BY SUM(od.Quantity*od.UnitPrice*(1-od.Discount)) DESC

/*  3.4 Plot the Average Ship Time by month for all data in the Orders Table using a line 
    chart. */

SELECT FORMAT("Date",'MM/yyyy') AS "Month/Year",
AVG("ShipTime") AS "AverageShipTimeByMonth"
FROM (
    SELECT o.OrderDate AS "Date", 
    MONTH(o.OrderDate) AS "Month", 
    YEAR(o.OrderDate) AS "Year",
    DATEDIFF(DAY, o.OrderDate, o.ShippedDate) AS "ShipTime" 
FROM Orders o) AS "ShipTimes"
GROUP BY FORMAT("Date",'MM/yyyy'), "Month", "Year"
ORDER BY "Year" ASC, "Month" ASC