select e.name, d.department_name
from employees e
left join departments d on e.department_id = d.department_id
order by e.name;

select name, salary
from employees
where salary > 5000
order by salary desc;

select e.name, coalesce(sum(t.hours_worked), 0) as total_hours
from employees e
left join timesheets t on e.employee_id = t.employee_id
group by e.name;

select d.department_name, avg(e.salary) as avg_salary
from employees e
join departments d on e.department_id = d.department_id
group by d.department_name;

select p.project_name, sum(t.hours_worked) as total_hours
from projects p
join timesheets t on p.project_id = t.project_id
where month(t.work_date) = 2 and year(t.work_date) = 2025
group by p.project_name;

select e.name, p.project_name, sum(t.hours_worked) as total_hours
from employees e
join timesheets t on e.employee_id = t.employee_id
join projects p on t.project_id = p.project_id
group by e.name, p.project_name;

select d.department_name, count(e.employee_id) as num_employees
from employees e
join departments d on e.department_id = d.department_id
group by d.department_name
having count(e.employee_id) > 1;

select wr.report_date, e.name, wr.report_content
from workreports wr
left join employees e on wr.employee_id = e.employee_id
order by wr.report_date desc
limit 2 offset 1;


select wr.report_date, e.name, count(wr.report_id) as report_count
from workreports wr
join employees e on wr.employee_id = e.employee_id
where wr.report_content is not null
and wr.report_date between '2025-01-01' and '2025-02-01'
group by wr.report_date, e.name;


select e.name, p.project_name, sum(t.hours_worked) as total_hours, 
       round(sum(t.hours_worked) * (any_value(e.salary) / 160), 2) as total_salary
from employees e
join timesheets t on e.employee_id = t.employee_id
join projects p on t.project_id = p.project_id
group by e.name, p.project_name
having total_hours > 5
order by total_salary;

