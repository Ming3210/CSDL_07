CREATE TABLE tblPhong (
    PhongID INT PRIMARY KEY AUTO_INCREMENT,
    Ten_phong VARCHAR(20),
    Trang_thai TINYINT
);

CREATE TABLE tblPhim (
    PhimID INT PRIMARY KEY AUTO_INCREMENT,
    Ten_phim VARCHAR(30),
    Loai_phim VARCHAR(25),
    Thoi_gian INT
);

CREATE TABLE tblGhe (
    GheID INT PRIMARY KEY AUTO_INCREMENT,
    PhongID INT,
    So_ghe VARCHAR(10),
    FOREIGN KEY (PhongID) REFERENCES tblPhong(PhongID)
);

CREATE TABLE tblVe (
    PhimID INT,
    GheID INT,
    Ngay_chieu DATETIME,
    Trang_thai VARCHAR(20),
    PRIMARY KEY (PhimID, GheID, Ngay_chieu),
    FOREIGN KEY (PhimID) REFERENCES tblPhim(PhimID),
    FOREIGN KEY (GheID) REFERENCES tblGhe(GheID)
);

INSERT INTO tblPhim (Ten_phim, Loai_phim, Thoi_gian)
VALUES
    ('Em bé Hà Nội', 'Tâm lý', 90),
    ('Nhiệm vụ bất khả thi', 'Hành động', 100),
    ('Dị nhân', 'Viễn tưởng', 90),
    ('Cuốn theo chiều gió', 'Tình cảm', 120);

INSERT INTO tblPhong (Ten_phong, Trang_thai)
VALUES
    ('Phòng chiếu 1', 1),
    ('Phòng chiếu 2', 1),
    ('Phòng chiếu 3', 0);

INSERT INTO tblGhe (PhongID, So_ghe)
VALUES
    (1, 'A3'),
    (1, 'B5'),
    (2, 'A7'),
    (2, 'D1'),
    (3, 'T2');

INSERT INTO tblVe (PhimID, GheID, Ngay_chieu, Trang_thai)
VALUES
    (1, 1, '2008-10-20', 'Đã bán'),
    (1, 3, '2008-11-20', 'Đã bán'),
    (1, 4, '2008-12-23', 'Đã bán'),
    (2, 1, '2009-02-14', 'Đã bán'),
    (3, 1, '2009-02-14', 'Đã bán'),
    (2, 5, '2009-03-08', 'Chưa bán'),
    (2, 3, '2009-03-08', 'Chưa bán');
    
-- 1
select * from tblphim
order by thoi_gian;

-- 2
select ten_phim from tblphim
where thoi_gian = (select max(thoi_gian) from tblphim);

-- 3
select ten_phim from tblphim
where thoi_gian = (select min(thoi_gian) from tblphim);

-- 4
select so_ghe from tblghe
where so_ghe like 'a%';

-- 5
alter table tblphong
modify trang_thai varchar(25); 

-- 6
update tblphong
set trang_thai = case
    when trang_thai = 0 then 'Đang sửa'
    when trang_thai = 1 then 'Đang sử dụng'
    when trang_thai is null then 'Unknow'
end;

-- 7
select ten_phim from tblphim
where length(ten_phim) > 15 and length(ten_phim) < 25;

-- 8
select concat(ten_phong, ' - ', trang_thai) as 'Trạng thái phòng chiếu' from tblphong;

-- 9
create view tblRank as 
select row_number() over(order by Ten_phim) as STT, 
       Ten_phim, 
       Thoi_gian 
from tblPhim;
-- 10
alter table tblphim
add mo_ta nvarchar(1000);

update tblphim 
set mo_ta = concat('đây là bộ phim thể loại ', loai_phim);

select * from tblphim;

update tblphim
set mo_ta = replace(mo_ta, 'bộ phim', 'film');

select * from tblphim;

-- 11
alter table tblve
drop foreign key tblve_ibfk_1,
drop foreign key tblve_ibfk_2;

alter table tblghe 
drop foreign key tblghe_ibfk_1;

-- 12
truncate table tblghe;

-- 13
select ngay_chieu, 
       date_add(ngay_chieu, interval 5000 minute) as ngay_chieu_them_5000
from tblve;