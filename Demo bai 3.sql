create database btvn;
create table SinhVien(
   maso int primary key,
   hodem nvarchar(30),
   ten nvarchar(15),
   ngaysinh date,
   lop int,
   diemtb double,
   foreign key (lop) references lop(id)
);

create table lop(
	id int primary key,
    ten nvarchar(50),
    khoa int,
	foreign key (khoa) references khoa(id)

);

create table khoa(
	id int primary key,
    ten nvarchar(50)
);

select * from sinhvien;

select concat(hodem,ten,' có điểm là  ', diemtb) as hovsten from sinhvien;

select * from sinhvien join lop on sinhvien.lop = lop.id
where sinhvien.lop = lop.id;
			
select concat(hodem,ten,' có điểm là  ', diemtb) as hovsten, (year(now()) - year(ngaysinh)) as tuoi from sinhvien;

/*
Số lượng sinh viên loại giỏi, loại khá, loại trung bình (trong cùng 1 query)
*/
select * from 
(select count(maso) as goi from sinhvien where diemtb > 8.0) as gioi,
(select count(maso) as tb from sinhvien where diemtb < 8.0 and diemtb >7.0) as trungbinh;

-- Demo học lý thuyết
SELECT * FROM btvn.SinhVien where ngaysinh between '1998/03/01' and '1998/8/1' ;

SELECT * FROM btvn.SinhVien where hodem like '%Nguyễn%';

SELECT * FROM btvn.SinhVien where lop in (1,2);

-- sử dụng full join union
SELECT * FROM btvn.SinhVien  left join lop on lop.id= sinhvien.lop
union
SELECT * FROM btvn.SinhVien  right join lop on lop.id= sinhvien.lop;

-- demo sử dụng join 3 bảng.
select * from sinhvien inner join lop on lop.id = SinhVien.lop
inner join khoa on lop.khoa = khoa.id 
where khoa.ten='CNTT';

-- demo sử dụng oder by sắp xếp.
select * from sinhvien inner join lop on lop.id = SinhVien.lop
inner join khoa on lop.khoa = khoa.id 
order by diemtb;

-- Demo sử dụng hàm và group by + having
select lop.ten,count(maso) as soluong,sum(diemtb) as sumtb
from sinhvien join lop on lop.id = sinhvien.lop
group by lop.ten
having soluong = 2;

-- demo sử dụng having như where.
select lop.ten,maso
from sinhvien join lop on lop.id = sinhvien.lop
having maso not in (2);


