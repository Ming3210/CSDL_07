-- 2
select b.title, b.author, c.category_name
from books b
join categories c on b.category_id = c.category_id
order by b.title;

select r.name, count(b.borrow_id) as borrowed_books
from readers r
join borrowing b on r.reader_id = b.reader_id
group by r.name;

select avg(f.fine_amount) as avg_fine
from fines f;

select title, available_quantity
from books
where available_quantity = (select max(available_quantity) from books);

select r.name, sum(f.fine_amount) as total_fine
from readers r
join borrowing b on r.reader_id = b.reader_id
join returning rt on b.borrow_id = rt.borrow_id
join fines f on rt.return_id = f.return_id
where f.fine_amount > 0
group by r.name;

select b.title, count(br.borrow_id) as borrow_count
from books b
join borrowing br on b.book_id = br.book_id
group by b.title
having borrow_count = (select max(borrow_count) 
                       from (select count(borrow_id) as borrow_count from borrowing group by book_id) as counts);

select b.title, r.name, br.borrow_date
from books b
join borrowing br on b.book_id = br.book_id
join readers r on br.reader_id = r.reader_id
left join returning rt on br.borrow_id = rt.borrow_id
where rt.return_id is null
order by br.borrow_date;

select distinct r.name, b.title
from readers r
join borrowing br on r.reader_id = br.reader_id
join books b on br.book_id = b.book_id
join returning rt on br.borrow_id = rt.borrow_id
where rt.return_date <= br.due_date;

select b.title, b.publication_year
from books b
join borrowing br on b.book_id = br.book_id
group by b.title, b.publication_year
having count(br.borrow_id) = (select max(borrow_count) 
                              from (select count(borrow_id) as borrow_count from borrowing group by book_id) as counts);

