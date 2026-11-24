USE northwind;

/*
1. В каких таблицах находиться информация?
2. По каким стоблцам можно соединить эти таблицы?
3. Какие столбцы должны быть в результате?
*/

SELECT order_date, ship_city, shipping_fee, company
FROM orders
JOIN shippers
ON orders.shipper_id = shippers.id;

SELECT po.id AS purchase_order_id, s.id AS supplier_id, company, creation_date
FROM purchase_orders po
JOIN suppliers s
ON po.supplier_id = s.id;

SELECT p.id AS product_id, product_name, order_id
FROM products p
LEFT JOIN order_details od
ON p.id = od.product_id
WHERE order_id IS NULL;

SELECT AVG(list_price) AS avg_list_price FROM products;
SELECT id, product_name, list_price FROM products WHERE list_price > 15.84577778;

SELECT id, product_name, list_price 
FROM products 
WHERE list_price > (SELECT AVG(list_price) FROM products);

/*
1. Какую информацию сначала мне нужно получить чтобы решить основную задачу?
2. Каким отдельным SQL-запросом я могу получить эту информацию?
3. В какое место основного запроса мне нужно вставить эту информацию?
*/

SELECT id, order_date, ship_city, shipping_fee 
FROM orders
WHERE shipping_fee > (SELECT AVG(shipping_fee) FROM orders);

SELECT id, product_name, list_price 
FROM products
WHERE list_price = (SELECT MAX(list_price) FROM products);

SELECT o.id AS order_id, customer_id, order_date, state_province
FROM orders o
JOIN customers c
ON o.customer_id = c.id
WHERE state_province = 'IL';

SELECT id, order_date, customer_id
FROM orders
WHERE customer_id IN (SELECT id FROM customers WHERE state_province = 'IL');

SELECT id, product_name
FROM products
WHERE id NOT IN (SELECT DISTINCT product_id FROM order_details);

SELECT id, first_name, last_name, company, business_phone
FROM customers
WHERE id IN (SELECT customer_id
FROM orders 
GROUP BY customer_id
HAVING COUNT(*) >= 5);

/*
1. Как должна выглядеть промежуточная таблица, чтобы решить задачу?
2. Каким SQL-запросом я могу получить эту таблицу?
3. Какой SQL-запрос я должен выполнить над этой таблицей, чтобы получить нужный результат?
*/

SELECT AVG(order_total) AS avg_order_total
FROM (SELECT order_id, 
SUM(quantity * unit_price) AS order_total
FROM order_details
GROUP BY order_id) AS customers_orders;

SELECT COUNT(*) AS loyal_customers_count 
FROM (SELECT customer_id, COUNT(*) AS customer_order_count
FROM orders
GROUP BY customer_id
HAVING COUNT(*) >= 4) AS customers_orders;

SELECT id, product_name, list_price, category 
FROM products p1
WHERE list_price > (
SELECT AVG(list_price) FROM products p2 WHERE p2.category = p1.category
);

SELECT order_id, product_id, quantity 
FROM order_details od1
WHERE quantity > (
SELECT AVG(quantity) FROM order_details od2 WHERE od2.product_id = od1.product_id
);

-- Решение задач

SELECT
    id,
    product_name,
    standard_cost
FROM products
WHERE standard_cost > (
    SELECT AVG(standard_cost)
    FROM products
)
ORDER BY standard_cost DESC;

SELECT
    id,
    first_name,
    last_name,
    city
FROM customers
WHERE id NOT IN (
    SELECT customer_id
    FROM orders
    WHERE customer_id IS NOT NULL
);

SELECT AVG(order_count) AS avg_order_count
FROM (
    SELECT
        employee_id,
        COUNT(*) AS order_count
    FROM orders
    WHERE employee_id IS NOT NULL
    GROUP BY employee_id
) AS employee_orders;

SELECT
    id,
    customer_id,
    order_date,
    shipping_fee
FROM orders AS o1
WHERE shipping_fee = (
    SELECT MAX(shipping_fee)
    FROM orders AS o2
    WHERE o2.customer_id = o1.customer_id
)
ORDER BY customer_id;

SELECT AVG(order_total) AS avg_order_total 
FROM (
	SELECT order_id, SUM(quantity * unit_price) AS order_total FROM order_details GROUP BY  order_id
) AS order_totals;

WITH order_totals AS (
SELECT order_id, SUM(quantity * unit_price) AS order_total FROM order_details GROUP BY  order_id
)
SELECT AVG(order_total) AS avg_order_total 
FROM order_totals;


SELECT id, product_name, list_price 
FROM products
WHERE unit_in_stock > 0 AND list_price > 0 (
SELECT AVG(list_price) FROM products WHERE unit_in_stock > 0
);

WITH available_products AS (
SELECT * FROM products WHERE unit_in_stock > 0
)
SELECT id, product_name, list_price
FROM available_products
WHERE list_price > (SELECT AVG(list_price) FROM available_products);

WITH category_stats AS (
	SELECT category, COUNT(*) as product_count, AVG(list_price) as avg_list_price
    FROM products
    GROUP BY category
)
SELECT * FROM category_stats ORDER BY avg_list_price DESC LIMIT 3;

-- Решение заданий

WITH beverages AS (
    SELECT *
    FROM products
    WHERE category = 'Beverages'
)
SELECT
	'Beverages' AS category,
    COUNT(*) AS product_count,
    AVG(list_price) AS avg_price,
    MAX(list_price) AS max_price
FROM beverages;

WITH employee_stats AS (
    SELECT
        employee_id,
        COUNT(*) AS order_count,
        SUM(shipping_fee) AS total_shipping
    FROM orders
    GROUP BY employee_id
)
SELECT *
FROM employee_stats
ORDER BY order_count DESC;

WITH product_sales AS (
    SELECT
        product_id,
        SUM(quantity) AS total_quantity
    FROM order_details
    GROUP BY product_id
)
SELECT *
FROM product_sales
WHERE total_quantity > (
    SELECT AVG(total_quantity)
    FROM product_sales
);