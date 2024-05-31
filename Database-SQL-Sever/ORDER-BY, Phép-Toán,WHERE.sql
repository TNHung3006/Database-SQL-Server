----------------------------------------
-- ////// ORDER BY \\\\\\

--SELECT column1, column2,...
--FROM table_name
--ORDER BY column1, column2, ... ASC | DESC;

--ASC: sắp xếp tăng dần (mặc định nếu không ghi)
--DESC: sắp xếp giảm dần.
----------------------------------------

--VD Bạn hãy liệt kê tất cả các nhà cung cấp theo thứ tự tên đơn vị (CompanyName) Từ A-Z trong bảng suppliers.
SELECT Companyname AS "SapXepTenDonVi"
FROM dbo.Suppliers
ORDER BY Companyname ASC;

--VD Bạn hãy liệt kê tất cả các sản phẩm theo thứ tự giá giảm dần trong bảng products.
SELECT UnitPrice
FROM dbo.products
ORDER BY UnitPrice DESC;

--VD Bạn hãy liệt kê tất cả các nhân viên theo thứ tự họ và tên đệm A-Z trong bảng employees.
--Không dùng ASC | DESC
SELECT LastName AS "HỌ", FirstName AS "TÊN"
FROM dbo.Employees
ORDER BY LastName, FirstName;

SELECT LastName AS "HỌ", FirstName AS "TÊN"
FROM dbo.Employees
ORDER BY LastName ASC, FirstName ASC;

--VD Hãy lấy ra một sản phẩm có số lượng bán cao nhất từ bảng [Order Details].
--Không được dùng MAX. ////////////////////////////
SELECT TOP 1 *
FROM DBO.[Order Details]
ORDER BY Quantity DESC;

--VD Hãy liệt kê danh sách các đơn đặt hàng (OrderID) trong bảng Orders theo thứ tự giảm dần của ngày đặt hàng (OrderDate).
SELECT OrderDate AS "SapXepGiamDan" , OrderID
FROM dbo.Orders
ORDER BY OrderDate DESC;

--VD Hãy liệt kê tên, đơn giá, số lượng tồn kho (UnitslnStock) của tất cả các sản phẩm 
--trong bảng Products, theo thứ tự giảm dần của UnitsInStock.
SELECT UnitPrice, ProductName, UnitsInStock
FROM dbo.Products
ORDER BY UnitsInStock DESC;

----------------------------------------
-- ////// Phép Toán \\\\\\

-- +(cộng) -(trừ) *(nhân) /(chia) %(chia láy phần dư)
----------------------------------------

--VD Tính số lượng sản phẩm còn lại trong kho(UnitsInStock) 
--sau khi bán hết các sản phẩm đã được đặt hàng(UnitsOnOrder) trong bảng products.
SELECT	ProductID, ProductName, UnitsInStock, UnitsOnOrder, 
		(UnitsInstock - UnitsOnOrder) AS "số lượng sản phẩm còn lại"
FROM dbo.Products;

--VD tính giá trị đơn hàng chi tiết cho tất cả các sản phẩm
--(láy tất cả các sản phẩm nhân cho giá tiền) trong bảng order detail

SELECT	OrderID, ProductID, UnitPrice AS "giá trị mỗi sản phẩm", Quantity AS "Số lượng",
		(UnitPrice * QuanTity) AS "giá trị đơn hàng"
FROM dbo.[Order Details];

--VD tính tỷ lệ giá vận chuyển đơn dặt hàng(Freight) trung bình của các đơn đặt hàng 
--trong bảng orders so với giá trị vận chuyển của đơn hàng lớn nhất (max freight).
SELECT (AVG(Freight) / MAX(Freight)) AS "Tỉ lệ"
FROM dbo.Orders;

--VD Hãy liệt kê danh sách các sản phẩm, và giá (UnitPrice) của từng sản phẩm sẽ được giảm đi 10% trong bảng products.
--Cách 1: dùng phép nhân + phép chia
--Cách 2: chỉ được dùng phép nhân
--Cách 1
SELECT *, (UnitPrice * 90 / 100) AS "After Discont 10%"
FROM dbo.Products;
--Cách 2
SELECT *, (UnitPrice *0.9) AS "After Discont 10%"
FROM dbo.Products;

--Câu hỏi 1: hãy tính giá vận chuyển trung bình ("Freight") của các đơn đặt hàng
--phải dùng các phép tính và không dùng hàm tính trung bình AVG, trong bảng order.
SELECT	(Sum(Freight) / Count(Freight)) AS "AVG Of Freight"
FROM dbo.Orders;

--Câu hỏi 2: hãy tính tổng số tiền mua hàng sau khi đã được giảm giá discount


----------------------------------------
-- ////// MỆNH ĐỀ WHERE \\\\\\

--SELECT column1, column2,...
--FROM table_name
--WHERE condition;

--Mệnh đề WHERE được sử dụng để lọc các bản ghi.
--Nó được sử dụng để chỉ trích xuất những bản ghi đáp ứng một điều kiện cụ thể.
-- =(bằng) >(lớn) <(bé) >=(lớn hơn hoặc bằng) <=(bé hơn hoặc bằng) <>(khác)
----------------------------------------

--VD Bạn hãy liệt kê tất cả các nhân viên đến từ thành phố London, trong bảng employees.
--Sắp xếp kết quả theo lastname a->z ORDER BY nằm sau WHERE
SELECT	*
FROM dbo.Employees
WHERE City ='London'
ORDER BY LastName ASC;

--VD Bạn hãy liệt kê tất các đơn hàng bị giao muộn 
--biết rằng ngày cần phải giao hàng là RequiredDate, ngày giao hàng thực tế là ShippedDate trong bảng Orders.
--(ngày giao hàng thực tế phải lớn hơn ngày cần phải giao hàng)
SELECT [OrderID], [RequiredDate], [ShippedDate]
FROM dbo.Orders
WHERE ShippedDate>RequiredDate;
-- đếm số lượng hàng giao muộn
SELECT count(*)
FROM dbo.Orders
WHERE ShippedDate>RequiredDate;

--VD lấy ra tất cả các đơn hàng chi tiết được giảm giá nhiều hơn 10%(discount >0.1) trong bảng order details
SELECT *
FROM dbo.[Order Details]
WHERE Discount>0.1;

--VD Hãy liệt kê tất cả các đơn hàng được gửi đến quốc gia là "France"
SELECT OrderID, ShipCountry
FROM dbo.[Orders]
WHERE ShipCountry='France';

--VD hãy liệt kê các sản phẩm có số lượng hàng tồn kho (unitsinstock) lớn hơn 20.
SELECT *
FROM dbo.[Products]
WHERE UnitsInStock>20;