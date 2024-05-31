------------------------------------------------------------
-- ////// INDEX \\\\\\

--Index database là gì?

--Index là một cấu trúc dữ liệu được dùng để định vị và truy cập nhanh
--nhất vào dữ liệu trong các bảng database.
--Index là một cách tối ưu hiệu suất truy vấn database bằng việc giảm
--lượng truy cập vào bộ nhớ khi thực hiện truy vấn.
--Nói đơn giản, index trỏ tới địa chỉ dữ liệu trong một bảng, giống như
--Mục lục của một cuốn sách (Gồm tên đề mục và số trang), nó giúp truy vấn 
--trở nên nhanh chóng như việc bạn xem mục lục và tìm đúng trang cần đọc.

-- ////// CÚ PHÁP \\\\\\

--CREATE INDEX index name
--ON table_name (column1, column2, ... );


--CREATE UNIQUE INDEX index_name
--ON table_name (column1, column2, ... ); -- giá trị trong cột này không được trùng lập


-- @@@@ Các kiểu index @@@@
 
--HASH INDEX

--Hash index mạnh mẽ khi thực hiện các phép truy vấn với toán tử = hay <> (IN, NOT IN) (có
--thể nhanh hơn cả B-tree).
--Tuy nhiên lại không hữu ích khi gặp các trường truy vấn với điều kiện như >, <, like.
--Không thể tối ưu hóa toán tử ORDER BY bằng việc sử dụng Hash index bởi vì nó không thể
--tìm kiếm được phần từ tiếp theo trong Order.

--B-Tree

--Dữ liệu index trong B-Tree được tổ chức và lưu trữ theo dạng cây (tree):
--Root node - node đầu tiên đứng vị trí cao nhất trong cây
--Child nodes - nodes con được trỏ từ Parent nodes (vị trí cao hơn)
--Parent nodes - nodes cha trong cây mà có trỏ sang các Child nodes
--Leaf nodes - nodes lá, không trỏ đến bất kì nodes nào khác, có vị trí thấp nhất trong nhánh của cây.
--Internal nodes - tất cả các nodes không phải là nodes lá
--External nodes - tên gọi khác của nodes lá.
--B-Tree index được sử dụng trong các biểu thức so sánh dạng: =, >, >=, <, <= , BETWEEN và LIKE
--B-Tree index được sử dụng cho những column trong bảng khi muốn tìm kiếm 1 giá trị nằm trong khoảng nào đó

--Tóm tắt các loại đánh index

--Hash Index

--Hash Index sử dụng hàm băm để ánh xạ các giá trị cột thành các khóa. Các khóa này sau đó được lưu trữ trong một bảng băm, nơi
--chúng có thể được tìm thấy nhanh chóng bằng cách sử dụng hàm băm ngược.
--Hash Index có hiệu suất cao cho các truy vấn khớp chính xác, chẳng hạn như SELECT * FROM table WHERE column = value. Tuy
--nhiên, chúng không hiệu quả cho các truy vấn khớp khoảng, chẳng hạn như SELECT * FROM table WHERE column > value.

--B-tree Index

--B-tree Index sử dụng một cấu trúc cây để lưu trữ các giá trị cột. Cây này được tổ chức theo thứ tự tăng dần, giúp các giá trị có thể
--được tìm thấy nhanh chóng bằng cách duyệt qua cây.
--B-tree Index có hiệu suất cao cho cả truy vấn khớp chính xác và khớp khoảng. Chúng thường được coi là loại index hiệu quả nhất.

-- @@@ Lưu ý về việc dùng Index trong Databse @@@

--Cẩn trọng:
	--Index sẽ làm tốn thêm bộ nhớ để lưu trữ.
	--Làm chậm các hoạt động khác, khi insert hay update column sử dụng index, index cần được
	--điều chỉnh (reindex) sẽ tiêu tốn một khoảng thời gian.
	--Việc đánh index bừa bãi, lộn xộn, không những không tăng tốc độ truy vấn mà còn làm giảm
	--hiệu năng hoạt động.
--Các trường hợp nên sử dụng index:
	--Những bảng có dữ liệu vừa và lớn (>100 nghìn dòng)
	--Các column thường xuyên sử dụng trong mệnh đề WHERE, JOIN và ORDER BY
--Các trường hợp không nên sử dụng index:
	--Cơ sở dữ liệu nhỏ hoặc cần sử dụng tài nguyên ít
	--Dữ liệu thay đổi thường xuyên
	--Cột chứa dữ liệu không đa dạng
	--Cột chứa dữ liệu text quá dài (ví dụ như description)
--Cần phải lưu ý về thứ tự columns trong một index nhiều trường
--Các trường hợp Index sẽ được tạo tự động
	--Khóa chính
	--Khóa ngoại
	--Các cột UNIQUE

------------------------------------------------------------
--xem tốc độ và số lần đọc dữ liệu
--Bật hiển thị thống kê về tài nguyên Input/Output
SET STATISTICS IO ON;

--Truy vấn
SELECT *
FROM [Sales].[SalesOrderDetail]
WHERE [CarrierTrackingNumber]='1B2B-492F-A9';

--không dùng INDEX logical reads 1238
--Sau khi dùng INDEX logical reads 69 nhanh hơn gần 18 lần so với không dùng INDEX

--Tắt hiển thị thống kê về tài nguyên Input/Output
SET STATISTICS IO OFF;

--tạo INDEX
CREATE INDEX idx_CarrierTrackingNumber
ON [Sales].[SalesOrderDetail] ([CarrierTrackingNumber]);


--VD Tạo index trên bảng Person.Address, cột AddressLine1 và đánh giá hiệu suất truy vấn.

SELECT AddressLine1
FROM [Person].[Address]
--không dùng INDEX logical reads 216
--Sau khi dùng INDEX logical reads 121

CREATE INDEX idx_AddressLine1
ON [Person].[Address] (AddressLine1);

--VD Tạo index cho cột "ProductName" trong bảng "Production.Product“và đánh giá hiệu suất truy vấn.