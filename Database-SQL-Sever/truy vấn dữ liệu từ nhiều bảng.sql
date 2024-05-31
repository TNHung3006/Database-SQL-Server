----------------------------------------------
-- ///// Truy vấn dữ liệu từ nhiều bảng  \\\\\
----------------------------------------------

--Từ bảng Products và Categories, hãy in ra các
--thông tin sau đây:
-- Mã thể loại
-- Tên thể loại
-- Mã sản phẩm
-- Tên sản phẩm
SELECT C.[CategoryID], C.[CategoryName], P.[ProductID], P.[ProductName]
FROM dbo.Products AS P, dbo.Categories AS C
WHERE C.[CategoryID] = P.[CategoryID];

-- Từ bảng Employees và Orders, hãy in ra các thông tin sau đây:
-- Mã nhân viên
-- Tên nhân viên
-- Số lượng đơn hàng mà nhân viên đã bán được.

SELECT E.EmployeeID, (E.[FirstName] + ' ' + E.[LastName]) AS "Full Name", COUNT(OrderID) AS "total"
FROM dbo.Employees AS E, dbo.Orders AS O
WHERE E.EmployeeID = O.EmployeeID
GROUP BY  E.EmployeeID, (E.[FirstName] + ' ' + E.[LastName]);

--Từ bảng Customers và Orders, hãy in ra các thông tinsau đây:
--Mã số khách hàng
--Tên công ty
--Tên liên hệ
--Số lượng đơn hàng đã mua
--Với điều kiện: quốc gia của khách hàng là UK

SELECT	C.CustomerID, C.CompanyName, C.ContactName, C.Country, 
		COUNT(O.OrderID) AS "Total"
FROM dbo.Customers AS C, dbo.Orders AS O
WHERE C.[CustomerID]=O.[CustomerID] AND Country = 'UK'
GROUP BY C.CustomerID, C.CompanyName, C.ContactName, C.Country;

-- Từ bảng Orders và Shippers, hãy in ra các thông tin sau đây:
-- Mã nhà vận chuyển
-- Tên công ty vận chuyển
-- Tổng số tiền được vận chuyển(Sum Frieght) của từng công ty(Company Name)
-- Và in ra man hình theo thứ tự sap xếp tong so tien van chuyen giảm dần.
-- ShipperID được kết nối thông qua ShipVia
SELECT S.[ShipperID], S.[CompanyName], SUM(O.Freight) AS "Total"
FROM dbo.Orders AS O, dbo.Shippers AS S
WHERE S.[ShipperID] = O.ShipVia
GROUP BY S.[ShipperID], S.[CompanyName]
ORDER BY SUM(O.Freight) DESC;

--Từ bảng Products và Suppliers, hãy in ra các thông tinsau đây:
--Mã nhà cung cấp
--Tên công ty
--Số lượng các sản phẩm khác nhau đã cung cấp
--Và chỉ in ra màn hình duy nhất 1 nhà cung cấp có số lượng sản phẩm khác nhau nhiều nhất.
SELECT DISTINCT TOP 1 S.[SupplierID], S.[CompanyName], COUNT(P.[ProductID]) AS "Total"
FROM dbo.Products AS P, dbo.Suppliers AS S
WHERE P.[SupplierID] = S.[SupplierID]
GROUP BY S.[SupplierID], S.[CompanyName]
ORDER BY COUNT(P.[ProductID]) DESC;

--Từ bảng Orders và Orders Details, hãy in ra các thông tin sau đây:
--Mã đơn hàng
--Mã khách hàng
--Tổng số tiền sản phẩm (bằng tiền sản phẩm nhân cho số lượng ) của đơn hàng đó
--tổng tiền sản phẩm phải lớn hơn 2000$
--sắp xếp tổng tiền sản phẩm từ thấp đến cao
SELECT O.[CustomerID], O.[OrderID], SUM(OD.UnitPrice*OD.Quantity) AS "SUM Price"
FROM dbo.[Order Details] AS OD, dbo.Orders AS O
WHERE O.[OrderID] = OD.[OrderID]
GROUP BY O.[OrderID], O.[CustomerID]
HAVING SUM(OD.UnitPrice*OD.Quantity) > 2000
ORDER BY SUM(OD.UnitPrice*OD.Quantity) ASC;

--Từ 3 bảng Order Details, Employees, Orders  hãy in ra các thông tin sau đây:
--Mã đơn hàng
--Tên nhân viên
--Tổng số tiền sản phẩm của đơn hàng đó
SELECT	O.[OrderID], (E.[FirstName] + ' ' + E.[LastName]) AS "Full Name", 
		SUM(OD.UnitPrice*OD.Quantity) AS "SUM Price"
FROM dbo.[Order Details] AS OD, dbo.Employees AS E, dbo.Orders AS O
WHERE OD.[OrderID] = O.[OrderID] AND O.[EmployeeID] = E.[EmployeeID]
GROUP BY O.[OrderID], (E.[FirstName] + ' ' + E.[LastName]);

--Từ 3 bảng Orders, Customers, Shippers hãy in ra các thông tin sau đây:
--Mã đơn hàng
--Tên khách hàng
--Tên công ty vận chuyển
--Và chỉ in ra các đơn hàng được giao đến 'UK' trong năm 1997
SELECT O.[OrderID], C.[ContactName], S.[CompanyName], O.[ShipCountry]
FROM dbo.Orders AS O, dbo.Customers AS C, dbo.Shippers AS S
WHERE	O.[CustomerID] = C.[CustomerID] AND O.[ShipVia] = S.[ShipperID] 
		AND O.ShipCountry = 'UK';

--Từ bảng Products và Categories, hãy tìm các sản phẩm thuộc danh mục(CategoryName) 'Seafood'
--in ra các thông tin sau đây:
--Mã thể loại
--Tên thể loại
--Mã sản phẩm
--Tên sản phẩm
SELECT C.[CategoryID], C.[CategoryName], P.[ProductID], P.[ProductName]
FROM dbo.Products AS P, dbo.Categories AS C
WHERE C.[CategoryID] = P.[CategoryID] AND [CategoryName] = 'Seafood';

--Từ bảng Products và Suppliers, hãy tìm các sản phẩm
--thuộc được cung cấp từ nước 'Germany' (Đức) :
--Mã nhà cung cấp
--Quốc gia
--Mã sản phẩm
--Tên sản phẩm
SELECT S.[SupplierID], S.[Country], P.[ProductID], P.[ProductName]
FROM dbo.Products AS P, dbo.Suppliers AS S
WHERE P.[SupplierID] = S.[SupplierID] AND S.Country = 'Germany';

--Từ 3 bảng Orders, Customers, Shippers hãy in ra các thông tin sau đây:
--Mã đơn hàng
--Tên khách hàng
--Tên công ty vận chuyển
--Và chỉ in ra các đơn hàng của các khách hang đen từ thành phố 'London'
SELECT O.[OrderID], C.[ContactName], S.[CompanyName], O.[ShipCity]
FROM dbo.Orders AS O, dbo.Customers AS C, dbo.Shippers AS S
WHERE	O.[CustomerID] = C.[CustomerID] AND O.[ShipVia] = S.[ShipperID]
		AND ShipCity = 'London';

--Từ 3 bảng Orders, Customers, Shippers hãy in ra các thông tin sau đây:
--Mã đơn hàng
--tên liên lạc 
--Tên công ty vận chuyển
--Ngày yêu cầu giao hàng
--Ngày giao hàng
--Và chỉ in ra các đơn hàng bị giao muộn hơn quy định.
--RequiredDate < ShippedDate
SELECT O.[OrderID], C.[ContactName], S.[CompanyName], O.[RequiredDate], O.[ShippedDate]
FROM dbo.Orders AS O, dbo.Customers AS C, dbo.Shippers AS S
WHERE	O.[CustomerID] = C.[CustomerID] AND O.[ShipVia] = S.[ShipperID]
		AND RequiredDate < ShippedDate;

-- Give these shipcountries for which customers
-- don't come from the United States.
-- Select only this countries which is over than 100 orders.
-- Display Shipcountry and Number of orders