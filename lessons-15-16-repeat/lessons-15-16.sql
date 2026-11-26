USE northwind;

SELECT * FROM products;

SELECT id, product_name, category, standard_cost, list_price FROM products;

SELECT id, first_name, last_name, job_title AS position FROM employees;

SELECT id, product_name, list_price FROM products WHERE list_price > 30;

SELECT id, first_name, last_name, city FROM customers WHERE city = 'Chicago';

SELECT id, order_date, shipped_date FROM orders WHERE shipped_date IS NULL;

SELECT id, order_date, shipped_date FROM orders WHERE shipped_date IS NOT NULL;

SELECT id, product_name FROM products WHERE product_name LIKE '%chocolate%';

SELECT id, first_name, last_name, job_title FROM customers WHERE job_title LIKE '%manager%';

SELECT id, product_name, category, list_price FROM products 
WHERE category = 'Beverages' AND list_price < 20;

SELECT id, first_name, last_name, city FROM customers
WHERE city = 'Seattle' OR city = 'Boston';

SELECT id, product_name, category, list_price FROM products
WHERE (category = 'Beverages' OR category = 'Condiments') AND list_price > 15;

SELECT id, product_name, list_price FROM products
WHERE list_price BETWEEN 15 AND 30;

SELECT id, first_name, last_name, city FROM customers
WHERE city IN ('Seattle','Chicago', 'Boston');

SELECT id, product_name, standard_cost, list_price,
list_price - standard_cost AS profit FROM products;

SELECT id, product_name, SUBSTRING(product_name, 19) AS short_name FROM products;

SELECT id, first_name, last_name, CONCAT(first_name, ' ', last_name) AS full_name FROM customers;

SELECT id, order_date, paid_date,
CASE
	WHEN paid_date IS NOT NULL THEN 'paid'
    ELSE 'not paid'
END AS paid_status
FROM orders;

SELECT id, order_date, paid_date,
IF(paid_date IS NOT NULL, 'paid', 'not paid') AS paid_status
FROM orders;

SELECT DISTINCT category FROM products;

/*Задание 1
Задание 1. Подбор товаров
Найдите товары стоимостью от 10 до 30 долларов, имеющие на складе не менее 50 единиц 
и относящиеся к категории Beverages или Condiments.
Выведите название товара, категорию, цену и количество на складе.
*/
SELECT product_name, category, list_price, unit_in_stock
FROM products
WHERE list_price BETWEEN 10 AND 30
    AND unit_in_stock >= 50
    AND (category = 'Beverages' OR category = 'Condiments');

/*
Задание 2. Распродажа товаров
Магазин объявил скидку 15% на все товары стоимостью более 20 долларов.
Выведите название товара, первоначальную цену, размер скидки в долларах и итоговую цену после скидки.
*/
SELECT
    product_name,
    list_price AS original_price,
    list_price * 0.15 AS discount,
    list_price * 0.85 AS final_price
FROM products
WHERE list_price > 20;

/*
Задание 3. Информация о заказах
Выведите номер заказа, дату оформления, дату оплаты и два дополнительных столбца:
- order_name — название заказа в формате Order №30.
- payment_status — Paid, если заказ оплачен, или Not paid, если дата оплаты отсутствует.
*/
SELECT
    id,
    order_date,
    paid_date,
    CONCAT('Order №', id) AS order_name,
    IF(paid_date IS NOT NULL, 'Paid', 'Not paid') AS payment_status
FROM orders;

/*
Задание 4. Категории стоимости доставки
Выведите номер заказа, стоимость доставки и дополнительный столбец shipping_category, содержащий категорию стоимости доставки:
- Free — бесплатная доставка.
- Standard — доставка стоимостью больше 0 и до 20 долларов включительно.
- Expensive — доставка стоимостью больше 20 долларов.
*/
SELECT
    id,
    shipping_fee,
    CASE
        WHEN shipping_fee = 0 THEN 'Free'
        WHEN shipping_fee <= 20 THEN 'Standard'
        ELSE 'Expensive'
    END AS shipping_category
FROM orders
WHERE shipping_fee IS NOT NULL;

SELECT id, product_name, list_price FROM products ORDER BY list_price DESC;

SELECT id, product_name, category, list_price FROM products ORDER BY category ASC, list_price DESC;

SELECT id, product_name, list_price FROM products ORDER BY list_price ASC LIMIT 5;

SELECT id, product_name, list_price FROM products ORDER BY product_name
LIMIT 10 OFFSET 20;

SELECT COUNT(*) AS product_count FROM products;
SELECT AVG(list_price) AS avg_list_price FROM products;

SELECT category, 
COUNT(*) AS category_product_count,
AVG(list_price) AS avg_category_list_price,
MIN(list_price) AS min_category_list_price,
MAX(list_price) AS max_category_list_price 
FROM products GROUP BY category;

SELECT ship_city, payment_type,
SUM(shipping_fee) AS total_shiping
FROM orders
GROUP BY ship_city, payment_type;

SELECT category, 
COUNT(*) AS category_product_count
FROM products 
GROUP BY category
HAVING COUNT(*) >= 5
ORDER BY category_product_count;

/*
Задание 5. Анализ стоимости доставки
Для каждого способа оплаты определите количество заказов, 
среднюю, минимальную и максимальную стоимость доставки.
Учитывайте только заказы, для которых указан способ оплаты.
*/

SELECT
    payment_type,
    COUNT(*) AS order_count,
    AVG(shipping_fee) AS avg_shipping,
    MIN(shipping_fee) AS min_shipping,
    MAX(shipping_fee) AS max_shipping
FROM orders
WHERE payment_type IS NOT NULL
GROUP BY payment_type;

/*
Задание 6
Постоянные клиенты
Найдите клиентов, которые сделали не менее трёх заказов.
Выведите идентификатор клиента и количество его заказов.
*/
SELECT customer_id, COUNT(*) AS order_count
FROM orders
GROUP BY customer_id
HAVING COUNT(*) >= 3;

SELECT c.id AS order_id, order_date, company
FROM orders o
JOIN customers c
ON o.customer_id = c.id
WHERE shipped_date IS NOT NULL AND city = 'Las Vegas';

SELECT product_name, order_id, quantity, unit_price 
FROM order_details od
JOIN products p
ON od.product_id = p.id;

SELECT c.id AS customer_id, company, o.id AS order_id, order_date
FROM customers c
LEFT JOIN orders o
ON c.id = o.customer_id;

SELECT p.id AS product_id, product_name, list_price
FROM products p
LEFT JOIN order_details od
ON p.id = od.product_id
WHERE od.id IS NULL;

/*
Задание 7. Информация о сотрудниках, оформлявших заказы
Выведите номер заказа, дату оформления, имя и фамилию сотрудника, который оформил заказ.
*/
SELECT
    orders.id AS order_id,
    order_date,
    first_name,
    last_name
FROM orders
JOIN employees ON orders.employee_id = employees.id;

/*
Задание 8. Дорогие товары в заказах
Найдите позиции заказов, в которых цена единицы товара превышает 30 долларов.
Выведите название товара, номер заказа, количество единиц и цену.
*/
SELECT product_name, order_id, quantity, unit_price
FROM order_details
JOIN products ON order_details.product_id = products.id
WHERE unit_price > 30;

/*
Задание 3. Сотрудники и их заказы
Выведите имя и фамилию сотрудника, номер оформленного им заказа и дату оформления заказа.
В результат должны попасть все сотрудники, даже если они не оформили ни одного заказа.
*/
SELECT
    first_name,
    last_name,
    orders.id AS order_id,
    order_date
FROM employees
LEFT JOIN orders ON employees.id = orders.employee_id;

/*
Задание 10. Заказы без счетов
Найдите все заказы, для которых ещё не был создан счёт в таблице invoices.
Выведите номер заказа, дату оформления и стоимость доставки.
*/
SELECT orders.id, order_date, shipping_fee
FROM orders
LEFT JOIN invoices ON orders.id = invoices.order_id
WHERE invoices.id IS NULL;
