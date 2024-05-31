----------------------------------------------
-- ////// Câu lệnh SELECT \\\\\\
-- SELECT column1, column 2, ...
-- FROM table_name;
----------------------------------------------
-- Câu lệnh SELECT được sử dụng để chọn dữ liệu từ cơ sở dữ liệu.
-- Dữ liệu trả về được lưu trữ trong một bảng kết quả, được gọi là tập hợp kết quả.
-- Các cột1, cột2, ... là tên trường của bảng mà bạn muốn chọn dữ liệu
-- ///\\\ không nhất thiết phải có dấu ngoặc vuông nếu các kí tự ko có khoảng tróng
----------------------------------------------

--VD viết câu lệnh SQL lấy ra tên của tất cả các sản phẩm(products). 
SELECT [ProductName]
FROM [dbo].[Products];

--VD viết câu lệnh SQL lấy ra tên sản phẩm(product name), 
-- giá bán trên mỗi đơn vị(unit price), số lượng sản phẩm trên đơn vị(quantity  per unit).
SELECT [ProductName], [UnitPrice], [QuantityPerUnit]
FROM dbo.Products;

--VD viết câu lệnh SQL lấy ra tên công ty(company name) khách hàng và quốc gia(country) của khách hàng đó(customers).
SELECT CompanyName, Country
FROM [dbo].[Customers];

--VD viết câu lệnh SQL lấy ra tên công ty(company name) và số điện thoại(phone) của tất cả các nhà cung cấp(suppliers) khách hàng(customers).
SELECT CompanyName, Phone
FROM dbo.suppliers;
-- *** VD ***
--1. Viết câu lệnh SQL lấy ra ID và SDT của Shipper.
SELECT ShipperID, Phone
FROM dbo.Shippers;

--2. Viết câu lệnh SQL lấy ra tên hợp đồng(contract name) và SDT(phone) của Khách Hàng(customers).
SELECT ContactName, Phone
FROM dbo.Customers;

--3. Viết câu lệnh SQL lấy ra địa chỉ(address), thành phố(city) và quốc gia(country) của nhà cung cấp(suppliers) hàng hoá
SELECT City, Country, Address
FROM dbo.Suppliers;

--4. Viết câu lệnh SQL lấy ra ID khách hàng(CustomerID), ngày đặt hàng(order date) và địa chỉ giao hàng(ship address) của tất cả đơn hàng(Orders)
SELECT CustomerID, Orderdate, ShipAddress
FROM dbo.Orders;
----------------------------------------------
-- ////// Câu lệnh SELECT * \\\\\\
-- SELECT *
-- FROM table_name;
-- *: lấy tất cả các cột
----------------------------------------------

--VD viết câu lệnh SQL lấy ra tất cả dữ liệu từ bảng products(sản phẩm).
SELECT *
FROM dbo.Products;

--VD viết câu lệnh SQL lấy ra tất cả dữ liệu từ bảng orders(mệnh lệnh).
SELECT *
FROM [dbo].[Orders];

--VD Output Tất cả collum của bảng Employees.
SELECT *
FROM dbo.Employees

----------------------------------------------
-- ////// Câu lệnh SELECT DISTINCT \\\\\\

--SELECT DISTINCT column1, column2,...

--FROM table_name;

--Lấy các dữ liệu ""riêng biệt, không trùng lặp"" (khác nhau)
----------------------------------------------

--VD Viết câu lệnh SQL lấy ra tên các quốc gia(Country) ""khác nhau"" từ bảng khách hàng(Customers)
SELECT DISTINCT Country
FROM dbo.Customers;

--VD Viết câu lệnh SQL lấy ra tên các mã số bưu điện(PostalCode) ""khác nhau"" từ bảng nhà cung cấp(suppliers)
SELECT DISTINCT PostalCode
FROM dbo.Suppliers;

--VD Viết câu lệnh SQL lấy ra các dữ liệu ""khác nhau"" về họ của nhân viên (LastName)
--và cách gọi danh hiệu lịch sự(TitleOfCourtesy) của nhân viên từ bảng Employees
SELECT DISTINCT LastName, TitleOfCourtesy
FROM dbo.Employees;

--VD Viết câu lệnh SQL lấy ra mã đơn vị vận chuyển(ShipVia) khác nhau của các đơn hàng(Orders)
SELECT DISTINCT ShipVia
FROM dbo.Orders;

--VD Lấy tất cả họ khác nhau của nhân viên (Employees)
--VD Lấy tất cả giá khác nhau của sản phẩm (Products)

----------------------------------------------
-- ////// Câu lệnh SELECT TOP \\\\\\

--SELECT TOP number|percent "column_name(s)" để láy từng cột hoặc "*" nếu muốn láy tất cả các cột
--FROM table_name
--WHERE condition;

--Giới hạn số lượng dòng (hoặc %) được trả về khi gọi lệnh SELECT.
----------------------------------------------

--VD Viết câu lệnh láy ra 5 dòng đàu tien trong bảng Customers
SELECT TOP 5 *
FROM dbo.Customers;
SELECT TOP 5 [CompanyName], [ContactName]
FROM dbo.Customers;

--VD Viết câu lệnh láy ra 30% nhân viên(Employees) của công ty hiện tại.
SELECT TOP 30 PERCENT *
FROM dbo.Employees;

--VD Viết câu lenh SQL lấy ra các mã khách hàng(CustomerID) trong bảng đơn hàng(orders) với quy định là mã khách hàng
--không được trùng lặp, chỉ lấy 5 dòng dữ liệu đàu tiên.
SELECT DISTINCT TOP 5 CustomerID
FROM dbo.Orders;

--VD Viết câu lệnh SQL lấy ra các sản phẩm có mã(ProductID) trong bảng sản phẩm(Product) 
-- thể loại không bị trùng lặp, và chỉ lấy ra 3 dòng đàu tiên.
SELECT DISTINCT TOP 3 ProductID
FROM dbo.Products;

--VD Viết câu lệnh SQL lấy ra 70% các cột trong bảng Region và không trùng lập
SELECT DISTINCT TOP 70 PERCENT *
FROM dbo.Region;