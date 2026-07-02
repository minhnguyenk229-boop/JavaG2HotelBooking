CREATE DATABASE IF NOT EXISTS java_hotel_booking CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE java_hotel_booking;
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS users;
CREATE TABLE users (id INT AUTO_INCREMENT PRIMARY KEY, full_name VARCHAR(120) NOT NULL, email VARCHAR(120) NOT NULL UNIQUE, phone VARCHAR(30), password VARCHAR(120) NOT NULL, role ENUM('ADMIN','EMPLOYEE','CUSTOMER') NOT NULL, status TINYINT DEFAULT 1, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE TABLE rooms (id INT AUTO_INCREMENT PRIMARY KEY, room_number VARCHAR(20) NOT NULL UNIQUE, type VARCHAR(80) NOT NULL, price DECIMAL(12,0) NOT NULL, status VARCHAR(30) NOT NULL DEFAULT 'Trống', image VARCHAR(120), description TEXT) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE TABLE bookings (id INT AUTO_INCREMENT PRIMARY KEY, user_id INT NOT NULL, room_id INT NOT NULL, check_in DATE NOT NULL, check_out DATE NOT NULL, note TEXT, status VARCHAR(40) DEFAULT 'Chờ xác nhận', payment_status VARCHAR(40) DEFAULT 'Chờ thanh toán', created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY(user_id) REFERENCES users(id), FOREIGN KEY(room_id) REFERENCES rooms(id)) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
INSERT INTO users(full_name,email,phone,password,role,status) VALUES ('Quản trị viên G2','admin@g2hotel.vn','0909999999','123456','ADMIN',1),('Nhân viên mẫu','nhanvien@g2hotel.vn','0909000001','123456','EMPLOYEE',1);
INSERT INTO rooms(room_number,type,price,status,image,description) VALUES
('P101','Tiêu chuẩn',450000,'Trống','1.jpg','Phòng 101 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P102','Superior',650000,'Trống','10.jpg','Phòng 102 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P103','Deluxe',850000,'Trống','11.jpg','Phòng 103 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P104','Gia đình',1100000,'Trống','12.jpg','Phòng 104 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P105','Suite cao cấp',1500000,'Trống','13.jpg','Phòng 105 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P106','Tiêu chuẩn',450000,'Trống','hotel_feture_1.jpg','Phòng 106 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P107','Superior',650000,'Trống','hotel_feture_2.jpg','Phòng 107 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P108','Deluxe',850000,'Trống','hotel_feture_3.jpg','Phòng 108 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P109','Gia đình',1100000,'Trống','img_2.jpg','Phòng 109 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P110','Suite cao cấp',1500000,'Trống','slider-3.jpg','Phòng 110 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P201','Tiêu chuẩn',480000,'Trống','slider-4.jpg','Phòng 201 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P202','Superior',680000,'Trống','slider1.jpg','Phòng 202 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P203','Deluxe',880000,'Trống','slider2.jpg','Phòng 203 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P204','Gia đình',1130000,'Trống','slider3.jpg','Phòng 204 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P205','Suite cao cấp',1530000,'Trống','tab_img_1.jpg','Phòng 205 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P206','Tiêu chuẩn',480000,'Trống','tab_img_2.jpg','Phòng 206 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P207','Superior',680000,'Trống','1.jpg','Phòng 207 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P208','Deluxe',880000,'Trống','10.jpg','Phòng 208 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P209','Gia đình',1130000,'Trống','11.jpg','Phòng 209 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P210','Suite cao cấp',1530000,'Trống','12.jpg','Phòng 210 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P301','Tiêu chuẩn',510000,'Trống','13.jpg','Phòng 301 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P302','Superior',710000,'Trống','hotel_feture_1.jpg','Phòng 302 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P303','Deluxe',910000,'Trống','hotel_feture_2.jpg','Phòng 303 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P304','Gia đình',1160000,'Trống','hotel_feture_3.jpg','Phòng 304 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P305','Suite cao cấp',1560000,'Trống','img_2.jpg','Phòng 305 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P306','Tiêu chuẩn',510000,'Trống','slider-3.jpg','Phòng 306 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P307','Superior',710000,'Trống','slider-4.jpg','Phòng 307 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P308','Deluxe',910000,'Trống','slider1.jpg','Phòng 308 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P309','Gia đình',1160000,'Trống','slider2.jpg','Phòng 309 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P310','Suite cao cấp',1560000,'Trống','slider3.jpg','Phòng 310 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P401','Tiêu chuẩn',540000,'Trống','tab_img_1.jpg','Phòng 401 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P402','Superior',740000,'Trống','tab_img_2.jpg','Phòng 402 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P403','Deluxe',940000,'Trống','1.jpg','Phòng 403 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P404','Gia đình',1190000,'Trống','10.jpg','Phòng 404 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P405','Suite cao cấp',1590000,'Trống','11.jpg','Phòng 405 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P406','Tiêu chuẩn',540000,'Trống','12.jpg','Phòng 406 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P407','Superior',740000,'Trống','13.jpg','Phòng 407 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P408','Deluxe',940000,'Trống','hotel_feture_1.jpg','Phòng 408 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P409','Gia đình',1190000,'Trống','hotel_feture_2.jpg','Phòng 409 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P410','Suite cao cấp',1590000,'Trống','hotel_feture_3.jpg','Phòng 410 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P501','Tiêu chuẩn',570000,'Trống','img_2.jpg','Phòng 501 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P502','Superior',770000,'Trống','slider-3.jpg','Phòng 502 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P503','Deluxe',970000,'Trống','slider-4.jpg','Phòng 503 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P504','Gia đình',1220000,'Trống','slider1.jpg','Phòng 504 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P505','Suite cao cấp',1620000,'Trống','slider2.jpg','Phòng 505 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P506','Tiêu chuẩn',570000,'Trống','slider3.jpg','Phòng 506 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P507','Superior',770000,'Trống','tab_img_1.jpg','Phòng 507 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P508','Deluxe',970000,'Trống','tab_img_2.jpg','Phòng 508 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P509','Gia đình',1220000,'Trống','1.jpg','Phòng 509 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P510','Suite cao cấp',1620000,'Trống','10.jpg','Phòng 510 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P601','Tiêu chuẩn',600000,'Trống','11.jpg','Phòng 601 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P602','Superior',800000,'Trống','12.jpg','Phòng 602 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P603','Deluxe',1000000,'Trống','13.jpg','Phòng 603 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P604','Gia đình',1250000,'Trống','hotel_feture_1.jpg','Phòng 604 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P605','Suite cao cấp',1650000,'Trống','hotel_feture_2.jpg','Phòng 605 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P606','Tiêu chuẩn',600000,'Trống','hotel_feture_3.jpg','Phòng 606 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P607','Superior',800000,'Trống','img_2.jpg','Phòng 607 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P608','Deluxe',1000000,'Trống','slider-3.jpg','Phòng 608 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P609','Gia đình',1250000,'Trống','slider-4.jpg','Phòng 609 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P610','Suite cao cấp',1650000,'Trống','slider1.jpg','Phòng 610 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P701','Tiêu chuẩn',630000,'Trống','slider2.jpg','Phòng 701 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P702','Superior',830000,'Trống','slider3.jpg','Phòng 702 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P703','Deluxe',1030000,'Trống','tab_img_1.jpg','Phòng 703 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P704','Gia đình',1280000,'Trống','tab_img_2.jpg','Phòng 704 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P705','Suite cao cấp',1680000,'Trống','1.jpg','Phòng 705 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P706','Tiêu chuẩn',630000,'Trống','10.jpg','Phòng 706 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P707','Superior',830000,'Trống','11.jpg','Phòng 707 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P708','Deluxe',1030000,'Trống','12.jpg','Phòng 708 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P709','Gia đình',1280000,'Trống','13.jpg','Phòng 709 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P710','Suite cao cấp',1680000,'Trống','hotel_feture_1.jpg','Phòng 710 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P801','Tiêu chuẩn',660000,'Trống','hotel_feture_2.jpg','Phòng 801 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P802','Superior',860000,'Trống','hotel_feture_3.jpg','Phòng 802 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P803','Deluxe',1060000,'Trống','img_2.jpg','Phòng 803 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P804','Gia đình',1310000,'Trống','slider-3.jpg','Phòng 804 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P805','Suite cao cấp',1710000,'Trống','slider-4.jpg','Phòng 805 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P806','Tiêu chuẩn',660000,'Trống','slider1.jpg','Phòng 806 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P807','Superior',860000,'Trống','slider2.jpg','Phòng 807 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P808','Deluxe',1060000,'Trống','slider3.jpg','Phòng 808 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P809','Gia đình',1310000,'Trống','tab_img_1.jpg','Phòng 809 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P810','Suite cao cấp',1710000,'Trống','tab_img_2.jpg','Phòng 810 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P901','Tiêu chuẩn',690000,'Trống','1.jpg','Phòng 901 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P902','Superior',890000,'Trống','10.jpg','Phòng 902 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P903','Deluxe',1090000,'Trống','11.jpg','Phòng 903 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P904','Gia đình',1340000,'Trống','12.jpg','Phòng 904 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P905','Suite cao cấp',1740000,'Trống','13.jpg','Phòng 905 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P906','Tiêu chuẩn',690000,'Trống','hotel_feture_1.jpg','Phòng 906 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P907','Superior',890000,'Trống','hotel_feture_2.jpg','Phòng 907 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P908','Deluxe',1090000,'Trống','hotel_feture_3.jpg','Phòng 908 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P909','Gia đình',1340000,'Trống','img_2.jpg','Phòng 909 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P910','Suite cao cấp',1740000,'Trống','slider-3.jpg','Phòng 910 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P1001','Tiêu chuẩn',720000,'Trống','slider-4.jpg','Phòng 1001 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P1002','Superior',920000,'Trống','slider1.jpg','Phòng 1002 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P1003','Deluxe',1120000,'Trống','slider2.jpg','Phòng 1003 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P1004','Gia đình',1370000,'Trống','slider3.jpg','Phòng 1004 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P1005','Suite cao cấp',1770000,'Trống','tab_img_1.jpg','Phòng 1005 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P1006','Tiêu chuẩn',720000,'Trống','tab_img_2.jpg','Phòng 1006 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P1007','Superior',920000,'Trống','1.jpg','Phòng 1007 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P1008','Deluxe',1120000,'Trống','10.jpg','Phòng 1008 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P1009','Gia đình',1370000,'Trống','11.jpg','Phòng 1009 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.'),
('P1010','Suite cao cấp',1770000,'Trống','12.jpg','Phòng 1010 tại G2 Hotel, không gian sạch đẹp, wifi miễn phí, điều hòa, TV, phòng tắm riêng và dịch vụ lễ tân 24/7.');
ALTER TABLE bookings ADD COLUMN customer_name VARCHAR(120) AFTER payment_status;
ALTER TABLE bookings ADD COLUMN customer_phone VARCHAR(30) AFTER customer_name;
ALTER TABLE bookings ADD COLUMN customer_email VARCHAR(120) AFTER customer_phone;
ALTER TABLE bookings ADD COLUMN payment_method VARCHAR(60) DEFAULT 'Chuyển khoản ngân hàng' AFTER customer_email;
ALTER TABLE bookings ADD COLUMN total_amount DECIMAL(12,0) DEFAULT 0 AFTER payment_method;
USE java_hotel_booking;
SET @db_name = DATABASE();

SET @sql = (
    SELECT IF(COUNT(*) = 0,
        'ALTER TABLE bookings ADD COLUMN customer_name VARCHAR(120) NULL AFTER payment_status',
        'SELECT "customer_name already exists"'
    )
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = @db_name AND TABLE_NAME = 'bookings' AND COLUMN_NAME = 'customer_name'
);
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql = (
    SELECT IF(COUNT(*) = 0,
        'ALTER TABLE bookings ADD COLUMN customer_phone VARCHAR(30) NULL AFTER customer_name',
        'SELECT "customer_phone already exists"'
    )
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = @db_name AND TABLE_NAME = 'bookings' AND COLUMN_NAME = 'customer_phone'
);
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql = (
    SELECT IF(COUNT(*) = 0,
        'ALTER TABLE bookings ADD COLUMN customer_email VARCHAR(120) NULL AFTER customer_phone',
        'SELECT "customer_email already exists"'
    )
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = @db_name AND TABLE_NAME = 'bookings' AND COLUMN_NAME = 'customer_email'
);
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql = (
    SELECT IF(COUNT(*) = 0,
        'ALTER TABLE bookings ADD COLUMN payment_method VARCHAR(80) DEFAULT "Chuyển khoản ngân hàng" AFTER customer_email',
        'SELECT "payment_method already exists"'
    )
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = @db_name AND TABLE_NAME = 'bookings' AND COLUMN_NAME = 'payment_method'
);
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql = (
    SELECT IF(COUNT(*) = 0,
        'ALTER TABLE bookings ADD COLUMN total_amount DECIMAL(12,0) DEFAULT 0 AFTER payment_method',
        'SELECT "total_amount already exists"'
    )
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = @db_name AND TABLE_NAME = 'bookings' AND COLUMN_NAME = 'total_amount'
);
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;


UPDATE bookings b
JOIN rooms r ON b.room_id = r.id
SET b.total_amount = r.price * GREATEST(DATEDIFF(b.check_out, b.check_in), 1)
WHERE b.total_amount IS NULL OR b.total_amount = 0;


SET @sql = (
    SELECT IF(COUNT(*) = 0,
        'CREATE INDEX idx_bookings_payment_status ON bookings(payment_status)',
        'SELECT "idx_bookings_payment_status already exists"'
    )
    FROM INFORMATION_SCHEMA.STATISTICS
    WHERE TABLE_SCHEMA = @db_name AND TABLE_NAME = 'bookings' AND INDEX_NAME = 'idx_bookings_payment_status'
);
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql = (
    SELECT IF(COUNT(*) = 0,
        'CREATE INDEX idx_bookings_status ON bookings(status)',
        'SELECT "idx_bookings_status already exists"'
    )
    FROM INFORMATION_SCHEMA.STATISTICS
    WHERE TABLE_SCHEMA = @db_name AND TABLE_NAME = 'bookings' AND INDEX_NAME = 'idx_bookings_status'
);
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql = (
    SELECT IF(COUNT(*) = 0,
        'CREATE INDEX idx_bookings_created_at ON bookings(created_at)',
        'SELECT "idx_bookings_created_at already exists"'
    )
    FROM INFORMATION_SCHEMA.STATISTICS
    WHERE TABLE_SCHEMA = @db_name AND TABLE_NAME = 'bookings' AND INDEX_NAME = 'idx_bookings_created_at'
);
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;


SELECT COALESCE(SUM(total_amount),0) AS tong_doanh_thu_da_thanh_toan
FROM bookings
WHERE payment_status = 'Đã thanh toán' AND status <> 'Đã hủy';
USE java_hotel_booking;

SET SQL_SAFE_UPDATES = 0;

UPDATE bookings b
JOIN rooms r ON b.room_id = r.id
SET b.total_amount = r.price * GREATEST(DATEDIFF(b.check_out, b.check_in), 1)
WHERE b.id > 0
  AND (b.total_amount IS NULL OR b.total_amount = 0);

SET SQL_SAFE_UPDATES = 1;

SELECT id, room_id, check_in, check_out, total_amount
FROM bookings;

USE java_hotel_booking;

SET SQL_SAFE_UPDATES = 0;

UPDATE bookings b
JOIN rooms r ON b.room_id = r.id
SET b.total_amount = r.price * GREATEST(DATEDIFF(b.check_out, b.check_in), 1)
WHERE b.id > 0
  AND (b.total_amount IS NULL OR b.total_amount = 0);

SET SQL_SAFE_UPDATES = 1;

USE java_hotel_booking;

SELECT 
    b.id AS ma_don,
    u.full_name AS khach_hang,
    r.room_number AS phong,
    r.type AS loai_phong,
    b.check_in,
    b.check_out,
    b.payment_method,
    b.payment_status,
    b.status,
    b.total_amount
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN rooms r ON b.room_id = r.id
WHERE b.payment_status = 'Đã thanh toán'
  AND b.status <> 'Đã hủy'
ORDER BY b.created_at DESC;



-- Tổng doanh thu tất cả đơn đã thanh toán
SELECT 
    COALESCE(SUM(total_amount), 0) AS tong_doanh_thu
FROM bookings
WHERE payment_status = 'Đã thanh toán'
  AND status <> 'Đã hủy';


-- Doanh thu theo ngày
SELECT 
    DATE(created_at) AS ngay,
    COUNT(*) AS so_don,
    COALESCE(SUM(total_amount), 0) AS doanh_thu
FROM bookings
WHERE payment_status = 'Đã thanh toán'
  AND status <> 'Đã hủy'
GROUP BY DATE(created_at)
ORDER BY ngay DESC;


-- Doanh thu theo tháng
SELECT 
    DATE_FORMAT(created_at, '%Y-%m') AS thang,
    COUNT(*) AS so_don,
    COALESCE(SUM(total_amount), 0) AS doanh_thu
FROM bookings
WHERE payment_status = 'Đã thanh toán'
  AND status <> 'Đã hủy'
GROUP BY DATE_FORMAT(created_at, '%Y-%m')
ORDER BY thang DESC;