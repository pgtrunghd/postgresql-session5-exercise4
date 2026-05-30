CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE,
    total_amount NUMERIC(10, 2)
);

CREATE TABLE order_items (
    item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_name VARCHAR(100),
    quantity INT,
    price NUMERIC(10, 2)
);

-- INSERT dữ liệu vào bảng customers
INSERT INTO
    customers (customer_name, city)
VALUES
    ('Nguyễn Văn A', 'Hà Nội'),
    ('Trần Thị B', 'TP. Hồ Chí Minh'),
    ('Phạm Văn C', 'Đà Nẵng'),
    ('Hoàng Thị D', 'Hải Phòng'),
    ('Vũ Văn E', 'Cần Thơ'),
    ('Đỗ Thị F', 'Hà Nội'),
    ('Bùi Văn G', 'TP. Hồ Chí Minh'),
    ('Cao Thị H', 'Đà Nẵng'),
    ('Lý Văn I', 'Hải Phòng'),
    ('Mai Thị K', 'Cần Thơ');

-- INSERT dữ liệu vào bảng orders
INSERT INTO
    orders (customer_id, order_date, total_amount)
VALUES
    (1, '2024-01-15', 500000),
    (2, '2024-01-18', 750000),
    (3, '2024-02-05', 1200000),
    (4, '2024-02-10', 450000),
    (5, '2024-02-20', 980000),
    (1, '2024-03-01', 650000),
    (6, '2024-03-05', 890000),
    (7, '2024-03-12', 1100000),
    (8, '2024-03-18', 700000),
    (9, '2024-03-25', 520000);

-- INSERT dữ liệu vào bảng order_items
INSERT INTO
    order_items (order_id, product_name, quantity, price)
VALUES
    (1, 'Laptop Dell', 1, 500000),
    (2, 'iPhone 15', 1, 750000),
    (3, 'Samsung TV 55 inch', 1, 1200000),
    (4, 'Mechanical Keyboard', 2, 225000),
    (5, 'Wireless Mouse', 3, 326667),
    (6, 'Monitor LG 24 inch', 1, 650000),
    (7, 'Headphones Sony', 2, 445000),
    (8, 'iPad Pro', 1, 1100000),
    (9, 'USB-C Hub', 4, 175000),
    (10, 'Webcam Logitech', 2, 260000);

SELECT
    c.customer_name,
    o.order_date,
    o.total_amount
FROM
    customers c
    JOIN orders o ON c.customer_id = o.customer_id;

SELECT
    SUM(total_amount) AS total_amount,
    AVG(total_amount) AS avg_amount,
    MAX(total_amount) AS max_amount,
    MIN(total_amount) AS min_amount,
    COUNT(order_id) AS order_count
FROM
    orders;

SELECT
    c.city,
    SUM (o.total_amount) AS total_amount
FROM
    customers c
    JOIN orders o ON c.customer_id = o.customer_id
GROUP BY
    c.city
HAVING
    SUM (o.total_amount) > 10000;

SELECT
    c.customer_name,
    o.order_date,
    oi.quantity,
    oi.price
FROM
    customers c
    INNER JOIN orders o ON c.customer_id = o.customer_id
    INNER JOIN order_items oi ON o.order_id = oi.order_id;

SELECT
    c.customer_name,
    SUM(o.total_amount) AS total_revenue
FROM
    customers c
    INNER JOIN orders o ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
HAVING
    SUM(o.total_amount) = (
        SELECT
            MAX(highest_revenue)
        FROM
            (
                SELECT
                    SUM(total_amount) AS highest_revenue
                FROM
                    orders
                GROUP BY
                    customer_id
            )
    );