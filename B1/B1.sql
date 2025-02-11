-- 1
CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(255)
);

CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    publication_year INT,
    available_quantity INT,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

CREATE TABLE Readers (
    reader_id INT PRIMARY KEY,
    name VARCHAR(255),
    phone_number VARCHAR(15),
    email VARCHAR(255)
);

CREATE TABLE Borrowing (
    borrow_id INT PRIMARY KEY,
    reader_id INT,
    book_id INT,
    borrow_date DATE,
    due_date DATE,
    FOREIGN KEY (reader_id) REFERENCES Readers(reader_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

CREATE TABLE Returning (
    return_id INT PRIMARY KEY,
    borrow_id INT,
    return_date DATE,
    FOREIGN KEY (borrow_id) REFERENCES Borrowing(borrow_id)
);

CREATE TABLE Fines (
    fine_id INT PRIMARY KEY,
    return_id INT,
    fine_amount DECIMAL(10, 2),
    FOREIGN KEY (return_id) REFERENCES Returning(return_id)
);

-- 3
INSERT INTO Categories (category_id, category_name) VALUES
(1, 'Khoa học viễn tưởng'),
(2, 'Lịch sử'),
(3, 'Kinh dị');

INSERT INTO Books (book_id, title, author, publication_year, available_quantity, category_id) VALUES
(1, 'Dune', 'Frank Herbert', 1965, 5, 1),
(2, 'Sapiens', 'Yuval Noah Harari', 2014, 3, 2),
(3, 'The Shining', 'Stephen King', 1977, 2, 3),
(4, '1984', 'George Orwell', 1949, 8, 1),
(5, 'Pride and Prejudice', 'Jane Austen', 1813, 10, NULL);

INSERT INTO Readers (reader_id, name, phone_number, email) VALUES
(1, 'Nguyen Van A', '0123456789', 'a@example.com'),
(2, 'Tran Thi B', '0987654321', 'b@example.com'),
(3, 'Le Van C', '0111222333', 'c@example.com');


INSERT INTO Borrowing (borrow_id, reader_id, book_id, borrow_date, due_date) VALUES
(1, 1, 1, '2023-10-26', '2023-11-09'),
(2, 2, 3, '2023-10-27', '2023-11-10');

INSERT INTO Returning (return_id, borrow_id, return_date) VALUES
(1, 1, '2023-11-08');

INSERT INTO Fines (fine_id, return_id, fine_amount) VALUES
(1, 1, 0.00);

-- 4
UPDATE Readers SET 
name = 'Nguyen Van AA', 
phone_number = '0999999999', 
email = 'aaa@example.com'
WHERE reader_id = 1;

-- 5
DELETE FROM Books WHERE book_id = 2;

