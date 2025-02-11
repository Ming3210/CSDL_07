CREATE DATABASE AABB;
USE AABB;

CREATE TABLE students (
    studentid INT PRIMARY KEY,
    studentName VARCHAR(50),
    age INT,
    email VARCHAR(100)
);

CREATE TABLE subjects (
    subjectid INT PRIMARY KEY,
    subjectName VARCHAR(50)
);

CREATE TABLE classes (
    classid INT PRIMARY KEY,
    className VARCHAR(50)
);

CREATE TABLE marks (
    subjectid INT,
    studentid INT,
    mark INT,
    FOREIGN KEY (subjectid) REFERENCES subjects(subjectid),
    FOREIGN KEY (studentid) REFERENCES students(studentid),
    PRIMARY KEY (subjectid, studentid)
);

CREATE TABLE classStudent (
    studentid INT,
    classid INT,
    FOREIGN KEY (studentid) REFERENCES students(studentid),
    FOREIGN KEY (classid) REFERENCES classes(classid),
    PRIMARY KEY (studentid, classid) 
);

INSERT INTO students (studentid, studentName, age, email)
VALUES
(1, 'Nguyen Quang An', 18, 'an@yahoo.com'),
(2, 'Nguyen Cong Vinh', 20, 'vinh@gmail.com'),
(3, 'Nguyen Van Quyen', 19, 'quyen@gmail.com'),
(4, 'Pham Thanh Binh', 25, 'binh@gmail.com'),
(5, 'Nguyen Van Tai Em', 30, 'taiem@sport.vn');

INSERT INTO classes (classId, className)
VALUES
(1, 'C0706L'),
(2, 'C0708G');

INSERT INTO classStudent (studentId, classId)
VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 2),
(5, 1);

INSERT INTO subjects (subjectId, subjectName)
VALUES
(1, 'SQL'),
(2, 'Java'),
(3, 'C'),
(4, 'Visual Basic');

INSERT INTO marks (subjectId, studentId, mark)
VALUES
(1, 1, 8),
(2, 1, 4),
(1, 3, 7),
(1, 4, 3),
(2, 5, 5),
(3, 3, 8),
(3, 5, 1),
(2, 4, 3);

--
select * from students;

select * from subjects;

select studentid, avg(mark) as avg_mark 
from marks 
group by studentid;


select distinct subjects.subjectid, subjects.subjectname 
from subjects
join marks on subjects.subjectid = marks.subjectid
where marks.mark > 9;


select studentid, avg(mark) as avg_mark 
from marks 
group by studentid 
order by avg_mark desc;


update subjects
set subjectname = concat('day la mon hoc ', subjectname);


alter table marks drop foreign key marks_ibfk_1;
alter table marks drop foreign key marks_ibfk_2;

alter table classstudent drop foreign key classstudent_ibfk_1;
alter table classstudent drop foreign key classstudent_ibfk_2;


delete from students where studentid = 1;


alter table students add column status bit default 1;

update students set status = 0;

