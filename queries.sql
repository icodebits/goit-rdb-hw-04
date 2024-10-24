-- p1 -- ********************************************************************
-- Схема
CREATE DATABASE LibraryManagement;
USE LibraryManagement;

-- Таблиця "authors"
CREATE TABLE authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(255) NOT NULL
);

-- Таблиця "genres"
CREATE TABLE genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(255) NOT NULL
);

-- Таблиця "books"
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    publication_year YEAR NOT NULL,
    author_id INT,
    genre_id INT,
    FOREIGN KEY (author_id) REFERENCES authors(author_id),
    FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);

-- Таблиця "users"
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
);

-- Таблиця "borrowed_books"
CREATE TABLE borrowed_books (
    borrow_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    user_id INT,
    borrow_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- p2 -- ********************************************************************
-- Додаємо до "authors"
INSERT INTO authors (author_name)
VALUES ('J.K. Rowling'), ('George R.R. Martin');

-- Додаємо до "genres"
INSERT INTO genres (genre_name)
VALUES ('Fantasy'), ('Science Fiction');

-- Додаємо до "books"
INSERT INTO books (title, publication_year, author_id, genre_id)
VALUES ("Harry Potter and the Philosopher\'s Stone", 1997, 1, 1),
       ("A Game of Thrones", 1996, 2, 1);

-- Додаємо до "users"
INSERT INTO users (username, email)
VALUES ('john_doe', 'john@example.com'), 
       ('jane_smith', 'jane@example.com');

-- Додаємо до "borrowed_books"
INSERT INTO borrowed_books (book_id, user_id, borrow_date, return_date)
VALUES (1, 1, '2024-01-15', '2024-02-15'),
       (2, 2, '2024-01-20', NULL);

