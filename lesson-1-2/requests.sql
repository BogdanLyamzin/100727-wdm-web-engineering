use northwind;

SELECT * FROM customers;

SELECT id, company, first_name, last_name FROM customers;

SELECT id, product_name, list_price FROM products;

SELECT id, last_name, first_name, city FROM customers WHERE city = 'Salt Lake City';

SELECT id, product_name FROM products WHERE category = 'Sauces';

SELECT id, last_name, first_name, job_title FROM customers WHERE job_title != 'Purchasing Manager';

SELECT id, last_name, first_name, job_title FROM customers WHERE job_title <> 'Purchasing Manager';

SELECT id, product_name, list_price FROM products WHERE list_price > 20;

SELECT id, product_name, list_price FROM products WHERE list_price >= 30;

SELECT id, shipping_fee FROM orders WHERE shipping_fee < 10;

SELECT id, last_name, first_name, notes FROM employees WHERE notes IS NULL;

SELECT id, last_name, first_name, notes FROM employees WHERE notes IS NOT NULL;

SELECT id, payment_method FROM purchase_orders WHERE payment_method IS NOT NULL;
/*
Примеры работы с AND и OR
*/
SELECT id, last_name, first_name, city, job_title 
FROM customers 
WHERE city = 'Seattle' AND job_title = 'Owner';

SELECT id, product_name, list_price, category FROM products WHERE category = 'Beverages' AND list_price > 20;

SELECT id, ship_city, shipping_fee FROM orders WHERE ship_city = 'Los Angelas' OR ship_city = 'Salt Lake City';

SELECT order_id, product_id, quantity, unit_price 
FROM order_details
WHERE quantity > 70 OR unit_price > 35;

SELECT id, product_name, list_price FROM products WHERE list_price >= 10 AND list_price <= 20;

SELECT id, product_name, list_price FROM products WHERE list_price BETWEEN 10 AND 20;

SELECT id, shipping_fee FROM orders WHERE shipping_fee BETWEEN 5 AND 15 AND ship_city = 'Seattle';

SELECT id, last_name, first_name, city 
FROM customers
WHERE city = 'Boston' OR city = 'New York' OR city = 'Chicago' OR city = 'Miami';

SELECT id, last_name, first_name, city 
FROM customers
WHERE city IN ('Boston', 'New York', 'Chicago', 'Miami');

SELECT id, payment_type FROM orders WHERE payment_type IN ('Check', 'Credit Card');

-- Найти все товары в названии который есть слово 'tea'
SELECT id, product_name FROM products WHERE product_name LIKE '%tea%';

SELECT id, last_name, first_name FROM customers WHERE first_name LIKE 'A%';

SELECT id, last_name, first_name, job_title FROM customers WHERE job_title LIKE '%manager%';


SELECT id, product_name FROM products WHERE product_name LIKE BINARY '%Tea%';