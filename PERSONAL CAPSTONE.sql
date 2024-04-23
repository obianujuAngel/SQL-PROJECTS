CREATE DATABASE SALES
--1  List all suppliers in the UK
SELECT *
FROM [dbo].[Supplier]
WHERE [Country]='UK'

--2  List the first name, last name, and city for all customers. Concatenate the first
--and last name separated by a space and a comma as a single column
SELECT CONCAT([FirstName],' ,',[LastName]) AS FullName,
[City]
FROM[dbo].[Customer]

--3  List all customers in Sweden
SELECT *
FROM[dbo].[Customer]
WHERE [Country]='Sweden'
--4  List all suppliers in alphabetical order
SELECT*
FROM [dbo].[Supplier]
ORDER BY[CompanyName]
--5 List all orders with customers information
SELECT [FirstName],[LastName],[City],[Country],[Phone]
		[Id],[OrderDate],[OrderNumber]
FROM[dbo].[Customer] AS C
INNER JOIN[dbo].[Order] AS O
ON C.Id=O.Id
--6. List all orders with product name, quantity, and price, sorted by order number
SELECT	 [dbo].[Order].[OrderNumber],[dbo].[Order].[OrderDate],[dbo].[Order].[Id],
		 [dbo].[Product].[ProductName],
		 [dbo].[OrderItem].[Quantity],[dbo].[OrderItem].[UnitPrice]
FROM[dbo].[Order]
INNER JOIN [dbo].[Product] ON [dbo].[Order].[Id]=[dbo].[Product].[Id]
INNER JOIN [dbo].[OrderItem] ON[dbo].[Order].[Id]=[dbo].[OrderItem].[Id]
ORDER BY[dbo].[Order].[OrderNumber]
--7 Using a case statement, list all the availability of products. When 0 then not
--available, else available
 SELECT		[dbo].[Product].Id,[dbo].[Product].ProductName,
		    [dbo].[OrderItem].[Quantity],
CASE
	WHEN [Quantity]=0 THEN 'Not available'
	ELSE 'Available' END AS Availability
FROM [dbo].[Product]
LEFT JOIN[dbo].[OrderItem]
ON[dbo].[Product].[Id]=[dbo].[OrderItem].[Id]
--8  List all products that are packaged in Bottles
SELECT *
FROM[dbo].[Product]
WHERE [Package]LIKE '%Bottles%';
--9  List procucts name, unitprice and packages for products that starts with G
SELECT [ProductName],[UnitPrice],[Package]
FROM[dbo].[Product]
WHERE [ProductName] LIKE 'G%';
--10  List the number of products for each supplier, sorted high to low
SELECT COUNT([dbo].[Product].Id) AS Number_of_Product,
       [dbo].[Supplier].[Id],[dbo].[Supplier].[CompanyName]
FROM [dbo].[Supplier]
LEFT JOIN [dbo].[Product] ON [dbo].[Supplier].Id=[dbo].[Product].Id
GROUP BY[dbo].[Supplier].[CompanyName],[dbo].[Supplier].Id
ORDER BY Number_of_Product DESC;
--11  List the number of customers in each country, sorted low to high.
SELECT[dbo].[Customer].[Country], COUNT([dbo].[Customer].[Id]) AS Number_of_Customer
FROM [dbo].[Customer]
GROUP BY [Country]
ORDER BY Number_of_Customer DESC;
--12  List the total order amount for each customer, sorted high to low.
SELECT[CustomerId], SUM([TotalAmount])AS Total_Order_Amount
FROM [dbo].[Order]
GROUP BY[CustomerId]
ORDER BY Total_Order_Amount DESC;
--13  List all countries with more than 3 suppliers
SELECT COUNT([Id]) AS Number_of_Supplier,[Country]
FROM[dbo].[Supplier]
GROUP BY[Country]
HAVING COUNT ([Id])>3
--14 List the number of customers in each country. Only include countries with more
--than 7 customers.
SELECT [Country], COUNT([Id]) AS Number_of_Customers
FROM [dbo].[Customer]
GROUP BY[Country]
HAVING COUNT([Country])>7
--15  List the number of customers in each country, except the Germany, sorted high
--to low. Only include countries with 9 or more customers
SELECT [Country], COUNT ([Id]) AS Number_of_Customers
FROM[dbo].[Customer]
WHERE[Country]<> 'Germany'
GROUP BY[Country]
HAVING COUNT([Country])>=9
ORDER BY Number_of_Customers DESC;
--16  List customer with average orders between $1000 and $1200.
SELECT [CustomerId], AVG([TotalAmount]) AS Average_Orders
FROM[dbo].[Order]
GROUP BY[CustomerId]
HAVING AVG([TotalAmount]) BETWEEN 1000 AND 2000
--17  Get the number of orders and total amount sold between Jan 1, 2013 and Dec
--31, 2013
SELECT COUNT([Id]) AS Number_of_Orders, SUM([TotalAmount]) AS Total_AmountSold
FROM[dbo].[Order]
WHERE[OrderDate] BETWEEN '1/1/2013' AND '12/31/2013'