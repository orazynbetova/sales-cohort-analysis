INSERT INTO customers (full_name, email) VALUES
('Иван Иванов', 'ivan@mail.com'),
('Анна Смирнова', 'anna@mail.com'),
('Павел Ким', 'pavel@mail.com');

INSERT INTO products (product_name, price) VALUES
('Молоко', 300),
('Хлеб', 200),
('Яйца', 500);

INSERT INTO orders (order_date, customer_id, price) VALUES
('2025-05-01', 1, 500),
('2025-05-02', 2, 300),
('2025-05-03', 1, 700),
('2025-05-04', 3, 400);

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 2),
(1, 2, 1),
(2, 1, 1),
(3, 3, 5),
(4, 2, 2);

INSERT INTO orders (order_date, customer_id, price) VALUES
('2025-06-01', 1, 200),
('2025-07-01', 1, 300),
('2025-06-10', 2, 150);