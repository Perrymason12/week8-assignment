
-- Library Management System Database Schema

-- Drop existing tables if they exist
DROP TABLE IF EXISTS Book_Author, Borrow, Book, Author, Member;

-- Create Member table
CREATE TABLE Member (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20) UNIQUE,
    address VARCHAR(255),
    join_date DATE NOT NULL
);

-- Create Author table
CREATE TABLE Author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

-- Create Book table
CREATE TABLE Book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    publication_year YEAR NOT NULL,
    copies_available INT DEFAULT 1 CHECK (copies_available >= 0)
);

-- Create Book_Author (Many-to-Many between Book and Author)
CREATE TABLE Book_Author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES Book(book_id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES Author(author_id) ON DELETE CASCADE
);

-- Create Borrow table (One-to-Many: A Member can borrow many Books)
CREATE TABLE Borrow (
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    book_id INT,
    borrow_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (member_id) REFERENCES Member(member_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES Book(book_id) ON DELETE CASCADE
);


-- Insert sample Members
INSERT INTO Member (first_name, last_name, email, phone, address, join_date)
VALUES
('John', 'Doe', 'john.doe@example.com', '1234567890', '123 Main St', '2023-01-15'),
('Jane', 'Smith', 'jane.smith@example.com', '0987654321', '456 Oak Ave', '2023-02-20'),
('Alice', 'Brown', 'alice.brown@example.com', '1122334455', '789 Pine Rd', '2023-03-05');

-- Insert sample Authors
INSERT INTO Author (first_name, last_name)
VALUES
('George', 'Orwell'),
('J.K.', 'Rowling'),
('Harper', 'Lee');

-- Insert sample Books
INSERT INTO Book (title, isbn, publication_year, copies_available)
VALUES
('1984', '9780451524935', 1949, 5),
('Harry Potter and the Sorcerer''s Stone', '9780590353427', 1997, 3),
('To Kill a Mockingbird', '9780061120084', 1960, 4);

-- Link Books and Authors
INSERT INTO Book_Author (book_id, author_id)
VALUES
(1, 1), -- 1984 by George Orwell
(2, 2), -- Harry Potter by J.K. Rowling
(3, 3); -- To Kill a Mockingbird by Harper Lee

-- Insert sample Borrows
INSERT INTO Borrow (member_id, book_id, borrow_date, return_date)
VALUES
(1, 1, '2023-04-01', '2023-04-15'),
(2, 2, '2023-04-03', NULL),
(3, 3, '2023-04-05', '2023-04-20');
