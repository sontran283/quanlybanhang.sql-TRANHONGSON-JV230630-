CREATE DATABASE quan_ly_ban_hang;
USE quan_ly_ban_hang;

CREATE TABLE CUSTOMERS(
customer_id varchar(4) primary key not null,
name varchar(100) not null,
email varchar(100) not null unique,
phone varchar(25) not null unique,
address varchar(255) not null
);

CREATE TABLE ORDERS(
order_id varchar(4) primary key not null,
customer_id varchar(4) not null,
foreign key (customer_id) references CUSTOMERS(customer_id),
order_date date not null,
total_amount double not null
);

CREATE TABLE PRODUCTS(
product_id varchar(4) primary key not null,
name varchar(255) not null,
description text,
price double not null,
status bit default 1 not null
);

CREATE TABLE ORDERS_DETAILS(
order_id varchar(4) not null,
foreign key (order_id) references ORDERS(order_id),
product_id varchar(4) not null,
foreign key (product_id) references PRODUCTS(product_id),
price double not null,
quantity int(11) not null,
primary key(order_id,product_id)
);

-- Bài 2: Thêm dữ liệu [20 điểm]:
-- Bài 2: Thêm dữ liệu [20 điểm]:
-- Bài 2: Thêm dữ liệu [20 điểm]:

insert into CUSTOMERS(customer_id,name,email,phone,address)values('C001','Nguyễn Trung Mạnh','manhnt@gmail.com','984756322','Cầu Giấy,Hà Nội');
insert into CUSTOMERS(customer_id,name,email,phone,address)values('C002','Hồ Hải Nam','namhh@gmail.com','984875926','Ba Vì,Hà Nội');
insert into CUSTOMERS(customer_id,name,email,phone,address)values('C003','Tô Ngọc Vũ','vutn@gmail.com','904725784','Mộc Châu,Sơn La');
insert into CUSTOMERS(customer_id,name,email,phone,address)values('C004','Phạm Ngọc Anh','anhpn@gmail.com','984635365','Vinh,Nghệ An');
insert into CUSTOMERS(customer_id,name,email,phone,address)values('C005','Trương Minh Cường','cuongtm@gmail.com','989735624','Hai Bà Trưng,Hà Nội');
    
insert into PRODUCTS(product_id,name,description,price)values('P001','Iphone 13 ProMax','Bản 512 GB,xanh lá','22999999');
insert into PRODUCTS(product_id,name,description,price)values('P002','Dell Vostro V3510','Core i5 ,RAM 8GB','14999999');
insert into PRODUCTS(product_id,name,description,price)values('P003','Macbook Pro M2','8CPU 10GPU 8GB 256GB','28999999');
insert into PRODUCTS(product_id,name,description,price)values('P004','Apple Watch Ultra','Titanium Alpine Lôp Small','18999999');
insert into PRODUCTS(product_id,name,description,price)values('P005','Airpods 2 2022','Spatial Audio','4090000');

insert into ORDERS values
	('H001','C001','2023/2/22',52999997),
    ('H002','C001','2023/3/11',80999997),
    ('H003','C002','2023/1/22',54359998),
    ('H004','C003','2023/3/14',102999995),
    ('H005','C003','2022/3/12',80999997),
    ('H006','C004','2023/2/1',110449994),
    ('H007','C004','2023/3/29',79999996),
    ('H008','C005','2023/2/14',29999998),
    ('H009','C005','2023/1/10',28999999),
    ('H010','C005','2023/4/1',149999994);
    
INSERT INTO ORDERS_DETAILS (order_id,product_id,price,quantity) VALUES
	('H001','P002',14999999,1),
    ('H001','P004',18999999,2),
    ('H002','P001',22999999,1),
    ('H002','P003',28999999,2),
    ('H003','P004',18999999,2),
    ('H003','P005',4090000,4),
    ('H004','P002',14999999,3),
    ('H004','P003',28999999,2),
    ('H005','P001',22999999,1),
    ('H005','P003',28999999,2),
    ('H006','P005',4090000,5),
    ('H006','P002',14999999,6),
    ('H007','P004',18999999,3),
    ('H007','P001',22999999,1),
    ('H008','P002',14999999,2),
    ('H009','P003',28999999,1),
    ('H010','P003',28999999,2),
    ('H010','P001',22999999,4);

-- Bài 3: Truy vấn dữ liệu [30 điểm]:
-- Bài 3: Truy vấn dữ liệu [30 điểm]:
-- Bài 3: Truy vấn dữ liệu [30 điểm]:
-- 1. Lấy ra tất cả thông tin gồm: tên, email, số điện thoại và địa chỉ trong bảng Customers  [4 điểm]
select name, email, phone, address from CUSTOMERS;

-- 2. Thống kê những khách hàng mua hàng trong tháng 3/2023 (thông tin bao gồm tên, số điện thoại và địa chỉ khách hàng). [4 điểm]
select name, phone, address from CUSTOMERS
where customer_id in (
    select customer_id
    from Orders
    where month(order_date) = 3 and year(order_date) = 2023
);

-- 3. Thống kê doanh thua theo từng tháng của cửa hàng trong năm 2023 (thông tin bao gồm tháng và tổng doanh thu ). [4 điểm]
select month(order_date) as month, sum(total_amount) as tong_doanh_thu
from ORDERS
where year(order_date) = 2023
group by month(order_date);

-- 4. Thống kê những người dùng không mua hàng trong tháng 2/2023 (thông tin gồm tên khách hàng, địa chỉ , email và số điên thoại). [4 điểm]
select name, address, email, phone
from CUSTOMERS
where customer_id not in (
    select customer_id
    from Orders
    where month(order_date) = 2 and year(order_date) = 2023
);

-- 5. Thống kê số lượng từng sản phẩm được bán ra trong tháng 3/2023 (thông tin bao gồm mã sản phẩm, tên sản phẩm và số lượng bán ra). [4 điểm]
select P.product_id, P.name, sum(OD.quantity) as so_luong_ban_ra
from PRODUCTS P
join ORDERS_DETAILS OD on P.product_id = OD.product_id
join ORDERS O on OD.order_id = O.order_id
where month(O.order_date) = 3 and year(O.order_date) = 2023
group by P.product_id, P.name;

-- 6. Thống kê tổng chi tiêu của từng khách hàng trong năm 2023 sắp xếp giảm dần theo mức chi tiêu (thông tin bao gồm mã khách hàng, tên khách hàng và mức chi tiêu). [5 điểm]
select C.customer_id, C.name, sum(o.total_amount) as muc_chi
from ORDERS O
join CUSTOMERS C on O.customer_id = C.customer_id
where year(order_date) = 2023
group by C.customer_id, C.name
order by muc_chi desc;

-- 7. Thống kê những đơn hàng mà tổng số lượng sản phẩm mua từ 5 trở lên (thông tin bao gồm tên người mua, tổng tiền , ngày tạo hoá đơn, tổng số lượng sản phẩm) . [5 điểm]
select C.name, O.total_amount, O.order_date, sum(OD.quantity) as tong_sl_san_pham
from CUSTOMERS C
join ORDERS O on C.customer_id = O.customer_id
join ORDERS_DETAILS OD on O.order_id = OD.order_id
group by O.order_id, C.name, O.total_amount, O.order_date
having tong_sl_san_pham >= 5;



-- Bài 4: Tạo View, Procedure [30 điểm]:
-- Bài 4: Tạo View, Procedure [30 điểm]:
-- Bài 4: Tạo View, Procedure [30 điểm]:
-- 1. Tạo VIEW lấy các thông tin hoá đơn bao gồm : Tên khách hàng, số điện thoại, địa chỉ, tổng tiền và ngày tạo hoá đơn . [3 điểm]
create view THONG_TIN_DON_HANG as
select C.name, C.phone, C.address, O.total_amount, O.order_date
from CUSTOMERS C
join Orders O on C.customer_id = O.customer_id;

-- 2. Tạo VIEW hiển thị thông tin khách hàng gồm : tên khách hàng, địa chỉ, số điện thoại và tổng số đơn đã đặt. [3 điểm]
create view THONG_TIN_KHACH_HANG as
select C.name, C.address, C.phone, count(O.order_id) as tong_so_don_da_dat
from CUSTOMERS C
left join Orders O on C.customer_id = O.customer_id
group by C.name, C.address, C.phone;

-- 3. Tạo VIEW hiển thị thông tin sản phẩm gồm: tên sản phẩm, mô tả, giá và tổng số lượng đã bán ra của mỗi sản phẩm.[3 điểm]
create view THONG_TIN_SAN_PHAM as
select P.name, P.description, P.price, sum(OD.quantity) as tong_sl_da_ban
from PRODUCTS P
left join ORDERS_DETAILS OD on P.product_id = OD.product_id
group by P.name, P.description, P.price;

-- 4. Đánh Index cho trường `phone` và `email` của bảng Customer. [3 điểm]
create index phone_index on CUSTOMERS(phone);
create index email_index on CUSTOMERS(email);

-- 5. Tạo PROCEDURE lấy tất cả thông tin của 1 khách hàng dựa trên mã số khách hàng.[3 điểm]
delimiter //
create procedure LAY_THONG_TIN_KH(in customer_id_new varchar(4))
begin
    select * from CUSTOMERS
    where customer_id = customer_id_new;
end;
//
call LAY_THONG_TIN_KH('C001');

-- 6. Tạo PROCEDURE lấy thông tin của tất cả sản phẩm. [3 điểm]
delimiter //
create procedure LAY_THONG_TIN_SP()
begin
    select * from PRODUCTS;
end;
//
call LAY_THONG_TIN_SP;

-- 7. Tạo PROCEDURE hiển thị danh sách hoá đơn dựa trên mã người dùng. [3 điểm]
delimiter //
create procedure HIEN_THI_DS_HOA_DON(in customer_id_new varchar(4))
begin
    select * from ORDERS
    where customer_id = customer_id_new;
end;
//
call HIEN_THI_DS_HOA_DON('C002');

-- 8. Tạo PROCEDURE tạo mới một đơn hàng với các tham số là mã khách hàng, tổng tiền và ngày tạo hoá đơn, và hiển thị ra mã hoá đơn vừa tạo. [3 điểm]
delimiter //
create procedure THEM_MOI_DH(in order_id_new varchar(4),in customer_id_new varchar(4),in total_amount_new double,in order_date_new date)
begin
    insert into ORDERS (order_id, customer_id, total_amount, order_date) values (order_id_new, customer_id_new, total_amount_new, order_date_new);
    SELECT order_id_new as ma_dh_vua_tao
    from ORDERS 
    where order_id_new = order_id;
end; 
//
call THEM_MOI_DH('H011','C001',334343433, '2023-11-23');

-- 9. Tạo PROCEDURE thống kê số lượng bán ra của mỗi sản phẩm trong khoảng thời gian cụ thể với 2 tham số là ngày bắt đầu và ngày kết thúc. [3 điểm]
delimiter //
create procedure THONG_KE_SL_BAN_RA(in start_date date, in end_date date)
begin
	select P.product_id, P.name, sum(OD.quantity) as tong_sl_ban_ra
    from PRODUCTS P
    join ORDERS_DETAILS OD on P.product_id = OD.product_id
    join ORDERS O on OD.order_id = O.order_id
    where O.order_date between start_date and end_date
    group by P.product_id,P.name;
end;
//
call THONG_KE_SL_BAN_RA('2023/1/22','2023/3/22');

-- 10. Tạo PROCEDURE thống kê số lượng của mỗi sản phẩm được bán ra theo thứ tự giảm dần của tháng đó với tham số vào là tháng và năm cần thống kê. [3 điểm]
delimiter //
create procedure TK_SLSP_BAN_RA_DESC(in month int, in year int)
begin
    select P.name, sum(OD.quantity) as sl_sp_ban_ra_desc
    from PRODUCTS P
    join ORDERS_DETAILS OD on P.product_id = OD.product_id
    join ORDERS O on OD.order_id = O.order_id
    where month(O.order_date) = month and year(O.order_date) = year
    group by P.name
    order by sl_sp_ban_ra_desc desc;
end;
//
call TK_SLSP_BAN_RA_DESC(3,2023);


