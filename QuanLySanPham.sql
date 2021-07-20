create database quanlysanpham;
use quanlysanpham;
create table khachhang (
makh int primary key,
tenkh nvarchar(50),
diachi nvarchar(50),
sdt int (10)
);
create table sanpham (
masp int primary key,
tensp nvarchar (50),
gia double
);
create table hoadon (
mahd int primary key,
ngaylap date,
tongtien double,
makh int,
foreign key (makh) references khachhang(makh)
);
drop table hoadon;
drop table chitiethoadon;
create table chitiethoadon (
id int primary key,
mahd int,
masp int,
soluong int,
giaban double,
foreign key (mahd) references hoadon(mahd),
foreign key (masp) references sanpham(masp)
);
insert into khachhang
values (1,'Tuan','Lang Son',0347183456),
 (2,'Toan','Ha Noi',0344583456),
 (3,'Hoang','Lang Son',034883456);
 insert into sanpham
 values (1,'Máy giặt',500),
  (2,'Ti vi',200),
  (3,'Tủ lạnh',400);
  insert into hoadon
  values (1,'2006-06-19',300,2),
   (2,'2006-06-20',500,3),
   (3,'2006-06-19',600,1);
   insert into chitiethoadon
   values (1,1,3,4,400),
		(2,2,2,5,200),
		(3,3,1,3,500);
        
        
-- 18. Tìm số hóa đơn đã mua trong đó tất cả các sản phẩm có giá >200.
select * from sanpham join chitiethoadon on chitiethoadon.masp = sanpham.masp 
			join hoadon on hoadon.mahd = chitiethoadon.mahd
where hoadon.mahd not in
	(select hoadon.mahd 
	from sanpham join chitiethoadon on chitiethoadon.masp = sanpham.masp 
			join hoadon on hoadon.mahd = chitiethoadon.mahd
	where gia < 200); 

        
-- 19. Tìm số hóa đơn trong năm 2006 đã mua tất cả các sản phẩm có giá <300.
select * from hoadon join chitiethoadon on hoadon.mahd = chitiethoadon.mahd
			join sanpham on sanpham.masp = chitiethoadon.masp
where year(ngaylap) = '2006' and gia > 400;


-- 22. Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu?

select * from hoadon join chitiethoadon on hoadon.mahd = chitiethoadon.mahd
			join sanpham on sanpham.masp = chitiethoadon.masp
where gia = (select max(gia) from hoadon join chitiethoadon on hoadon.mahd = chitiethoadon.mahd
			join sanpham on sanpham.masp = chitiethoadon.masp);

-- 25. Tìm số hóa đơn có trị giá cao nhất trong năm 2006.
select max(gia) from hoadon join chitiethoadon on hoadon.mahd = chitiethoadon.mahd
			join sanpham on sanpham.masp = chitiethoadon.masp
where year(ngaylap) = '2006';

-- 27. In ra danh sách 3 khách hàng (MAKH, HOTEN) mua nhiều hàng nhất (tính theo số lượng).
select khachhang.makh,tenkh,soluong from khachhang join hoadon on khachhang.makh = hoadon.makh 
			join chitiethoadon on hoadon.mahd = chitiethoadon.mahd
			join sanpham on sanpham.masp = chitiethoadon.masp
order by soluong desc limit 2;

-- 28. In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá caonhất.
select * from sanpham
where gia between (select gia from (SELECT gia FROM quanlysanpham.sanpham order by gia desc limit 3) as min order by min.gia limit 1) 
and (select gia from (SELECT gia FROM quanlysanpham.sanpham order by gia desc limit 3) as max limit 1 );


-- 39. Tìm hóa đơn có mua 3 sản phẩm có giá <300 (3 sản phẩm khác nhau).
SELECT * FROM quanlysanpham.hoadon
where mahd in
(select hoadon.mahd from khachhang join hoadon on khachhang.makh = hoadon.makh 
			join chitiethoadon on hoadon.mahd = chitiethoadon.mahd
			join sanpham on sanpham.masp = chitiethoadon.masp
where gia < 200
group by hoadon.mahd
having count(hoadon.mahd) >= 3);

-- 45. Trong 10 khách hàng có doanh số cao nhất, tìm khách hàng có số lần mua hàng nhiều nhất.

select distinct * from (select khachhang.makh,tenkh from khachhang join hoadon on khachhang.makh = hoadon.makh 
				join chitiethoadon on hoadon.mahd = chitiethoadon.mahd
				join sanpham on sanpham.masp = chitiethoadon.masp
				order by tongtien desc limit 10) 
                as top10
where top10.makh = (select khachhang.makh from khachhang join hoadon on khachhang.makh = hoadon.makh 
						join chitiethoadon on hoadon.mahd = chitiethoadon.mahd
						join sanpham on sanpham.masp = chitiethoadon.masp
						group by khachhang.makh
						order by count(hoadon.mahd) desc limit 1);

    



