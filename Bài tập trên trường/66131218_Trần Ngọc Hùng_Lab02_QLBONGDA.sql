﻿CREATE DATABASE QLBONGDA;
GO
USE QLBONGDA;
GO

CREATE TABLE CAUTHU(
	MACT NUMERIC IDENTITY(1,1) NOT NULL PRIMARY KEY,
	HOTEN NVARCHAR(100) NOT NULL,
	VITRI NVARCHAR(20) NOT NULL,
	NGAYSINH DATETIME,
	DIACHI NVARCHAR(200),
	MACLB VARCHAR(5) NOT NULL,
	MAQG VARCHAR(5) NOT NULL,
	SO INT NOT NULL
);

CREATE TABLE QUOCGIA(
	MAQG VARCHAR(5) NOT NULL PRIMARY KEY,
	TENQG NVARCHAR(60) NOT NULL
);

CREATE TABLE CAULACBO(
	MACLB VARCHAR(5) NOT NULL PRIMARY KEY,
	TENCLB NVARCHAR(100) NOT NULL,
	MASAN VARCHAR(5) NOT NULL,
	MATINH VARCHAR(5) NOT NULL
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

CREATE TABLE HUANLUYENVIEN(
	MAHLV VARCHAR(5) NOT NULL PRIMARY KEY,
	TENHLV NVARCHAR(100) NOT NULL,
	NGAYSINH DATETIME,
	DIACHI NVARCHAR(200),
	DIENTHOAI NVARCHAR(20),
	MAQG VARCHAR(5) NOT NULL
);

CREATE TABLE HLV_CLB(
	MAHLV VARCHAR(5) NOT NULL,
	MACLB VARCHAR(5) NOT NULL,
	VAITRO NVARCHAR(100) NOT NULL,
	PRIMARY KEY(MAHLV, MACLB),
	FOREIGN KEY (MACLB) REFERENCES CAULACBO (MACLB)
);

CREATE TABLE TRANDAU(
	MATRAN NUMERIC IDENTITY(1,1) NOT NULL PRIMARY KEY,
	NAM INT NOT NULL,
	VONG INT NOT NULL,
	NGAYTD DATETIME NOT NULL,
	MACLB1 VARCHAR(5) NOT NULL,
	MACLB2 VARCHAR(5) NOT NULL,
	MASAN VARCHAR(5) NOT NULL,
	KETQUA VARCHAR(5) NOT NULL
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

INSERT INTO TINH VALUES('MATINH','TENTINH');
INSERT INTO TINH VALUES('BD','Bình Dương');
INSERT INTO TINH VALUES('DN','Đà Nẵng');
INSERT INTO TINH VALUES('GL','Gia Lai');
INSERT INTO TINH VALUES('KH','Khánh Hòa');
INSERT INTO TINH VALUES('LA','Long An');
INSERT INTO TINH VALUES('PY','Phú Yên');

INSERT INTO TINH(MATINH, TENTINH) 
VALUES
	('MATINH','TENTINH'),
	('BD','Bình Dương'),
	('DN','Đà Nẵng'),
	('GL','Gia Lai'),
	('KH','Khánh Hòa'),
	('LA','Long An'),
	('PY','Phú Yên');