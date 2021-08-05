USE Northwind

--  1.1 Write a query that lists all Customers in either Paris or London. 
--  Include Customer ID, Company Name and all address fields
SELECT CustomerID, CompanyName, Address, City, Region, PostalCode, Country
FROM Customers
WHERE City IN ('Paris', 'London')

--  1.2 List all products stored in bottles.
SELECT p.ProductName, p.QuantityPerUnit
FROM Products p
WHERE p.QuantityPerUnit LIKE '%bottles%'

--  1.3 Repeat question above, but add in the Supplier Name and Country.
SELECT p.ProductName, p.QuantityPerUnit, s.CompanyName, s.Country
FROM Products p
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE p.QuantityPerUnit LIKE '%bottles%' OR p.QuantityPerUnit LIKE '%bottle%'

/*  1.4 Write an SQL Statement that shows how many products there are 
    in each category. Include Category Name in result set and list the 
    highest number first.*/
SELECT p.CategoryID,
SUM(p.CategoryID) AS NumProductsInEachCategory
FROM Products p
GROUP BY p.CategoryID

/*  1.5 List all UK employees using concatenation to join their title 
    of courtesy, first name and last name together. Also include their 
    city of residence. */
SELECT CONCAT(e.TitleOfCourtesy, ' ',e.FirstName, ' ', e.LastName, ',', e.City) AS "Employee"
FROM Employees e
WHERE Country = 'UK'

/*  1.6 List Sales Totals for all Sales Regions (via the Territories table using 
    4 joins) with a Sales Total greater than 1,000,000. Use rounding or FORMAT 
    to present the numbers.*/
SELECT t.RegionID,
FORMAT(SUM(od.UnitPrice*od.Quantity*(1-Discount)),'C', 'en-gb') AS "SalesTotal"
FROM Territories t
INNER JOIN EmployeeTerritories et ON et.TerritoryID = t.TerritoryID
INNER JOIN Employees e ON et.EmployeeID = e.EmployeeID
INNER JOIN Orders o ON e.EmployeeID = o.EmployeeID
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY t.RegionID
HAVING SUM(od.UnitPrice*od.Quantity*(1-Discount)) > 1000000
ORDER BY 1 ASC

SELECT * FROM Employees

/*  1.7 Count how many Orders have a Freight amount greater than 100.00 
    and either USA or UK as Ship Country. */
SELECT COUNT(o.OrderID) AS "UsaOrUkFreight>100"
FROM Orders o
WHERE Freight>100.00
AND o.ShipCountry IN ('USA', 'UK')

/*  1.8 Write an SQL Statement to identify the Order Number of the Order 
    with the highest amount(value) of discount applied to that order.*/
--  TODO: Test when servers are up.
SELECT OrderID,
FORMAT("DiscountValue", 'C') AS "DiscountAmount"
FROM (
    SELECT TOP 10 od.OrderID, 
    SUM(od.UnitPrice*od.Quantity*od.Discount) AS "DiscountValue"
    FROM [Order Details] od
    GROUP BY od.OrderID
    ORDER BY 2 DESC
    ) AS "DiscountTable"