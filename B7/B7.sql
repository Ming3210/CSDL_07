create database StudentTest;
use StudentTest;
create table test (
    testid int primary key,
    name varchar(20)
);

create table student (
    rn int primary key,
    name varchar(20),
    age int
);

create table studenttest (
    rn int,
    testid int,
    date datetime,
    mark float,
    foreign key (rn) references student(rn),
    foreign key (testid) references test(testid),
    primary key (rn, testid)
);

insert into Student (RN, Name, Age) values
(1, 'nguyen hong ha', 20),
(2, 'truong ngoc anh', 30),
(3, 'tuan minh', 25),
(4, 'dan truong', 22);

insert into test (testid, name) values
(1, 'epc'),
(2, 'dwmx'),
(3, 'sql1'),
(4, 'sql2');

insert into studenttest (rn, testid, date, mark) values
(1, 1, '2006-07-17', 8),
(1, 2, '2006-07-18', 5),
(1, 3, '2006-07-19', 7),
(2, 1, '2006-07-17', 7),
(2, 2, '2006-07-18', 4),
(2, 3, '2006-07-19', 2),
(3, 1, '2006-07-17', 10),
(3, 3, '2006-07-18', 1);



--
alter table student
add constraint chk_age check (age between 15 and 55);

alter table studenttest
modify mark float default 0;

alter table test
add constraint unique_test_name unique (name);

alter table test
drop index unique_test_name;

-- 1
select 
    student.rn as 'id', 
    student.name as 'name', 
    test.name as 'test name', 
    studenttest.mark as 'mark', 
    studenttest.date as 'date'
from studenttest
join student on studenttest.rn = student.rn
join test on studenttest.testid = test.testid
order by student.rn, studenttest.date;

-- 2
select 
	student.rn as 'id', 
	student.name as 'name'
from student
left join studenttest on student.rn = studenttest.rn
where studenttest.rn is null;

-- 3
select 
	student.rn as 'id', 
    student.name as 'name', 
    test.name as 'test name', 
    studenttest.mark as 'mark'
from studenttest
join student on studenttest.rn = student.rn
join test on studenttest.testid = test.testid
where studenttest.mark < 5;

-- 4
select 
    student.rn as 'id', 
    student.name as 'name',
    avg(studenttest.mark) as 'avg_mark'
from studenttest
join student on studenttest.rn = student.rn
group by student.rn
order by avg(studenttest.mark) desc;

-- 5
select 
    student.name as 'name', 
    avg(studenttest.mark) as 'avg_mark'
from studenttest
join student on studenttest.rn = student.rn
group by student.rn
order by avg(studenttest.mark) desc
limit 1;

-- 6
select 
    test.name as 'test name', 
    max(studenttest.mark) as 'highest'
from studenttest
join test on studenttest.testid = test.testid
group by test.name
order by test.name;


-- 7
select 
    student.rn as 'id', 
    student.name as 'name', 
    test.name as 'test name'
from student
left join studenttest on student.rn = studenttest.rn
left join test on studenttest.testid = test.testid
order by student.rn;


-- 8
update student
set age = age + 1;

alter table student
add column status varchar(10);

-- 9 
update student
set status = case
    when age < 30 then 'Young'
    else 'Old'
end;
select * from student;


-- 10
select 
    student.rn as 'id', 
    student.name as 'name', 
    test.name as 'test name', 
    studenttest.mark as 'mark', 
    studenttest.date as 'date'
from studenttest
join student on studenttest.rn = student.rn
join test on studenttest.testid = test.testid
order by studenttest.date;


-- 11
select 
    student.name as 'name', 
    student.age as 'age', 
    avg(studenttest.mark) as 'điểm trung bình'
from student
join studenttest on student.rn = studenttest.rn
group by student.rn
having student.name like 'T%' 
   and avg(studenttest.mark) > 4.5;

-- 12
select 
    student.rn as 'id',
    student.name as 'name',
    student.age as 'age',
    avg(studenttest.mark) as 'avg_mark'
from student
join studenttest on student.rn = studenttest.rn
group by student.rn
order by 'xếp hạng';

-- 13
alter table student
modify column name text;

-- 14
update student
set name = concat('Old ', name)
where age > 20;

-- 15
update student
set name = concat('Young ', name)
where age <= 20;

-- 16
delete from test
where testid not in (select distinct testid from studenttest);

-- 17
delete from studenttest
where mark < 5;

