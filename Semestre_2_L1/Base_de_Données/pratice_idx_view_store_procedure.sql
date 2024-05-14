-- Tạo cơ sở dữ liệu demo
DROP DATABASE IF EXISTS DemoDB;
CREATE DATABASE DemoDB;
USE DemoDB;

-- Tạo bảng Products với các trường dữ liệu
CREATE TABLE Products (
	Id INT AUTO_INCREMENT PRIMARY KEY,            -- Mã sản phẩm (Khóa chính)
	productCode VARCHAR(50) NOT NULL,             -- Mã sản phẩm (Unique Index)
	productName VARCHAR(100) NOT NULL,            -- Tên sản phẩm
	productPrice DECIMAL(10, 2) NOT NULL,         -- Giá sản phẩm
	productAmount INT NOT NULL,                   -- Số lượng sản phẩm
	productDescription TEXT,                      -- Mô tả sản phẩm
	productStatus BIT NOT NULL                    -- Trạng thái sản phẩm (0: không hoạt động, 1: hoạt động)
);

-- Chèn dữ liệu mẫu vào bảng Products
INSERT INTO Products (productCode, productName, productPrice, productAmount, productDescription, productStatus)
VALUES
	('P001', 'Laptop', 1000.00, 10, 'High-performance laptop', 1),
	('P002', 'Smartphone', 500.00, 20, 'Latest model smartphone', 1),
	('P003', 'Tablet', 300.00, 15, 'Compact and portable tablet', 1),
	('P004', 'Headphones', 50.00, 50, 'Noise-cancelling headphones', 1),
	('P005', 'Keyboard', 30.00, 25, 'Mechanical keyboard', 1);

-- Tạo Unique Index trên productCode để đảm bảo giá trị duy nhất
CREATE UNIQUE INDEX idx_productCode ON Products (productCode);

-- Tạo Composite Index trên productName và productPrice để tăng hiệu năng truy vấn
CREATE INDEX idx_productName_price ON Products (productName, productPrice);

-- Sử dụng EXPLAIN để kiểm tra truy vấn trước và sau khi tạo Index
-- Truy vấn trước khi tạo Index
EXPLAIN SELECT * FROM Products WHERE productName = 'Laptop' AND productPrice = 1000.00;

-- Truy vấn sau khi tạo Index
EXPLAIN SELECT * FROM Products WHERE productName = 'Laptop' AND productPrice = 1000.00;

-- Tạo View để lấy các thông tin tóm tắt từ bảng Products
CREATE VIEW vw_Products AS
SELECT productCode, productName, productPrice, productStatus
FROM Products;

-- Sửa đổi View để bổ sung thông tin productAmount
CREATE OR REPLACE VIEW vw_Products AS
SELECT productCode, productName, productPrice, productAmount, productStatus
FROM Products;

-- Xóa View khi không cần sử dụng nữa
DROP VIEW vw_Products;

-- Tạo Stored Procedure để lấy tất cả thông tin sản phẩm
DELIMITER $$
CREATE PROCEDURE GetAllProducts()
BEGIN
	SELECT * FROM Products;
END$$
DELIMITER ;

-- Tạo Stored Procedure để thêm một sản phẩm mới
DELIMITER $$
CREATE PROCEDURE AddProduct(
	IN pCode VARCHAR(50),
	IN pName VARCHAR(100),
	IN pPrice DECIMAL(10, 2),
	IN pAmount INT,
	IN pDescription TEXT,
	IN pStatus BIT
)
BEGIN
	INSERT INTO Products (productCode, productName, productPrice, productAmount, productDescription, productStatus)
	VALUES (pCode, pName, pPrice, pAmount, pDescription, pStatus);
END$$
DELIMITER ;

-- Tạo Stored Procedure để sửa thông tin sản phẩm theo Id
DELIMITER $$
CREATE PROCEDURE UpdateProduct(
	IN pId INT,
	IN pName VARCHAR(100),
	IN pPrice DECIMAL(10, 2),
	IN pAmount INT,
	IN pDescription TEXT,
	IN pStatus BIT
)
BEGIN
	UPDATE Products
	SET productName = pName, productPrice = pPrice, productAmount = pAmount, productDescription = pDescription, productStatus = pStatus
	WHERE Id = pId;
END$$
DELIMITER ;

-- Tạo Stored Procedure để xóa sản phẩm theo Id
DELIMITER $$
CREATE PROCEDURE DeleteProduct(IN pId INT)
BEGIN
	DELETE FROM Products WHERE Id = pId;
END$$
DELIMITER ;

-- Gọi các Stored Procedure để kiểm tra
-- Lấy tất cả thông tin sản phẩm
CALL GetAllProducts();

-- Thêm một sản phẩm mới
CALL AddProduct('P006', 'Monitor', 200.00, 10, 'HD monitor', 1);

-- Sửa thông tin sản phẩm
CALL UpdateProduct(1, 'Gaming Laptop', 1200.00, 5, 'High-end gaming laptop', 1);

-- Xóa sản phẩm theo Id
CALL DeleteProduct(5);

