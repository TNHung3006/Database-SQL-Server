------------------------------------------------------------
-- ////// Truy vấn đệ quy sử dụng CTE \\\\\\

--WITH CTE_name (column1, column2, ... ) AS (
--/* Anchor member */
		--SELECT
		--FROM
		--WHERE
		--UNION ALL

--/* Recursive member */
		--SELECT ...
		--FROM CTE_name
		--JOIN CTE_name ON ...
--)
--SELECT ...
--FROM CTE_name

--------------------------------------------------------
--Khi nào cần sử dụng truy vấn đệ quy?
--Cây/phân cấp dữ liệu: Truy vấn đệ quy thường được sử dụng khi bạn làm việc với dữ liệu
--có cầu trúc cây hoặc phân cấp, ví dụ như cây hệ thống thư mục, cấu trúc tổ chức công ty,
--hoặc danh sách sản phẩm có danh mục con.

--Duyệt đồ thị: Truy vấn đệ quy cũng hữu ích khi bạn cần duyệt qua các mối quan hệ đồ thị
--như mỗi quan hệ bạn bè trong mạng xã hội.

--Tìm kiếm đường đi: Nếu bạn cần tìm kiếm các đường đi, ví dụ như đường đi ngắn nhất
--giữa hai điểm trong một mạng lưới.

--Tạo danh sách hoặc báo cáo có tính đệ quy: Truy vấn đệ quy có thể được sử dụng để xây
--dựng danh sách theo các quy tắc phức tạp hoặc tạo báo cáo có cấu trúc phức tạp.
------------------------------------------------------------

WITH fibo(p, n) AS (
		--phần Khởi tạo
		SELECT
			0 AS p, 
			1 AS n
		UNION ALL
		--phần đệ quy
		SELECT
			n as p,
			p+n as n
		FROM fibo
)
SELECT * FROM fibo
OPTION (MAXRECURSION 7);
--dãy fibonacci
--Sn = S(n-1) + S(n-2)
--0 1 1 2 3 5 8

WITH GiaiThua(stt, giaithua) AS (
		--phần Khởi tạo
		SELECT
			1 AS stt, 
			1 AS giaithua
		UNION ALL
		--phần đệ quy
		SELECT
			(stt+1) as stt, 
			(stt+1) * giaithua as giaithua
		FROM GiaiThua
)
SELECT * FROM GiaiThua
OPTION (MAXRECURSION 10);

--Sử dụng truy vấn đệ quy để tạo một cây cấu trúc quản lí của nhân viên trong bảng "employees".
--trong đó "ReportsTo" chính là mã của người quản lí và EmloyeeID của người quản lí bằng 2.

declare @EmployeeId int
set @EmployeeId = 2;

WITH emp as (
		-- khởi tạo
		SELECT	e.EmployeeID, e.ReportsTo as managerID, 
				e.FirstName + ' ' + e.LastName as fullname, 
				0 as level
		FROM dbo.Employees as e
		WHERE e.EmployeeID = @EmployeeId
		UNION ALL
		-- đệ quy
		SELECT	e1.EmployeeID, e1.ReportsTo as managerID, 
				e1.FirstName + ' ' + e1.LastName as fullname, 
				level + 1 as level
		FROM dbo.Employees as e1
		JOIN emp ON e1.ReportsTo=emp.EmployeeID
)
SELECT * FROM emp
OPTION (MAXRECURSION 2);
SELECT * FROM Employees