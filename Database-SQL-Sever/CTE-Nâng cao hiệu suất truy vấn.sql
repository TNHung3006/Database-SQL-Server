------------------------------------------------------------
-- ////// Common Table Expression (CTE) \\\\\\

--Được sử dụng để tạo bảng tạm thời và sử dụng nó trong các truy vấn sau đó.
--Giúp làm cho câu truy vấn trở nên dễ đọc và dễ quản lý hơn.

--Cấu trúc của CTE
--"WITH" là từ khóa bắt buộc để bắt đầu định nghĩa CTE.
--"tên_CTE" là tên bạn muốn đặt cho CTE, đây là tên mà bạn sẽ sử dụng để tham chiếu
--đến nó trong các truy vấn sau.
--(cột1, cột2, ... ) là danh sách các cột bạn muốn định nghĩa cho CTE. Có thể không cần
--định danh cột nếu bạn muốn CTE chứa tất cả các cột từ kết quả của truy vấn.
--& " -- Truy vấn để định nghĩa CTE" là phần trong dấu ngoặc đơn, nơi bạn đặt truy vấn
--SQL để xác định dữ liệu cho CTE. Truy vấn này có thể bao gồm các câu lệnh SELECT,
--FROM, WHERE, GROUP BY, HAVING, và ORDER BY tùy theo nhu cầu của bạn.


--WITH tên_CTE (cot1, cot2, ... ) AS (
-- Truy vấn để định nghĩa CTE), AS (Truy vấn để định nghĩa CTE 
--), ...

--LỢI ÍCH CỦA CTE
--Giảm độ phức tạp của truy vấn SQL
--CTE cho phép bạn tạo ra các truy vấn tạm thời và sử dụng chúng như một bảng tạm
--trong truy vấn chính. Điều này giúp giảm độ phức tạp của câu lệnh SQL bằng cách phân
--tách nó thành các phần nhỏ hơn, dễ đọc hơn và dễ hiểu hơn. Bạn có thể sử dụng các
--CTE liên tiếp nhau để xử lý dữ liệu phức tạp một cách có tổ chức.

--Tăng hiệu suất và tối ưu hóa truy vấn
--CTE có thể giúp tăng hiệu suất của truy vấn SQL. Bằng cách tạo ra các bảng tạm thời
--trong bộ nhớ, CTE có thể giảm số lần truy cập đến ổ đĩa và tối ưu hóa các phép tính truy
--vấn. Ngoài ra, CTE cũng cho phép bạn sử dụng các biểu thức cùng tên trong truy vấn
--chính và các CTE liên quan, giúp tối ưu hóa và tái sử dụng mã truy vấn.

--LƯU Ý
--CTE thường được ưu tiên trong các truy vấn phức tạp hoặc cần tối ưu hóa hiệu suất vì
--nó dễ đọc và tính toán kết quả một lần.
--Subquery phù hợp cho các truy vấn đơn giản hoặc khi bạn cần truy vấn dữ liệu từ một
--bảng dựa trên kết quả của một truy vấn khác, nhưng có thể gây hiệu suất kém hơn.
------------------------------------------------------------

--VD
WITH short_e AS (
	SELECT [EmployeeID], [LastName], [FirstName]
	FROM [dbo]. [Employees]
)
SELECT * 
FROM short_e;

--VD Lấy thông tin về các sản phẩm (Products) có cùng thể loại với một sản phẩm cụ thể
--Sử dụng Sub Query
SELECT ProductName, CategoryID
FROM Products
WHERE CategoryID = (
	SELECT CategoryID
	FROM Products
	WHERE ProductName = 'Genen Shouyu' -- =2
);
--Sử dụng CTE
WITH ProductCategory AS (
	SELECT CategoryID
	FROM dbo.Products
	WHERE ProductName = 'tên sản phẩm cụ thể'
)
SELECT P.ProductName, P.CategoryID
FROM dbo.Products AS P
JOIN ProductCategory AS PC 
ON P.CategoryID = PC.CategoryID;

--Lấy thông tin về đơn hàng (Orders) cùng với tổng giá trị đơn hàng và 
--tỷ lệ giữa tổng giá trị và phí giao hàng(Freight)
--Sử dụng sub query
SELECT OrderID, Freight, (
		SELECT SUM(od.Quantity*od.UnitPrice) 
		FROM dbo.[Order Details] od
		WHERE od.OrderID = o.OrderID
	) AS "total",(
		SELECT SUM(od.Quantity*od.UnitPrice) -- đoạn code sẽ bị lập lại 1 lần nữa
		FROM dbo.[Order Details] od
		WHERE od.OrderID = o.OrderID
	)/Freight AS "tỉ lệ"
FROM dbo.Orders o;
--sử dụng cte 
WITH Quantity_UnitPrice AS (
		SELECT OrderID, SUM(Quantity*UnitPrice)  AS "total"
		FROM dbo.[Order Details]
		GROUP BY OrderID
)
SELECT	o.OrderID, 
		o.Freight, 
		o.OrderDate, 
		qu.total, 
		qu.total/o.Freight AS "tỉ lệ"
FROM dbo.Orders o
JOIN Quantity_UnitPrice AS qu ON qu.OrderID = o.OrderID;

--VD Sử dụng CTE để tính tổng doanh số bán hàng cho từng sản phẩm từ hai bảng
--"Order Details" và "Products" trong cơ sở dữ liệu NorthWind.
WITH H730T AS(
SELECT ProductID, SUM(Quantity*UnitPrice) AS "Total"
FROM dbo.[Order Details]
GROUP BY ProductID
)
SELECT ht.[ProductID], p.[ProductName], ht.Total
FROM dbo.Products p
JOIN H730T AS ht
ON ht.ProductID = p.ProductID;

--VD Sử dụng CTE để tính toán tổng doanh số bán hàng theo từng khách hàng và sau đó
--sắp xếp danh sách khách hàng theo tổng doanh số giảm dần.
WITH H730T AS(
SELECT OrderID, SUM(Quantity*UnitPrice) AS "Total"
FROM dbo.[Order Details]
GROUP BY OrderID
)
SELECT c.[CustomerID], c.[CompanyName], ht.Total
FROM dbo.Orders o
JOIN H730T AS ht
ON ht.OrderID = o.OrderID
INNER JOIN dbo.Customers c
ON o.CustomerID = c.CustomerID
Order BY ht.Total DESC;

--VD Sử dụng CTE tính tổng doanh số bán hàng theo năm từ bảng "Orders" và "Order
--Details"
WITH H730T AS(
SELECT OrderID, SUM(Quantity*UnitPrice) AS "Total"
FROM dbo.[Order Details]
GROUP BY OrderID
)
SELECT o.OrderID, YEAR(o.OrderDate) AS "YEAR", ht.Total
FROM dbo.Orders o
JOIN H730T AS ht
ON ht.OrderID = o.OrderID;