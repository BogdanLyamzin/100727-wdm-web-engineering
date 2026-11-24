
CREATE DATABASE IF NOT EXISTS northwind_bad_demo;

USE northwind_bad_demo;

DROP TABLE IF EXISTS bad_orders;

CREATE TABLE bad_orders (
    order_id INT NOT NULL,
    customer_id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    order_date DATE NOT NULL
);

INSERT INTO bad_orders (
    order_id,
    customer_id,
    first_name,
    last_name,
    city,
    order_date
)
VALUES
    (33, 8, 'Elizabeth', 'Andersen', 'Portland', '2006-01-30'),
    (39, 8, 'Elizabeth', 'Andersen', 'Portland', '2006-03-22'),
    (48, 8, 'Elizabeth', 'Andersen', 'Portland', '2006-04-05'),
    (60, 8, 'Elizabeth', 'Andersen', 'Portland', '2006-04-30'),
    (66, 8, 'Elizabeth', 'Andersen', 'Portland', '2006-05-24'),
    (75, 8, 'Elizabeth', 'Andersen', 'Portland', '2006-06-05'),
    (30, 27, 'Karen', 'Toh', 'Las Vegas', '2006-01-15'),
    (31, 4, 'Christina', 'Lee', 'New York', '2006-01-20');

SELECT *
FROM bad_orders
ORDER BY customer_id, order_id;

DELETE FROM bad_orders WHERE id = 30;

/*
1. Выделить отдельные объекты (сущности), ответив себе на два вопроса:
- нужна ли мне про это информация в отдельности?
- нужно ли будет менять про это информацию отдельно?
Две таблицы:
- покупатели;
- заказы;

2. Какие данные к какому объекту относятся? Выделить атрибуты.

3. Как наши таблицы будут связаны? Определить тип связи:
- Один к одному (One-to-One);
- Один ко многим (One-to-Many);
- Многие ко многим (Many-to-Many);
*/

-- 1. Покупатели

CREATE TABLE good_customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    city VARCHAR(50)
);

INSERT INTO good_customers
    (first_name, last_name, city)
VALUES
    ('Antonio', 'Gratacos Solsona', 'Boston'),
    ('Christina', 'Lee', 'New York'),
    ('Elizabeth', 'Andersen', 'Portland'),
    ('Karen', 'Toh', 'Las Vegas');

CREATE TABLE good_orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    ship_city VARCHAR(150) NOT NULL,
    order_date DATE NOT NULL,
    
    FOREIGN KEY (customer_id)
	REFERENCES good_customers(id)
);


INSERT INTO good_orders
    (customer_id, ship_city, order_date)
VALUES
    (1, 'Boston', '2006-01-15'),
    (2, 'New York', '2006-01-20'),
    (3, 'Portland', '2006-01-30'),
    (4, 'Las Vegas', '2006-03-22'),
    (1, 'Boston', '2006-04-05'),
    (2, 'New York', '2006-04-30'),
    (3, 'Portland', '2006-05-24'),
    (4, 'Las Vegas', '2006-06-05');

UPDATE good_orders 
SET customer_id = 5
WHERE id = 1;

DELETE FROM good_customers WHERE id = 1;

USE northwind_bad_demo;

-- Удаляем только учебные правильные таблицы
-- в порядке, обратном зависимостям

DROP TABLE IF EXISTS good_customer_profiles;
DROP TABLE IF EXISTS good_order_details;
DROP TABLE IF EXISTS good_orders;
DROP TABLE IF EXISTS good_products;
DROP TABLE IF EXISTS good_customers;









