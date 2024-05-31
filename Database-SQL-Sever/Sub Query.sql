------------------------------------------------------------
-- ////// Giới thiệu về SUB QUERY \\\\\\

--Subquery (câu truy van con) trong SQL là một truy van
--SELECT được viết bên trong một truy van SELECT,
--UPDATE, INSERT, hoặc DELETE khác.
--Subquery hoạt động như một bảng ảo tạm thời, nó được sử
--dụng để trích xuất thông tin từ các bảng hoặc tập dữ liệu khác
--trong cùng một câu truy vấn.
------------------------------------------------------------

--Tim gia trung binh cua cac san pham
SELECT AVG([UnitPrice]) -- avg = 28,4962
FROM [dbo].[Products]; 

--Loc nhung san pham co gia > gia trung binh
SELECT ProductID, ProductName, UnitPrice
FROM dbo.Products
WHERE UnitPrice > 28.4962; -- nếu dùng cách này khi giá trị trung bình thay đổi thì sẽ sai

-- (SUB QUERY)
SELECT ProductID, ProductName, UnitPrice
FROM dbo.Products
WHERE UnitPrice > (
		SELECT AVG([UnitPrice]) AS "total"
		FROM [dbo].[Products]
);

--Lọc ra những khách hàng có số đơn hàng lớn hơn 10 và sắp xếp số đơn hàng từ cao đến thấp.
SELECT C.CustomerID, C.[ContactName], COUNT(O.[OrderID]) AS "TOTAL"
FROM dbo.Customers AS C, dbo.Orders AS O
WHERE C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.[ContactName]
HAVING COUNT(O.[OrderID]) > 10
ORDER BY TOTAL DESC;

SELECT c.CustomerID, c.CompanyName, count(o.OrderId) as [TotalOrders]
FROM [dbo].[Customers] c
LEFT JOIN [dbo]. [Orders] o
ON c.CustomerID = o.CustomerID
GROUP BY c. CustomerID, c. CompanyName
HAVING count(o.OrderId) > 10
ORDER BY TotalOrders DESC;

-- SUB QUERY
-- Cách 1
SELECT *
FROM dbo.Customers 
WHERE [CustomerID] IN (
		SELECT  [CustomerID]
		FROM dbo.Orders
		GROUP BY [CustomerID]
		HAVING COUNT([OrderID]) > 10
);
-- Cách 2
SELECT *, (
		SELECT COUNT([OrderID])
		FROM dbo.Orders o
		WHERE o.CustomerID = c.CustomerID
		HAVING COUNT([OrderID]) > 10
	) AS "Total"
FROM dbo.Customers c
WHERE (
		SELECT COUNT([OrderID])
		FROM dbo.Orders o
		WHERE o.CustomerID = c.CustomerID
		HAVING COUNT([OrderID]) > 10
	) IS NOT NULL
ORDER BY Total DESC;


-- Tinh tong tien cho tung don hang (nhưng trong bảng oder không có cột đơn giá)
--gợi ý: kiếm cột có đơn giá liên quan đến order(Order Details)
SELECT O.*, (
		SELECT SUM(od.Quantity * od.UnitPrice)
		FROM dbo.[Order Details] od
		WHERE od.OrderID = O.OrderID
	) AS "total"
FROM dbo.Orders O;

-- Loc ra ten san pham va tong so don hang cua san pham
SELECT P.ProductID, p.ProductName, COUNT(od.OrderID) AS "total"
FROM dbo.Products as p, dbo.[Order Details] as od
WHERE p.ProductID = od.[ProductID]
GROUP BY P.ProductID, p.ProductName;

-- SUB QUERY
SELECT p.ProductID, p. ProductName, (
		SELECT COUNT(*)
		FROM [dbo].[Order Details] od
		WHERE od.ProductID = p.ProductID
	) as [TotalOrders]
FROM [dbo].[Products] p;

-- đặt trong from
SELECT ProductName, TotalOrders
FROM
		(SELECT p.ProductID, p.ProductName,(
		SELECT COUNT(*)
		FROM [dbo].[Order Details] od
		WHERE od.ProductID = p.ProductID
	) as [TotalOrders]
FROM [dbo].[Products] p) AS Temp;

-- Bạn hãy in ra Mã đơn hàng, và số lượng sản phẩm của đơn hàng đó.
SELECT o.OrderID, COUNT(od.ProductID) as "Quantity"
FROM dbo.Orders AS o, dbo.[Order Details] AS od
WHERE o.OrderID = od.OrderID
GROUP BY o.OrderID;

-- SUB QUERY
SELECT OrderID, (
		SELECT COUNT(ProductID)
		FROM dbo.[Order Details] od
		WHERE o.OrderID = od.OrderID
	) AS  "total"
FROM dbo.Orders o;

--@@@@@@@@@@@@@@@@@@ BÀI TẬP @@@@@@@@@@@@@@@@@@@

--VD liệt kê các đơn hàng có ngày đặt hàng gần đây nhất 
SELECT *
FROM dbo.Orders
WHERE OrderDate = (
		SELECT Max([OrderDate])
		FROM dbo.Orders
	);

--Liệt kê tất ca cac sản phẩm (ProductName)
--mà không có đơn đặt hàng nào đặt mua chúng.
SELECT *
FROM dbo.Products
WHERE ProductID NOT IN(
		SELECT ProductID
		FROM dbo.[Order Details] od
);

--Lấy thông tin về các đơn hàng, và tên các sản phẩm
--thuộc các đơn hàng chưa được giao cho khách (ngày giao hàng chưa tồn tại(null)).
SELECT o.OrderID, p.ProductName
FROM dbo.Orders o
INNER JOIN dbo.[Order Details] od
ON od.OrderID = o.OrderID
INNER JOIN dbo.Products p
ON p.ProductID = od.ProductID
WHERE o.OrderID IN (
		SELECT o.OrderID 
		FROM dbo.Orders o
		WHERE o.[ShippedDate] IS NULL
);

--Lấy thong tin ve cac san pham có số lượng tồn kho (UnitsInStock)
--ít hơn số lượng tồn kho trung bình của tất cả các sản phẩm
SELECT *
FROM dbo.Products
WHERE UnitsInStock < (
		SELECT AVG([UnitsInStock])
		FROM dbo.Products
);
--lấy thông tin về khách hàng có tổng giá trị đơn hàng lớn nhất
SELECT od.OrderID, c.[CustomerID], c.[ContactName]
FROM dbo.[Order Details] od
INNER JOIN dbo.Orders o
ON od.OrderID = o.OrderID
INNER JOIN dbo.Customers c
ON o.CustomerID = c.CustomerID
WHERE (od.Quantity*od.UnitPrice) IN (
		SELECT MAX(od.Quantity*od.UnitPrice)
		FROM dbo.[Order Details] od
);