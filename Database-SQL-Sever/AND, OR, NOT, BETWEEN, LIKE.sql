----------------------------------------
-- ////// AND - VÀ \\\\\\

--SELECT column1, column2, ...
--FROM table_name
--WHERE condition1 AND condition2 AND condition3 ...;

--Hiển thị một bản ghi nếu tất cả các điều kiện được phân
--tách bằng AND đều có giá trị TRUE
----------------------------------------
----------------------------------------
-- ////// OR - HOẶC \\\\\\

--SELECT column1, column2, ...
--FROM table_name
--WHERE condition1 OR condition2 OR condition3 ...;

--Hiển thị một bản ghi nếu nếu có ít nhất 1 điều kiện được
--phân tách bằng OR có giá trị TRUE
----------------------------------------
----------------------------------------
-- ////// NOT - PHỦ ĐỊNH \\\\\\

--SELECT column1, column2, ...
--FROM table_name
--WHERE NOT condition;

--Hiển thị một bản ghi nếu nếu điều kiện có giá trị không
--đúng - FALSE
-- NOT OR = AND, AND = OR
----------------------------------------

--VD hãy liệt kê tất cả các sản phẩm có số lượng trong kho (unitsinstock) 
--thuộc khoản nhỏ hơn 50 hoặc lớn hơn 100 trong bảng products.
Select ProductID, ProductName, UnitsInStock AS "số lượng thoả đk"
From dbo.Products
Where UnitsInStock < 50 OR UnitsInStock > 100;

--VD hãy liệt kê tất cả đơn hàng được giao dến Brazil, đã bị giao muộn, biết rằng ngày cần giao hàng
--là RequiredDate, ngày giao hàng thực tế là ShippedDate, trong bảng oders.
Select *
From dbo.Orders
Where ShipCountry='Brazil' And (ShippedDate>RequiredDate);

--VD lấy ra tất cả các sản phẩm có giá dưới 100$ và mã thể loại khác 1
--và sắp xếp giá từ thấp đến cao trong bảng products.
--yêu cầu dùng not
SELECT *
FROM dbo.Products
WHERE NOT (UnitPrice >= 100 OR [CategoryID] = 1)
ORDER BY UnitPrice ASC;

--VD hãy liệt kê tất cả các đơn hàng có giá vận chuyển Freight trong khoảng 50->100$ trong bảng orders.
SELECT *
FROM dbo.Orders
WHERE Freight >= 50 AND Freight <= 100
ORDER BY Freight ASC;

SELECT *
FROM dbo.Orders
WHERE Freight BETWEEN 50 AND 100
ORDER BY Freight ASC;

--VD hãy liệt kê các sản phẩm có số lượng hàng trong kho(unitsinstock) lớn hơn 20
--và số lượng hàng trong đơn hàng(unitsOnOrder) nhỏ hơn 20, trong bảng products.
SELECT *
FROM dbo.Products
WHERE UnitsInStock > 20 AND UnitsOnOrder < 20;

--Viết câu lệnh SQL tìm ra khách hàng không phải ở USA và chỉ lấy 3 dòng khác nhau hàng đầu tiên, 
--sắp xếp theo thứ tự [Lastname] A-Z và tạo ra cột full name, trong bảng employees.
SELECT DISTINCT TOP 3 EmployeeID, LastName, FirstName, (LastName + ' ' + FirstName) AS "Full Name" 
FROM dbo.Employees
WHERE NOT Country = 'USA'
ORDER BY LastName ASC;

----------------------------------------
-- ////// TOÁN TỬ BETWEEN \\\\\\

--SELECT column_name(s)
--FROM table_name
--WHERE column_name BETWEEN value1 AND value2;

--Toán tử BETWEEN chọn các giá trị trong một phạm vi nhất định. 
--Các giá trị có thể là số, văn bản hoặc ngày tháng.
--Toán tử BETWEEN bao gồm: giá trị bắt đầu và kết thúc.
----------------------------------------

--VD lấy danh sách các sản phẩm có giá bán trong khoảng từ 10 đến 20 đô la.
--C1: dùng BETWEEN
SELECT *
FROM dbo.Products
WHERE UnitPrice BETWEEN 10 AND 20
ORDER BY UnitPrice ASC;
--C2
SELECT *
FROM dbo.Products
WHERE UnitPrice >=10 AND UnitPrice <= 20
ORDER BY UnitPrice ASC;

--VD lấy danh sách các đơn đặt hàng(order date) được đặt trong khoảng thời gian
--từ 1996-07-01 đến 1996-07-31, trong bảng orders.

SELECT *
FROM dbo.Orders
WHERE OrderDate BETWEEN '1996-07-01' AND '1996-07-31';

--VD Tính tổng số tiền vận chuyển(Freight) của các đơn đặt hàng được đặt 
--trong khoảng thời gian từ ngày 1996-07-01 đến 1996-07-31, trong bảng orders.
SELECT SUM(Freight) AS "Total Freight"
FROM dbo.Orders
WHERE OrderDate BETWEEN '1996-07-01' AND '1996-07-31';

--VD lấy danh sách các đơn đặt hàng có ngày đặt hàng trong khoảng từ ngày 1/1/1997
--đến ngày 31/12/1997 và được vận chuyển bằng đường tàu thuỷ(ShipVia = 3),trong bảng Orders.
SELECT *
FROM dbo.Orders
WHERE OrderDate BETWEEN '1997-01-01' AND '1997-12-31' AND ShipVia = 3;

--Câu 1: Lấy ra tất cả các sản phẩm có số lượng hàng tồn kho từ 50 đến 100 sản phẩm.
SELECT *
FROM dbo.Products
WHERE QuantityPerUnit BETWEEN 50 AND 100;

--Câu 2: Lấy ra danh sách các quốc gia của các nhân viên có sinh nhật nằm trong khoảng từ ngày 1/8/1996 cho đến ngày 31/8/1996.
SELECT EmployeeID, Country, BirthDate
FROM dbo.Employees
WHERE BirthDate BETWEEN '1996-08-01' AND '1996-08-31';

----------------------------------------
-- ////// TOÁN TỬ LIKE \\\\\\

--SELECT column1, column2, ...
--FROM table_name
--WHERE column LIKE pattern;

--Có hai ký tự đại diện thường được sử dụng cùng với LIKE:
--Dấu phần trăm (%) đại diện cho không, một hoặc nhiều ký tự
--Dấu gạch dưới (_) đại diện cho một ký tự đơn
----------------------------------------

--VD hãy lọc ra tất cả các khách hàng đến từ các quốc gia(Country) bắt đàu bằng chữ 'A', trong bảng Customers.
SELECT *
FROM dbo.Customers
WHERE Country LIKE 'A%';

--VD lấy danh sách các đơn đặt hàng được gửi đến các thành phố(ShipCity) có chứa chữ 'a'
SELECT *
FROM dbo.Orders
WHERE ShipCity LIKE '%a%';

--VD hãy lọc ra tất cả các đơn hàng(ORDER) với điều kiện:
--ShipCountry LIKE 'U_'
--ShipCountry LIKE 'U%'

SELECT *
FROM dbo.Orders
WHERE ShipCountry LIKE 'U_';

SELECT *
FROM dbo.Orders
WHERE ShipCountry LIKE 'U%';

SELECT *
FROM dbo.Orders
WHERE ShipCountry LIKE 'U%A';

--VD Hãy lấy ra tất cả các nhà cung cấp hàng có chữ 'b' trong tên của công ty trong bảng custommers.
SELECT *, CompanyName AS "b"
FROM dbo.Customers
WHERE CompanyName lIKE '%b%';

--Challenge1: Viết câu lệnh SQL để liệt kê họ tên đầy đủ của nhân viên có chữ "e" trong họ,
--và sinh từ 1952-01-01 đến 1962-12-31,
--sắp xếp theo thứ tự A-Z theo Tên
--chỉ lấy 7 dòng đầu tiên trong bảng employees
SELECT DISTINCT TOP 7 EmployeeID, FirstName, LastName, (FirstName + ' ' + LastName) AS "Full Name"
FROM dbo.Employees
WHERE FirstName LIKE '%e%' AND (BirthDate BETWEEN '1952-01-01' AND '1962-12-31')
ORDER BY [Full Name] ASC;

--Challenge 2: Viết câu lệnh SQL để liệt kê họ tên đầy đủ của nhân viên với 'U__' (hai dấu gạch dưới) trong [Quốc gia]
--và bắt đầu làm việc từ ngày 23-03-1992 đến ngày 31-12-1994.
--sắp xếp theo thứ tự Z-A theo họ.
--chỉ lấy 3 dòng đầu tiên.
SELECT DISTINCT TOP 3 FirstName, LastName, (FirstName + ' ' + LastName) AS "Full Name"
FROM dbo.Employees
WHERE [HireDate] BETWEEN '1992-03-23' AND '1994-12-31'
ORDER BY LastName DESC;


