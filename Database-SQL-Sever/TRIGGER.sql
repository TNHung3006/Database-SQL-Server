------------------------------------------------------------
-- ////// TRIGGER \\\\\\

--Trigger là một đoạn thủ tục SQL được thực thi tự động khi một sự kiện cụ thể xảy ra trên
--một bảng (table) hoặc dạng xem (view).

--Các sự kiện có thể kích hoạt Trigger bao gồm
	--Insert, Update, Delete
	--DDL (Data Definition Language)
	--DML (Data Manipulation Language)
--Trigger được chia thành hai loại chính:
	--Trigger Before: Thực thi trước khi sự kiện xảy ra.
	--Trigger After: Thực thi sau khi sự kiện xảy ra.
--Cú pháp tạo Trigger

	--CREATE TRIGGER trigger_name
	--ON table_name
	--FOR {INSERT|UPDATE|DELETE}
	--AS
	--BEGIN
		-- Code thực thi khi sự kiện xảy ra
	--END;

--Các lớp Trigger trong SQL Server:

	--DDL Trigger: DDL là viết tắt của cụm Data Definition Language. DDL trigger sẽ kich
--hoạt khi những sự kiện bị thay đổi cấu trúc như việc tạo, sửa đổi, bỏ bảng. Cũng có thể
--xuất hiện trong những sự kiện liên quan tới server (sửa đổi bảo mật, cập nhật thống kê).

	--DML Trigger: DML là viết tắt của cum từ Data Modification Language. DML trigger 
--là một loại trigger phổ biến và được sử dụng nhiều nhất hiện nay. Lúc này, việc kích
--hoạt chính là câu lệnh sửa đổi dữ liệu. Đó có thể là một câu lệnh chèn vào bảng, cập nhật
--bảng hoặc xóa bỏ bảng.

--LƯU Ý
	--AFTER: Trigger "AFTER" (hoặc "AFTER INSERT", "AFTER UPDATE", "AFTER
--DELETE") được kích hoạt sau khi lệnh INSERT, UPDATE hoặc DELETE đã hoàn thành
--và dữ liệu đã được thay đổi trong cơ sở dữ liệu. Trigger "AFTER" thường được sử dụng
--để thực hiện các hành động sau khi dữ liệu đã được thay đổi. Trigger "AFTER" có thể
--truy cập vào dữ liệu đã được cập nhật và sử dụng nó trong các hành động khác.

	--FOR: Trigger "FOR" (hoặc "FOR INSERT", "FOR UPDATE", "FOR DELETE") thường
--được sử dụng để kiểm tra hoặc can thiệp vào dữ liệu trước khi lệnh INSERT, UPDATE
--hoặc DELETE được thực hiện hoặc để kiểm tra và thay đổi dữ liệu trước khi nó được cập
--nhật. Trigger "FOR" thực hiện hành động trước khi dữ liệu thay đổi, và nó có khả năng
--ảnh hưởng đến dữ liệu trước khi nó được ghi vào cơ sở dữ liệu. Trigger "FOR" có thể
--được sử dụng để kiểm tra và cản trở việc cập nhật dữ liệu nếu cần.

	--"INSTEAD OF" là một loại khác của trigger trong SQL Server. Trigger "INSTEAD OF" được sử dụng để thay
--đổi hoặc kiểm tra dữ liệu trước khi một lệnh DML (Data Manipulation Language) như INSERT, UPDATE hoặc
--DELETE được thực hiện trên một view hoặc một bảng. Nó thay thế lệnh DML gốc bằng hành động bạn xác
--định trong trigger.

	--Cụ thể, trigger "INSTEAD OF" cho phép bạn thực hiện các hành động tùy chỉnh thay vì thực hiện lệnh DML
--gốc. Điều này có thể hữu ích khi bạn muốn kiểm tra và can thiệp vào dữ liệu trước khi nó được ghi vào cơ sở dữ
--liệu hoặc khi bạn muốn thực hiện hành động không phải là lệnh DML trực tiếp.

	--Ví dụ, nếu bạn có một view hoặc một bảng, và bạn muốn áp dụng quy tắc kiểm tra trước khi cho phép các lệnh
--INSERT hoặc UPDATE, bạn có thể sử dụng trigger "INSTEAD OF" để kiểm tra và thay đổi dữ liệu trước khi nó
--được ghi vào cơ sở dữ liệu.

--Ưu điểm
	--Trigger có thể bắt lỗi business logic ở mức CSDL.
	--Có thể dùng trigger là một cách khác để thay thế việc thực hiện những
	--công việc hẹn giờ theo lịch.
	--Trigger rất hiệu quả khi được sử dụng để kiểm soát những thay đổi của
	--dữ liệu trong bảng.

--Nhược điểm
	--Trigger chỉ là một phần mở rộng của việc kiểm tra tính hợp lệ của dữ
	--liệu chứ không thay thế được hoàn toàn công việc này.
	--Trigger hoạt động ngầm ở trong csdl, không hiển thị ở tầng giao diện.
	--Do đó, khó chỉ ra được điều gì xảy ra ở tầng csdl.
	--Trigger thực hiện các update lên bảng dữ liệu vì thế nó làm gia tăng
	--lượng công việc lên csdl và làm cho hệ thống chạy chậm lại.

------------------------------------------------------------

-- Trigger khi insert sẽ chuyển productName về viết hoa toàn bộ:


-- Viết một trigger trong cơ sở dữ liệu Northwind để đảm bảo 
-- rằng mỗi khi có một chi tiết đơn hàng mới được thêm vào, số lượng tồn kho phải được giảm đi


--Bài tập 1: Bổ sung thêm cột LastModified và tạo một trigger để sau khi một
--sản phẩm được thêm hoặc cập nhật vào bảng "Products" tự động cập nhật
--trường "LastModified" với ngày và giờ hiện tại.


--Bài tập 2: Tạo một trigger "INSTEAD OF DELETE" để kiểm tra xem
--khách hàng có đơn hàng (Orders) không. Nếu có, trigger không cho phép
--xóa khách hàng. Nếu không có đơn hàng liên quan, trigger thực hiện xóa
--khách hàng.


--Bài tập 3: Tạo một trigger trong cơ sở dữ liệu Northwind để kiểm tra và
--không cho phép đặt hàng (Order) với số lượng sản phẩm lớn hơn số lượng
--tồn kho.
