﻿﻿Create Database QLBONGDA;
GO
USE QLBONGDA;
GO

CREATE TABLE QUOCGIA(
	MAQG VARCHAR(5) NOT NULL PRIMARY KEY,
	TENQG NVARCHAR(60) NOT NULL
);

CREATE TABLE TINH(
	MATINH VARCHAR(5) NOT NULL PRIMARY KEY,
	TENTINH NVARCHAR(100) NOT NULL
);

CREATE TABLE SANVD(
	MASAN VARCHAR(5) NOT NULL PRIMARY KEY,
	TENSAN NVARCHAR(100) NOT NULL,
	DIACHI NVARCHAR(200)
);

CREATE TABLE CAULACBO(
	MACLB VARCHAR(5) NOT NULL PRIMARY KEY,
	TENCLB NVARCHAR(100) NOT NULL,
	MASAN VARCHAR(5) NOT NULL,
	MATINH VARCHAR(5) NOT NULL,
	FOREIGN KEY (MASAN) REFERENCES SANVD (MASAN),
	FOREIGN KEY (MATINH) REFERENCES TINH (MATINH)
);

CREATE TABLE CAUTHU(
	MACT NUMERIC IDENTITY(1,1) NOT NULL PRIMARY KEY,
	HOTEN NVARCHAR(100) NOT NULL,
	VITRI NVARCHAR(20) NOT NULL,
	NGAYSINH DATETIME,
	DIACHI NVARCHAR(200),
	MACLB VARCHAR(5) NOT NULL,
	MAQG VARCHAR(5) NOT NULL,
	SO INT NOT NULL,
	FOREIGN KEY (MAQG) REFERENCES QUOCGIA (MAQG),
	FOREIGN KEY (MACLB) REFERENCES CAULACBO (MACLB)
);

CREATE TABLE HUANLUYENVIEN(
	MAHLV VARCHAR(5) NOT NULL PRIMARY KEY,
	TENHLV NVARCHAR(100) NOT NULL,
	NGAYSINH DATETIME,
	DIACHI NVARCHAR(200),
	DIENTHOAI NVARCHAR(20),
	MAQG VARCHAR(5) NOT NULL,
	FOREIGN KEY (MAQG) REFERENCES QUOCGIA(MAQG)
);

CREATE TABLE HLV_CLB(
	MAHLV VARCHAR(5) NOT NULL,
	MACLB VARCHAR(5) NOT NULL,
	VAITRO NVARCHAR(100) NOT NULL,
	PRIMARY KEY(MAHLV, MACLB),
	FOREIGN KEY (MACLB) REFERENCES CAULACBO (MACLB),
	FOREIGN KEY (MAHLV) REFERENCES HUANLUYENVIEN (MAHLV)
);

CREATE TABLE TRANDAU(
	MATRAN NUMERIC IDENTITY NOT NULL PRIMARY KEY,
	NAM INT NOT NULL,
	VONG INT NOT NULL,
	NGAYTD DATETIME NOT NULL,
	MACLB1 VARCHAR(5) NOT NULL,
	MACLB2 VARCHAR(5) NOT NULL,
	MASAN VARCHAR(5) NOT NULL,
	KETQUA VARCHAR(5) NOT NULL,
	FOREIGN KEY (MACLB1) REFERENCES CAULACBO (MACLB),
	FOREIGN KEY (MACLB1) REFERENCES CAULACBO (MACLB),
	FOREIGN KEY (MASAN) REFERENCES SANVD (MASAN)
);

CREATE TABLE BANGXH(
	MACLB VARCHAR(5) NOT NULL,
	NAM INT NOT NULL,
	VONG INT NOT NULL,
	SOTRAN INT NOT NULL,
	THANG INT NOT NULL,
	HOA INT NOT NULL,
	THUA INT NOT NULL,
	HIEUSO VARCHAR(5) NOT NULL,
	DIEM INT NOT NULL,
	HANG INT NOT NULL,
	PRIMARY KEY(MACLB, NAM, VONG),
	FOREIGN KEY (MACLB) REFERENCES CAULACBO (MACLB)
);

INSERT INTO QUOCGIA VALUES('ANH',N'Anh Quốc');
INSERT INTO QUOCGIA VALUES('BDN',N'Bồ Đào Nha');
INSERT INTO QUOCGIA VALUES('BRA',N'Bra-xin');
INSERT INTO QUOCGIA VALUES('ITA',N'Ý');
INSERT INTO QUOCGIA VALUES('TBN',N'Tây Ban Nha');
INSERT INTO QUOCGIA VALUES('THA',N'Thái Lan');
INSERT INTO QUOCGIA VALUES('THAI',N'Thái Lan');
INSERT INTO QUOCGIA VALUES('VN',N'Việt Nam');

INSERT INTO TINH VALUES('BD',N'Bình Dương');
INSERT INTO TINH VALUES('DN',N'Đà Nẵng');
INSERT INTO TINH VALUES('GL',N'Gia Lai');
INSERT INTO TINH VALUES('KH',N'Khánh Hòa');
INSERT INTO TINH VALUES('LA',N'Long An');
INSERT INTO TINH VALUES('PY',N'Phú Yên');

INSERT INTO SANVD VALUES('CL',N'Chi Lăng',N'127 Võ Văn Tần, Đà Nẵng');
INSERT INTO SANVD VALUES('GD',N'Gò Đậu',N'123 QL1, TX Thủ Dầu Một, Bình Dương');
INSERT INTO SANVD VALUES('LA',N'Long An',N'102 Hùng Vương, Tp Tân An, Long An');
INSERT INTO SANVD VALUES('NT',N'Nha Trang',N'128 Phan Chu Trinh, Nha Trang, Khánh Hòa');
INSERT INTO SANVD VALUES('PL',N'Pleiku',N'22 Hồ Tùng Mậu, Thống Nhất, Thị xã Pleiku, Gia Lai');
INSERT INTO SANVD VALUES('TH',N'Tuy Hòa',N'57 Trường Chinh, Tuy Hòa, Phú Yên');

INSERT INTO CAULACBO VALUES('BBD',N'BECAMEX BÌNH DƯƠNG','GD','BD');
INSERT INTO CAULACBO VALUES('GDT',N'GẠCH ĐỒNG TÂM LONG AN','LA','LA');
INSERT INTO CAULACBO VALUES('HAGL',N'HOÀNG ANH GIA LAI','PL','GL');
INSERT INTO CAULACBO VALUES('KKH',N'KHATOCO KHÁNH HÒA','NT','KH');
INSERT INTO CAULACBO VALUES('SDN',N'SHB ĐÀ NẴNG','CL','DN');
INSERT INTO CAULACBO VALUES('TPY',N'THÉP PHÚ YÊN','TH','PY');

INSERT INTO CAUTHU VALUES(N'Nguyễn Vũ Phong',N'Tiền vệ','1990-02-20 00:00:00.000','','BBD','VN','17');
INSERT INTO CAUTHU VALUES(N'Nguyễn Công Vinh',N'Tiền đạo','1992-03-10 00:00:00.000','NULL','HAGL','VN','9');
INSERT INTO CAUTHU VALUES(N'Trần Tấn Tài',N'Tiền vệ','1989-11-12 00:00:00.000','NULL','BBD','VN','8');
INSERT INTO CAUTHU VALUES(N'Phan Hồng Sơn',N'Thủ môn','1991-06-10 00:00:00.000','NULL','HAGL','VN','1');
INSERT INTO CAUTHU VALUES(N'Ronaldo',N'Tiền vệ','1989-12-12 00:00:00.000','NULL','SDN','BRA','7');
INSERT INTO CAUTHU VALUES(N'Robinho',N'Tiền vệ','1989-10-12 00:00:00.000','NULL','SDN','BRA','8');
INSERT INTO CAUTHU VALUES(N'Vidic',N'Hậu vệ','1987-10-15 00:00:00.000','NULL','HAGL','ANH','3');
INSERT INTO CAUTHU VALUES(N'Trần Văn Santos',N'Thủ môn','1990-10-21 00:00:00.000','NULL','BBD','BRA','1');
INSERT INTO CAUTHU VALUES(N'Nguyễn Trường Sơn',N'Hậu vệ','1993-08-26 00:00:00.000','NULL','BBD','VN','4');

INSERT INTO HUANLUYENVIEN VALUES('HLV01',N'Vital','1955-10-15 00:00:00.000','NULL','918011075','BDN');
INSERT INTO HUANLUYENVIEN VALUES('HLV02',N'Lê Huỳnh Đức','1972-05-20 00:00:00.000','NULL','1223456789','VN');
INSERT INTO HUANLUYENVIEN VALUES('HLV03',N'Kiatisuk','1970-12-11 00:00:00.000','NULL','1990123456','THA');
INSERT INTO HUANLUYENVIEN VALUES('HLV04',N'Hoàng Anh Tuấn','1970-06-10 00:00:00.000','NULL','989112233','VN');
INSERT INTO HUANLUYENVIEN VALUES('HLV05',N'Trần Công Minh','1973-07-07 00:00:00.000','NULL','909099990','VN');
INSERT INTO HUANLUYENVIEN VALUES('HLV06',N'Trần Văn Phúc','1965-03-02 00:00:00.000','NULL','1650101234','VN');

INSERT INTO HLV_CLB VALUES('HLV01','BBD',N'HLV Chính');
INSERT INTO HLV_CLB VALUES('HLV02','SDN',N'HLV Chính');
INSERT INTO HLV_CLB VALUES('HLV03','HAGL',N'HLV Chính');
INSERT INTO HLV_CLB VALUES('HLV04','KKH',N'HLV Chính');
INSERT INTO HLV_CLB VALUES('HLV05','GDT',N'HLV Chính');
INSERT INTO HLV_CLB VALUES('HLV06','BBD',N'HLV Thủ môn');

INSERT INTO TRANDAU VALUES(2009,'1','2009-02-07 00:00:00.000','BBD','SDN','GD','3-0');
INSERT INTO TRANDAU VALUES(2009,'1','2009-02-07 00:00:00.000','KKH','GDT','NT','1-1');
INSERT INTO TRANDAU VALUES(2009,'2','2009-02-16 00:00:00.000','SDN','KKH','CL','2-2');
INSERT INTO TRANDAU VALUES(2009,'2','2009-02-16 00:00:00.000','TPY','BBD','TH','5-0');
INSERT INTO TRANDAU VALUES(2009,'3','2009-03-01 00:00:00.000','TPY','GDT','TH','0-2');
INSERT INTO TRANDAU VALUES(2009,'3','2009-03-01 00:00:00.000','KKH','BBD','NT','0-1');
INSERT INTO TRANDAU VALUES(2009,'4','2009-03-07 00:00:00.000','KKH','TPY','NT','1-0');
INSERT INTO TRANDAU VALUES(2009,'4','2009-03-07 00:00:00.000','BBD','GDT','GD','2-2');

INSERT INTO BANGXH VALUES('BBD',2009,'1','1','1','0','0','3-0','3','1');
INSERT INTO BANGXH VALUES('BBD',2009,'2','2','1','0','1','3-5','3','2');
INSERT INTO BANGXH VALUES('BBD',2009,'3','3','2','0','1','4-5','6','1');
INSERT INTO BANGXH VALUES('BBD',2009,'4','4','2','1','1','6-7','7','1');
INSERT INTO BANGXH VALUES('GDT',2009,'1','1','0','1','0','1-1','1','3');
INSERT INTO BANGXH VALUES('GDT',2009,'2','1','0','1','0','1-1','1','4');
INSERT INTO BANGXH VALUES('GDT',2009,'3','2','1','1','0','3-1','4','2');
INSERT INTO BANGXH VALUES('GDT',2009,'4','3','1','2','0','5-1','5','2');
INSERT INTO BANGXH VALUES('KKH',2009,'1','1','0','1','0','1-1','1','2');
INSERT INTO BANGXH VALUES('KKH',2009,'2','2','0','2','0','3-3','2','3');
INSERT INTO BANGXH VALUES('KKH',2009,'3','3','0','2','1','3-4','2','4');
INSERT INTO BANGXH VALUES('KKH',2009,'4','4','1','2','1','4-4','5','3');
INSERT INTO BANGXH VALUES('SDN',2009,'1','1','0','0','1','0-3','0','5');
INSERT INTO BANGXH VALUES('SDN',2009,'2','2','1','1','0','2-5','1','5');
INSERT INTO BANGXH VALUES('SDN',2009,'3','2','1','1','0','2-5','1','5');
INSERT INTO BANGXH VALUES('SDN',2009,'4','2','1','1','0','2-5','1','5');
INSERT INTO BANGXH VALUES('TPY',2009,'1','0','0','0','0','0-0','0','4');
INSERT INTO BANGXH VALUES('TPY',2009,'2','1','1','0','0','5-0','3','1');
INSERT INTO BANGXH VALUES('TPY',2009,'3','2','1','0','1','5-2','3','3');
INSERT INTO BANGXH VALUES('TPY',2009,'4','3','1','0','2','5-3','3','4');
