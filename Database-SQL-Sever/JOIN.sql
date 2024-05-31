------------------------------------------------------------
-- //////  INNER JOIN  \\\\\\

--SELECT column_name(s)
--FROM table1
--INNER JOIN table2
--ON table1.column_name = table2.column_name;

--Trả về tất cả các hàng khi có ít nhất một giá trị ở cả hai bảng
------------------------------------------------------------

-- VD Sử dụng INNER JOIN
-- Từ bảng Products và Categories, hãy in ra các thông tin sau đây:
-- Mã thể loại
-- Tên thể loại
-- Mã sản phẩm
-- Tên sản phẩm
SELECT P.[ProductID], P.[ProductName], C.[CategoryID], C.[CategoryName]
FROM dbo.Categories C
INNER JOIN dbo.Products P
ON C.[CategoryID] = P.[CategoryID];

--VD Sử dụng INNER JOIN
-- Từ bảng Products và Categories, hãy đưa ra các thông tin sau đây:
-- Mã thể loại
-- Tên thể loại
-- Số lượng sản phẩm
SELECT c.CategoryID, c.CategoryName, COUNT(p.ProductID) AS "total"
FROM [dbo]. [Categories] c
INNER JOIN dbo.Products AS p
ON c.CategoryID = p.[CategoryID]
GROUP BY c.CategoryID, c.CategoryName;

-- Sử dụng INNET JOIN, hãy in ra các thông tin sau đây:
-- Mã đơn hàng ORDER
-- Tên công ty khách hàng CUSTOMER
SELECT o.OrderID
FROM dbo.Orders o
INNER JOIN dbo.Customers c
ON o.CustomerID = c.CustomerID;

------------------------------------------------------------
-- //////  LEFT JOIN  \\\\\\

--SELECT column_name(s)
--FROM table1
--LEFT JOIN table2
--ON table1.column_name = table2.column_name;

--Trả lại tất cả các dòng từ bảng bên trái, và các dòng đúng với điều kiện
--từ bảng bên phải
------------------------------------------------------------

-- Sử dng INNER JOIN, LEFT JOIN
-- Từ bảng Products và Categories, hãy đưa ra các thông tin sau đây:
-- Mã thể loại
-- Tên thể loại
-- Tên sản phẩm
SELECT c.CategoryID, c.CategoryName,P.CategoryID, p.ProductID, p.ProductName
FROM [dbo].[Categories] c
INNER JOIN [dbo]. [Products] p
ON c.CategoryID = p.CategoryID

SELECT c.CategoryID, c.CategoryName,P.CategoryID, p.ProductID, p.ProductName
FROM [dbo].[Categories] c
LEFT JOIN [dbo]. [Products] p
ON c.CategoryID = p.CategoryID

SELECT c.CategoryID, c.CategoryName,P.CategoryID, COUNT(p.ProductID)
FROM [dbo].[Categories] c 
INNER JOIN [dbo]. [Products] p -- lấy phần chung
ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryID, c.CategoryName, P.CategoryID;

SELECT c.CategoryID, c.CategoryName,P.CategoryID, COUNT(p.ProductID)
FROM [dbo].[Categories] c 
LEFT JOIN [dbo]. [Products] p -- lấy phần chung và lấy luôn cả phần trong table1 có mà table2 không có
ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryID, c.CategoryName, P.CategoryID;

------------------------------------------------------------
-- //////  RIGHT JOIN  \\\\\\

--SELECT column_name(s)
--FROM table1
--RIGHT JOIN table2
--ON table1.column_name = table2.column_name;

--Trả lại tất cả các dòng từ bảng bên trái, và các dòng đúng với điều kiện
--từ bảng bên phải
------------------------------------------------------------

-- Sử dụng RIGHT JOIN, hãy in ra các thông tin sau đây:
-- Mã đơn hàng
-- Tên công ty khách hàng
SELECT o.OrderID, c.CompanyName
FROM [dbo]. [Orders] o
INNER JOIN [dbo]. [Customers] c
ON o.CustomerID = c.CustomerID;

SELECT o.OrderID, c.CompanyName
FROM [dbo]. [Orders] o
RIGHT JOIN [dbo]. [Customers] c
ON o.CustomerID = c.CustomerID;

SELECT c.CompanyName, COUNT(o.OrderID) AS "TOTAL"
FROM [dbo]. [Orders] o
INNER JOIN [dbo]. [Customers] c -- lấy phần chung
ON o.CustomerID = c.CustomerID
GROUP BY c.CompanyName;

SELECT c.CompanyName, COUNT(o.OrderID) AS "TOTAL"
FROM [dbo]. [Orders] o
RIGHT JOIN [dbo]. [Customers] c -- lấy phần chung và lấy luôn cả phần trong table2 có mà table1 không có
ON o.CustomerID = c.CustomerID
GROUP BY c.CompanyName;

------------------------------------------------------------
-- ////// FULL OUTER JOIN \\\\\\

--SELECT column_name(s)
--FROM table1
--FULL JOIN table2
--ON table1.column_name = table2.column_name
--WHERE condition;

--Trả về tất cả các dòng đúng với 1 trong các bảng.
------------------------------------------------------------

-- Sử dụng FULL OUTER JOIN
-- Từ bảng Products và Categories, hãy in ra các thông tin sau đây:
-- Mã thể loại
-- Tên thể loại
-- Mã sản phẩm
-- Tên sản phẩm
SELECT c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
FROM [dbo].[Categories] c
INNER JOIN [dbo]. [Products] p
ON c.CategoryID = p.CategoryID;

SELECT c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
FROM [dbo].[Categories] c
LEFT JOIN [dbo]. [Products] p
ON c.CategoryID = p.CategoryID;

SELECT c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
FROM [dbo].[Categories] c
RIGHT JOIN [dbo]. [Products] p
ON c.CategoryID = p.CategoryID;

SELECT c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
FROM [dbo].[Categories] c
FULL JOIN [dbo]. [Products] p
ON c.CategoryID = p.CategoryID;

--@@@@@@@@@@@@@@@ Bài TẬP @@@@@@@@@@@@@@@

--Câu hỏi 1 (INNER JOIN): Hãy liệt kê MÃ ĐƠN HÀNG và tên khách hàng của các
--đơn hàng trong bảng "Orders".
SELECT O.[OrderID], O.[CustomerID], C.[CompanyName]
FROM dbo.Orders AS O
INNER JOIN dbo.Customers C
ON O.CustomerID = C.CustomerID;

--Câu hỏi 2 (LEFT JOIN): Hãy liệt kê tên nhà cung cấp và tên sản phẩm của các
--sản phẩm trong bảng "Products", bao gồm cả các sản phẩm không có nhà cung cấp
SELECT s.SupplierID, p.ProductName, p.SupplierID
FROM dbo.Products p
LEFT JOIN dbo.Suppliers s
ON p.SupplierID = s.SupplierID;

--Câu hỏi 3 (RIGHT JOIN): Hãy liệt kê mã khách hàng và mã đơn hàng của các
--đơn hàng trong bảng "Orders", bao gồm cả các khách hàng không có đơn hàng.
SELECT o.OrderID, o.CustomerID, c.CustomerID
FROM dbo.Orders o
RIGHT JOIN dbo.Customers c
ON o.CustomerID = c.CustomerID

--Câu hỏi 4 (FULL JOIN): Hãy liệt kê tên sản phẩm và tên nhà cung cấp của các
--sản phẩm trong bảng "Products", bao gồm cả các danh mục và nhà cung cấp
--không có sản phẩm.
SELECT p.[ProductName], s.[ContactName], P.SupplierID, s.SupplierID
FROM dbo.Products p
FULL JOIN dbo.Suppliers s
ON P.SupplierID = s.SupplierID;

-- Bài tập 5 (INNER JOIN): Liệt kê tên sản phẩm và tên nhà cung cấp
-- của các sản phẩm đã được đặt hàng trong bảng "Order Details".
-- Sử dụng INNER JOIN để kết hợp bảng "Order Details" với các bảng
-- liên quan để lấy thông tin sản phẩm và nhà cung cấp.
SELECT DISTINCT OD.[ProductID], P.ProductName, S.SupplierID
FROM dbo.[Order Details] AS OD
INNER JOIN dbo.Products P
ON  OD.[ProductID] = P.ProductID
INNER JOIN dbo.Suppliers S
ON P.SupplierID = S.SupplierID;

--Bài tập 6 (LEFT JOIN): Liệt kê tên khách hàng và tên nhân viên phụ trách 
--của các đơn hàng trong bảng "Orders". Bao gồm cả các đơn hàng không có nhân
--viên phụ trách. Sử dụng LEFT JOIN để kết hợp bảng "Orders" với bảng "Employees" 
--để lấy thông tin về khách hàng và nhân viên phụ trách.
SELECT o.CustomerID, (e.[FirstName]+ ' ' + e.[LastName]) AS "Full Name employee", o.OrderID
FROM dbo.Orders o
LEFT JOIN dbo.Employees e
ON o.EmployeeID = e.EmployeeID
LEFT JOIN dbo.Customers C
ON C.[CustomerID] = O.[CustomerID];

--Bài tập 7 (RIGHT JOIN): Liệt kê tên khách hàng và tên nhân viên phụ trách 
--của các đơn hàng trong bảng "Orders". Bao gồm cả các khách hàng không có đơn hàng. 
--Sử dụng RIGHT JOIN để kết hợp bảng "Orders" với bảng "Customers" để lấy thông tin về
--khách hàng và nhân viên phụ trách.
SELECT	C.[ContactName],C.CustomerID, O.[EmployeeID], 
		(e.[FirstName]+ ' ' + e.[LastName]) AS "Full Name employee", O.[OrderID]
FROM dbo.Orders O
RIGHT JOIN dbo.Employees e
ON O.EmployeeID = e.EmployeeID
RIGHT JOIN dbo.Customers C
ON C.[CustomerID] = O.[CustomerID];

--Bài tập 8 (FULL JOIN): Liệt kê tên danh mục(categories) và tên nhà cung cấp của các sản phẩm trong bảng
--"Products". Bao gồm cả các danh mục và nhà cung cấp không có sản phẩm. Sử dụng FULL JOIN hoặc
--kết hợp LEFT JOIN va RIGHT JOIN để lấy thong tin về danh mục và nhà cung cấp.
SELECT C.CategoryID, C.CategoryName, P.[ProductName], P.[SupplierID], S.[ContactName]
FROM dbo.Products P
FULL JOIN dbo.Categories C
ON P.CategoryID = C.CategoryID
FULL JOIN dbo.Suppliers s
ON P.SupplierID = S.SupplierID;

--Bai tập 9 (INNER JOIN): Liệt kê tên khách hàng và tên sản phẩm đã được đặt hàng trong bảng
--"Orders" và "Order Details". Sử dung INNER JOIN để kết hợp bảng "Orders" và "Order Details" để lấy
--thông tin khách hàng và sản phẩm đã được đặt hàng.
SELECT o.CustomerID, od.ProductID
FROM dbo.Orders o
LEFT JOIN dbo.[Order Details] od
ON o.OrderID = od.OrderID;

--Bai tap 10 (FULL JOIN): Liệt kê tÊn nhân viên và tên khách hàng của các đơn hàng trong bảng "Orders".
--Bao gồm cả các đơn hàng không có nhân viên hoặc khách hàng tương ứng. Sử dung FULL JOIN hoặc
--kết hop LEFT JOIN va RIGHT JOIN đe kết hop bang "Orders" với bảng "Employees" và "Customers" để
--lấy thông tin về nhân viên và khách hàng.
SELECT e.FirstName, e.LastName, c.[ContactName], o.OrderID
FROM dbo.Orders o
LEFT JOIN dbo.Employees e
ON o.EmployeeID = e.EmployeeID
LEFT JOIN dbo.Customers c
ON o.CustomerID = c.CustomerID;



