----------------------------------------
-- ////// ALIAS CÁC CỘT \\\\\\
--SELECT column_name AS alias_name
--FROM table_name;

--Đặt tên thay thế cho các cột.
--Giúp cho việc đọc và hiểu câu lệnh SQL dễ dàng hơn
----------------------------------------

--VD Viết câu lenh SQL lấy "CompanyName" và đặt tên thay thế là "Tên Công ty";
--"PostalCode" và đặt tên thay thế là "Mã bưu điện" TỪ BẢNG CUSTOMERS
SELECT CompanyName AS [Tên Công ty], PostalCode AS "Mã Bưu Điện"
FROM dbo.Customers;
-- tên có thể bỏ trong ngoặc vuông hoặc dấu nháy kép

SELECT CompanyName [Tên Công ty]-- không có AS vẫn được nhưng không nên dùng
FROM dbo.Customers;

--VD Viết câu lệnh SQL ra "LastName" và đặt tên thay thể là "Họ";
--"FirstName" và đặt tên thay thế là “Tên”. từ bảng employees
SELECT LastName AS [Họ], FirstName AS [Tên]
FROM dbo.Employees;

--VD viết câu lênh SQL lấy ra 15 dòng đàu tiên tất cả các cột trong bảng orders
-- và đặt tên thay thế cho bảng orders là "o"
SELECT TOP 15 o.*
FROM dbo.Orders AS "o";
-- HOẶC
SELECT TOP 15 *
FROM dbo.Orders AS "o";

--Viết câu lệnh SQL lấy ra các cột và đặt tên thay thế như sau:
--ProductName => Tên sản phẩm
--SupplierID => Mã nhà cung cấp
--CategoryID => Mã thể loại
--Và đặt tên thay thế cho bảng Products là "p”, sử dụng
--tên thay thế khi truy vấn các cột bên trên.
--Và chỉ lấy ra 5 sản phẩm đầu tiên trong bảng Products.
SELECT TOP 5 ProductName AS [Tên Sản Phẩm], SupplierID AS "Mã nhà cung cấp", CategoryID "Mã thể loại"
FROM dbo.Products AS "p";

--VD: Từ bảng Customers, viết câu lệnh SQL đặt tên thay thế cho bảng là "T",
--sử dụng tên thay thế để truy vấn tất cả các cột, mỗi cột chỉ lấy 30%.
SELECT TOP 30 PERCENT T.*
FROM dbo.Customers AS "T";

--VD: Từ bảng Employees, viết câu lệnh SQL đặt tên thay thế cho bảng là "T", 
--sử dụng tên thay thế để truy vấn cột City, chú ý lấy dữ liệu không trùng lặp.
SELECT DISTINCT T.City
FROM dbo.Employees AS "T";

----------------------------------------
--  ////// TÌM GIÁ TRỊ NHỎ NHẤT \\\\\\

--SELECT MIN(column_name)
--FROM table_name;

--Tìm ra giá trị nhỏ nhất của một cột.
--Có thể kết hợp với ALIAS để thay đổi tên cột.
----------------------------------------
----------------------------------------
--  ////// TÌM GIÁ TRỊ LỚN NHẤT \\\\\\

--SELECT MAX(column_name)
--FROM table_name;

--Tìm ra giá trị lớn nhất của một cột.
--Có thể kết hợp với ALIAS để thay đổi tên cột.
----------------------------------------

--VD Viết câu lệnh SQL tìm đơn giá(unit price) thấp nhất của các sẩn phẩm trong bảng Products.
SELECT MIN(UnitPrice) AS [MIN Price]
FROM dbo.Products;

--VD Viết câu lệnh SQL lấy ra ngày đặt hàng(orders date) gần đây nhất từ bảng Orders.
SELECT MAX(Orderdate) AS "MAX Orders date"
FROM dbo.Orders;

--VD Viết câu lệnh SQL tìm ra số lượng hàng tồn kho (UnitsInStock)lớn nhất từ bảng products.
SELECT MAX(UnitsInStock) AS [MAX]
FROM dbo.Products;

-- Hãy cho biết tuổi đời của nhân viên lớn nhất công ty từ bảng employees
-- Gợi ý: ai có năm sinh càng nhỏ thì người đó càng lớn tuổi.
SELECT MIN(BirthDate) AS [MIN Birth Date]
FROM dbo.Employees;

--VD Tìm ra ngày thuê (HireDate) gần nhất trong bảng Employees.

--VD Tìm ra ngày ship hàng (ShippedDate) gần nhất trong bảng Orders.

----------------------------------------
--  ////// ĐẾM SỐ LƯỢNG - COUNT() \\\\\\

--SELECT COUNT(column_name)
--FROM table_name

--Đếm số lượng dữ liệu (khác NULL) trong một cột.
--Sử dụng COUNT(*) khi muốn đếm số lượng bản ghi.
----------------------------------------

--VD Hãy đếm số lượng khách hàng Có trong bảng (Customers).
SELECT COUNT(*) AS "NumberOfCustomers" 
FROM dbo.Customers;



----------------------------------------
--  ////// ĐẾM SỐ LƯỢNG - SUM() \\\\\\

--SELECT SUM(column_name)
--FROM table_name;

--Tính tổng giá trị của một cột.
--Nếu bất kỳ giá trị trong cot là NULL, ket quả của hàm SUM sẽ là NULL.
----------------------------------------

--VD Tính tổng số tiền vận chuyển (Freight) của tất cả các đơn đặt hàng trong bảng Orders.
SELECT SUM(Freight) AS "SumOfFreight"
FROM dbo.Orders;

----------------------------------------
--  ////// ĐẾM SỐ LƯỢNG - AVG() \\\\\\

--SELECT AVG(column_name)
--FROM table_name;

--Tính giá trị trung bình cho một cột.
--Nếu tất cả các giá trị trong cột là NULL, kết quả của hàm AVG sẽ là NULL.
--Nếu chỉ một vài giá trị là NULL, AVG sẽ bỏ qua các giá trị NULL và tính trung bình cho các giá trị khác
----------------------------------------

--VD Tính trung bình số lượng đặt hàng (Quantity) của tất cả các sản phẩm trong bảng [Order Details].
SELECT AVG(Quantity) AS "AVGOfQuantity"
FROM [dbo].[Order Details];

--Đếm số lượng, tính tổng số lượng hàng trong kho và 
--trung bình giá của các sản phẩm có trong bảng Product.
SELECT	COUNT(*) AS "COUNT" , 
		SUM([UnitsInStock]) AS "TotalUnitsInStock", 
		AVG([UnitPrice]) AS "AVGPrice"
FROM dbo.Products;

--VD Hãy đếm số lượng đơn hàng từ bảng (Orders) với 2 cách:
-- Cách 1: dùng dấu *
-- Cách 2: dùng mã đơn hàng
SELECT count(*)
FROM dbo.Orders;
SELECT count([OrderID])
FROM dbo.Orders;

--VD Từ bảng [Order Details] hãy tính trung bình cho cột UnitPrice, và tính tổng cho cột Quantity.
SELECT	AVG(UnitPrice) AS "AVG Unit Price" ,
		SUM(Quantity) AS "Total Quantity"
FROM dbo.[Order Details];

--Thử thách câu hỏi về count, sum, avg:
--Câu 1: hãy tính tổng cột "Extension" trong bảng "Employees".
SELECT SUM(Extension) AS "SUM Extension"
FROM dbo.Employees;

--Câu 2: hãy đếm số lượng(Quantity) chi tiết đặt hàng trong bảng "Order Details".
SELECT COUNT(Quantity) AS "Total Quantity"
FROM dbo.[Order Details];

--Câu 3: hãy tính trung bình cột "Freight" trong bảng "Orders".
SELECT AVG(Freight) AS "AVG Freight"
FROM dbo.Orders;