-- 1

create table departments (
    department_id int primary key,
    department_name varchar(255),
    location varchar(255)
);

create table employees (
    employee_id int primary key,
    name varchar(255),
    dob date,
    department_id int,
    salary decimal(10, 2),
    foreign key (department_id) references departments(department_id)
);



create table projects (
    project_id int primary key,
    project_name varchar(255),
    start_date date,
    end_date date
);

create table timesheets (
    timesheet_id int primary key,
    employee_id int,
    project_id int,
    work_date date,
    hours_worked decimal(5, 2),
    foreign key (employee_id) references employees(employee_id),
    foreign key (project_id) references projects(project_id)
);

create table workreports (
    report_id int primary key,
    employee_id int,
    report_date date,
    report_content text,
    foreign key (employee_id) references employees(employee_id)
);

-- 3
INSERT INTO Employees (employee_id, name, dob, department_id, salary) VALUES
(1, 'Nguyen Van A', '1990-01-01', 1, 10000000),
(2, 'Tran Thi B', '1992-02-02', 2, 12000000);

INSERT INTO Departments (department_id, department_name, location) VALUES
(1, 'Sales', 'Hanoi'),
(2, 'Marketing', 'Ho Chi Minh City');

INSERT INTO Projects (project_id, project_name, start_date, end_date) VALUES
(1, 'Website Development', '2023-01-01', '2023-12-31'),
(2, 'Mobile App Development', '2023-06-01', '2024-06-01');

INSERT INTO Timesheets (timesheet_id, employee_id, project_id, work_date, hours_worked) VALUES
(1, 1, 1, '2023-07-26', 8.0),
(2, 2, 2, '2023-07-26', 6.0);


INSERT INTO WorkReports (report_id, employee_id, report_date, report_content) VALUES
(1, 1, '2023-07-26', 'Finished the website layout.'),
(2, 2, '2023-07-26', 'Completed the mobile app design.');

-- 4
update Projects set end_date = '2024-01-31' where project_id = 1;
-- 5

delete from Employees where employee_id = 1;