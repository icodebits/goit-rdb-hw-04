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

-- p3 -- ********************************************************************
SELECT 
    orders.id AS order_id,
    orders.date AS order_date,
    products.name AS product_name,
    categories.name AS category_name,
    order_details.quantity,
    customers.name AS customer_name,
    customers.contact AS customer_contact,
    customers.address AS customer_address,
    customers.city AS customer_city,
    customers.postal_code AS customer_postal_code,
    customers.country AS customer_country,
    employees.first_name AS employee_first_name,
    employees.last_name AS employee_last_name,
    employees.birthdate AS employee_birthdate,
    employees.photo AS employee_photo,
    employees.notes As employee_notes,
    suppliers.name AS supplier_name,
    shippers.name AS shipper_name,
    shippers.phone AS shipper_phone
FROM 
    orders
INNER JOIN customers ON orders.customer_id = customers.id
INNER JOIN employees ON orders.employee_id = employees.employee_id
INNER JOIN order_details ON orders.id = order_details.order_id
INNER JOIN products ON order_details.product_id = products.id
INNER JOIN categories ON products.category_id = categories.id
INNER JOIN suppliers ON products.supplier_id = suppliers.id
INNER JOIN shippers ON orders.shipper_id = shippers.id;


-- p4 -- ********************************************************************
-- p4-1 --
SELECT 
    COUNT(*)
FROM 
    orders
INNER JOIN customers ON orders.customer_id = customers.id
INNER JOIN employees ON orders.employee_id = employees.employee_id
INNER JOIN order_details ON orders.id = order_details.order_id
INNER JOIN products ON order_details.product_id = products.id
INNER JOIN categories ON products.category_id = categories.id
INNER JOIN suppliers ON products.supplier_id = suppliers.id
INNER JOIN shippers ON orders.shipper_id = shippers.id;

-- p4-2-1 --
SELECT 
    COUNT(*)
FROM 
    orders
LEFT JOIN customers ON orders.customer_id = customers.id
LEFT JOIN employees ON orders.employee_id = employees.employee_id
LEFT JOIN order_details ON orders.id = order_details.order_id
LEFT JOIN products ON order_details.product_id = products.id
LEFT JOIN categories ON products.category_id = categories.id
LEFT JOIN suppliers ON products.supplier_id = suppliers.id
LEFT JOIN shippers ON orders.shipper_id = shippers.id;

-- p4-2-2 --
SELECT 
    COUNT(*)
FROM 
    orders
LEFT JOIN customers ON orders.customer_id = customers.id
INNER JOIN employees ON orders.employee_id = employees.employee_id
LEFT JOIN order_details ON orders.id = order_details.order_id
INNER JOIN products ON order_details.product_id = products.id
LEFT JOIN categories ON products.category_id = categories.id
INNER JOIN suppliers ON products.supplier_id = suppliers.id
LEFT JOIN shippers ON orders.shipper_id = shippers.id;

/*  
    Кількість рядків не змінюється, тому що запити грунтуються на таблиці orders
    що містять властивості customer_id, employee_id, shipper_id, відповідно наступні
    поєднання базуються на інформації з лівої таблиці - orders.

    Зазвичай LEFT JOIN зазвичай збільшується, оскільки тепер у результаті будуть
    присутні всі рядки з лівої таблиці, незалежно від наявності відповідних рядків
    у правих таблицях.

    В нашому випадку всі записи з таблиці orders мають всі відповідні записи у
    таблицях customers, employees, order_details, тощо.

    RIGHT JOIN: аналогічно LEFT JOIN, але повертає всі рядки з правої таблиці.
    У нашому випадку це не має сенсу, оскільки запит будується навколо замовлень,
    і ми хочемо зберегти всі рядки з таблиці orders.
*/

-- p4-3 --
SELECT 
    orders.id AS order_id,
    orders.date AS order_date,
    products.name AS product_name,
    categories.name AS category_name,
    order_details.quantity,
    customers.name AS customer_name,
    customers.contact AS customer_contact,
    customers.address AS customer_address,
    customers.city AS customer_city,
    customers.postal_code AS customer_postal_code,
    customers.country AS customer_country,
    employees.first_name AS employee_first_name,
    employees.last_name AS employee_last_name,
    employees.birthdate AS employee_birthdate,
    employees.photo AS employee_photo,
    employees.notes As employee_notes,
    suppliers.name AS supplier_name,
    shippers.name AS shipper_name,
    shippers.phone AS shipper_phone
FROM 
    orders
INNER JOIN customers ON orders.customer_id = customers.id
INNER JOIN employees ON orders.employee_id = employees.employee_id
INNER JOIN order_details ON orders.id = order_details.order_id
INNER JOIN products ON order_details.product_id = products.id
INNER JOIN categories ON products.category_id = categories.id
INNER JOIN suppliers ON products.supplier_id = suppliers.id
INNER JOIN shippers ON orders.shipper_id = shippers.id
WHERE 
    orders.employee_id > 3 AND orders.employee_id <= 10;

-- p4-4 --
SELECT 
    categories.name AS category_name,
    COUNT(*) AS total_orders,
    AVG(order_details.quantity) AS avg_quantity
FROM 
    orders
INNER JOIN customers ON orders.customer_id = customers.id
INNER JOIN employees ON orders.employee_id = employees.employee_id
INNER JOIN order_details ON orders.id = order_details.order_id
INNER JOIN products ON order_details.product_id = products.id
INNER JOIN categories ON products.category_id = categories.id
INNER JOIN suppliers ON products.supplier_id = suppliers.id
INNER JOIN shippers ON orders.shipper_id = shippers.id
WHERE 
    orders.employee_id > 3 AND orders.employee_id <= 10
GROUP BY 
    categories.name;

-- p4-5 --
SELECT 
    categories.name AS category_name,
    COUNT(*) AS total_orders,
    AVG(order_details.quantity) AS avg_quantity
FROM 
    orders
INNER JOIN customers ON orders.customer_id = customers.id
INNER JOIN employees ON orders.employee_id = employees.employee_id
INNER JOIN order_details ON orders.id = order_details.order_id
INNER JOIN products ON order_details.product_id = products.id
INNER JOIN categories ON products.category_id = categories.id
INNER JOIN suppliers ON products.supplier_id = suppliers.id
INNER JOIN shippers ON orders.shipper_id = shippers.id
GROUP BY 
    categories.name
HAVING 
    avg_quantity > 21;

-- p4-6 --
SELECT 
    categories.name AS category_name,
    COUNT(*) AS total_orders,
    AVG(order_details.quantity) AS avg_quantity
FROM 
    orders
INNER JOIN customers ON orders.customer_id = customers.id
INNER JOIN employees ON orders.employee_id = employees.employee_id
INNER JOIN order_details ON orders.id = order_details.order_id
INNER JOIN products ON order_details.product_id = products.id
INNER JOIN categories ON products.category_id = categories.id
INNER JOIN suppliers ON products.supplier_id = suppliers.id
INNER JOIN shippers ON orders.shipper_id = shippers.id
GROUP BY 
    categories.name
ORDER BY 
    avg_quantity DESC;

-- p4-7 --
SELECT 
    categories.name AS category_name,
    COUNT(*) AS total_orders,
    AVG(order_details.quantity) AS avg_quantity
FROM 
    orders
INNER JOIN customers ON orders.customer_id = customers.id
INNER JOIN employees ON orders.employee_id = employees.employee_id
INNER JOIN order_details ON orders.id = order_details.order_id
INNER JOIN products ON order_details.product_id = products.id
INNER JOIN categories ON products.category_id = categories.id
INNER JOIN suppliers ON products.supplier_id = suppliers.id
INNER JOIN shippers ON orders.shipper_id = shippers.id
GROUP BY 
    categories.name
ORDER BY 
    avg_quantity DESC
LIMIT 4 OFFSET 1;
