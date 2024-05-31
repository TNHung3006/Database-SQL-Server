----------------------------------------
-- ////// WILDCARD \\\\\\

--SELECT column1, column2, ...
--FROM table_name
--WHERE column LIKE pattern;

-- ///// Description \\\\\

-- % :	Represents zero or more characters(Đại diện cho 0 hoặc nhiều ký tự)
-- _ :	Represents a single character(Đại diện cho một ký tự duy nhất)
-- []:	Represents any single character within the brackets(Đại diện cho bất kỳ ký tự đơn nào trong dấu ngoặc)
-- ^ :	Represents any character not in the brackets(Đại diện cho bất kỳ ký tự nào không có trong ngoặc)
-- - :	Represents any single character within the specified range (Đại diện cho bất kỳ ký tự đơn nào trong phạm vi được chỉ định)

-- ///// Example \\\\\

-- % :	bl% finds bl, black, blue, and blob
-- _ :	h_t finds hot, hat, and hit
-- []:	h[o,a]t finds hot and hat, but not hit // có dấu , hoặc ko đều được
-- ^ :	h[^oa]t finds hit, but not hot and hat
-- - :	c[a-c]t finds cat and cbt and cct
----------------------------------------

--VD Hãy lọc ra tất cả các khách hàng có tên liên hệ(contact name) bắt đàu bằng chữ 'A' trong bảng Customers.
SELECT *
FROM dbo.Customers
WHERE ContactName LIKE 'A%';

--VD Hãy lọc ra tất cả các khách hàng có tên liên hệ bắt đàu bằng chữ 'H', 
--và có chữ thứ 2 là bất kì kí tự nào, trong bảng customers.
SELECT *
FROM dbo.Customers
WHERE ContactName LIKE 'H_%';

--VD Hãy lọc ra tất cả các đơn hàng được gửi đến thành phố có chữ cái bắt đầu là L, 
--chữ cái thứ hai là u hoặc o.
SELECT *
FROM dbo.Orders
WHERE ShipCity LIKE 'L[u,o]%';

--VD Hãy lọc ra tất cả các đơn hÀng được gửi đến thành phố có chữ cái bắt đầu là L, 
--chữ cái thứ hai không phải là u hoặc o.
SELECT *
FROM dbo.Orders
WHERE ShipCity LIKE 'L[^u,o]%';

--VD Hãy lọc ra tất cả các đơn hàng được gửi đến thành phố có chữ cái bắt đầu là L, 
--chữ cái thứ hai là các ký tự từ a đến e.
SELECT *
FROM dbo.Orders
WHERE ShipCity LIKE 'L[a-e]%';

--Hãy lấy ra tất cả các nhà cung cấp hàng(suppliers) có tên công ty bắt đàu bằng chữ 'N' và không chứa kí tự i, trong bảng suppliers.
SELECT *
FROM dbo.Suppliers
WHERE CompanyName LIKE 'N%' AND [CompanyName] NOT LIKE  '%i%';

--Challenges1: Viết câu lệnh SQL liệt kê họ tên nhân viên(employees) có tên không có chữ “cf”
--và chữ "D" xuất hiện ở đàu tên
SELECT [LastName], [FirstName], (LastName + ' ' + FirstName) AS [Full Name]
FROM dbo.Employees AS "T"
WHERE FirstName Like 'A%' AND FirstName NOT LIKE '%[c,f]%' ;

--Challenges2: Viết câu lệnh SQL để liệt kê Khách hàng(customers) với CompanyName có chữ 'a-k'
--nhưng không có chữ "d"
SELECT *
FROM dbo.Customers
WHERE CompanyName LIKE '%[a-k]%' AND CompanyName NOT LIKE '%d%';

----------------------------------------
-- ////// IN - NOT IN \\\\\\

--SELECT column_name(s)
--FROM table_name
--WHERE column_name NOT IN (value1, value2, ... );

--lọc dữ liệu trong danh sách
--Giá trị của column khác với các giá trị đã được chỉ định.
----------------------------------------

--VD Hãy lọc ra tất cả các đơn hàng với điều kiện:
--a, Đơn hàng được giao đến Germany, UK, Brazil
SELECT *
FROM dbo.Orders
WHERE ShipCountry IN ('Germany','UK','Brazil');
-- OR
SELECT *
FROM dbo.Orders
WHERE ShipCountry = 'Germany' OR ShipCountry ='UK' OR ShipCountry ='Brazil';
--b, Đơn hàng được giao đến các quốc gia khác Germany, UK, Brazil
SELECT *
FROM dbo.Orders
WHERE ShipCountry NOT IN ('Germany','UK','Brazil');

--VD lấy ra các sản phẩm có mã thể loại(categoryID) khác với 2,3,4.
SELECT *
FROM dbo.Products
WHERE CategoryID NOT IN (2, 3, 4);

--VD 
--1.Hãy liệt kê các nhân viên không phải là nữ từ bảng nhân viên.
--Gợi Ý: vì bảng không có cột giới tính nên coi bảng cột nào liên quan đến giới tính thì lấy
SELECT *
FROM dbo.Employees 
WHERE [TitleOfCourtesy] NOT IN ('Ms.', 'Mrs.');
--2.Hãy liệt kê các nhân viên là nữ từ bảng nhân viên.
SELECT *
FROM dbo.Employees
WHERE [TitleOfCourtesy] IN ('Ms.', 'Mrs.');

--Hãy lấy ra tất cả các khách hàng đến từ các thành phố sau đây: Berlin, London, Warszawa
SELECT *
FROM dbo.Customers
WHERE City NOT IN ('Berlin', 'LonDon', 'Warszawa');

--Challenges : Viết câu lệnh SQL liệt kê họ và tên nhân viên có chữ “o” ở cuối họ
-- và ngày thuê từ  23-03-1992 đến ngày 31-12-1994
-- sắp xếp họ tên theo thứ tự A-Z theo họ
-- Không sống ở London, Seattle
-- chỉ lấy 3 hàng
SELECT TOP 3	[EmployeeID], [FirstName], [LastName], City, [HireDate],
						([FirstName]+' '+[LastName]) AS "FULL NAME" 
FROM dbo.Employees
WHERE [HireDate] BETWEEN '1992-03-23' AND '1994-12-31' AND City NOT IN ('London', 'Seattle')
ORDER BY [FULL NAME] ASC ;

----------------------------------------
-- ////// IS NULL - IS NOT NULL \\\\\\

--SELECT column_name(s)
--FROM table_name
--WHERE column_name IS NULL|IS NOT NULL;

--Giá trị của column bị NULL.
--Giá trị của column khác NULL.
----------------------------------------

--VD hãy đếm số lượng tất cả các đơn hàng(orders) chưa được giao(shippedDate ==> NULL).
SELECT COUNT(*)
FROM dbo.Orders
WHERE ShippedDate IS NULL;

--VD lấy ra danh sách các khách hàng(customer) có khu vực (region) không bị null.
SELECT *
FROM dbo.Customers
WHERE Region IS NOT NULL;

--VD lấy ra danh sách các khách hàng không có tên công ty(CompanyName).
SELECT *
FROM dbo.Customers
WHERE CompanyName IS NULL;

--VD Hãy lấy ra tất cả các đơn hàng chưa được giao hàng và có khu vực giao hàng (ShipRegion) không bị NULL.
SELECT *
FROM dbo.Orders
WHERE ShipRegion IS NOT NULL;

--Challenges1: Viết câu lệnh SQL để liệt kê các Sản phẩm có ReorderLevel không rỗng
--Và UnitsInStock > 30 và ProductName có chữ 'S'
--Và sắp xếp theo Tên sản phẩm từ A-Z
--và chỉ lấy 5 hàng
SELECT TOP 5 *
FROM dbo.Products
WHERE ReorderLevel IS NOT NULL AND UnitsInStock > 30 AND ProductName LIKE '%S%'
ORDER BY ProductName ASC;

--Challenges2 : Viết câu lệnh SQL để liệt kê các đơn hàng có shipregion null
--Và những đơn hàng không được giao trễ(requiredDate is not null )
--Và Shipcountry bao gồm (Brazil, France)
--Và chỉ lấy 10 hàng
--Sắp xếp Shipname từ z-a.
SELECT TOP 10 *
FROM dbo.Orders
WHERE ShipRegion IS NULL AND RequiredDate IS NOT NULL AND ShipCountry IN ('Brazil', 'France')
ORDER BY ShipName DESC;