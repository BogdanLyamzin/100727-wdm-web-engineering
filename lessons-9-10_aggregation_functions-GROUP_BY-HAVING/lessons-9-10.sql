USE northwind;

-- COUNT(*) - общее количество строк, COUNT(column_name) - общее количество строк где column_name не NULL
SELECT COUNT(*) AS total_orders, COUNT(paid_date) AS total_paid_orders FROM orders;

SELECT COUNT(DISTINCT customer_id) AS active_customers FROM orders;

-- SUM(column_name) - сумма значений в колонках

SELECT SUM(quantity) AS total_orders_quantity FROM order_details;

SELECT SUM(quantity * unit_price) AS total_purchase_cost FROM order_details;

-- AVG(column_name) - среднее значение в этой колонке (сложить все значения в этой колонке и делим на общее количество). NULL не учитываем

SELECT AVG(list_price) AS avg_list_price FROM products;

SELECT AVG(shipping_fee) AS avg_shipping_fee FROM orders;

-- MIN(column_name) - минимальное значение из всех строк в этой колонке (NULL не учитываем)

SELECT MIN(list_price) AS min_list_price FROM products;

SELECT MIN(order_date) AS first_order FROM orders;

-- MAX(column_name) - максимальное значение из всех строк в этой колонке (NULL не учитываем)

SELECT MAX(quantity) AS max_quantity_in_position FROM order_details;

SELECT MAX(order_date) AS last_order FROM orders;

-- ROUND(column_name или агрегирующая фукция, число_знаков_после_запятой)

SELECT id, product_name, ROUND(list_price, 2) AS round_list_price FROM products;

SELECT ROUND(AVG(list_price), 2) AS avg_list_price FROM products;

SELECT ROUND(AVG(discount * 100), 1) AS avg_discount FROM order_details;

-- GROUP_CONCAT - склеивает значения в круглых скобках в одну строку и разделяет либо запятой без пробела, либо указаным разделителем
-- похож на Javascript метод join.

SELECT GROUP_CONCAT(product_name SEPARATOR ', ') AS products_list FROM products;

SELECT GROUP_CONCAT(CONCAT(first_name, ' ', last_name)) AS employees_list FROM employees;

SELECT GROUP_CONCAT(DISTINCT ship_city) AS ship_city_list FROM orders;

-- Решения задач на агрегирующие функции

SELECT COUNT(*) AS unshipped_orders FROM orders WHERE shipped_date IS NULL;

SELECT SUM(unit_in_stock) AS total_stock FROM products;

SELECT AVG(quantity) AS avg_quantity FROM order_details;

SELECT MIN(unit_in_stock) AS min_stock FROM products;

SELECT MAX(amount_due) AS max_invoice FROM invoices;

SELECT ROUND(AVG(standard_cost), 2) AS avg_cost FROM products;

SELECT GROUP_CONCAT(DISTINCT payment_type SEPARATOR '; ') AS payment_methods FROM orders;

-- 

SELECT DISTINCT category FROM products;

SELECT COUNT(DISTINCT category) AS total_categories FROM products;

SELECT category, COUNT(*) AS total_category_products FROM products GROUP BY category;

SELECT category, AVG(list_price) AS avg_list_price_by_category 
FROM products 
GROUP BY category
ORDER BY avg_list_price_by_category DESC;

SELECT COUNT(*) AS total_employees FROM employees;

SELECT DISTINCT job_title FROM employees;

SELECT job_title, COUNT(*) AS total_job_title_employees 
FROM employees 
GROUP BY job_title
ORDER BY total_job_title_employees DESC;

SELECT category, SUM(unit_in_stock) AS total_category_unit_in_stock 
FROM products 
GROUP BY category
ORDER BY total_category_unit_in_stock ASC;

SELECT customer_id, MAX(order_date) AS last_order_date 
FROM orders 
GROUP BY customer_id
ORDER BY last_order_date ASC;

SELECT order_id, SUM(quantity) AS total_order_quantity 
FROM order_details 
GROUP BY order_id
ORDER BY total_order_quantity DESC;

SELECT payment_type, COUNT(*) AS total_payment_type 
FROM orders 
WHERE payment_type IS NOT NULL
GROUP BY payment_type
ORDER BY total_payment_type DESC;

SELECT ship_city, payment_type, COUNT(*) AS ship_city_payment_type
FROM orders 
WHERE payment_type IS NOT NULL
GROUP BY ship_city, payment_type
ORDER BY ship_city_payment_type DESC;

-- Решения задач
SELECT
    employee_id,
    COUNT(*) AS employee_order_count
FROM orders
GROUP BY employee_id
ORDER BY employee_order_count DESC;

SELECT
    employee_id,
    status_id,
    COUNT(*) AS orders_count
FROM orders
GROUP BY employee_id, status_id
ORDER BY employee_id, status_id;

-- HAVING

SELECT category, COUNT(*) AS category_product_count 
FROM products 
GROUP BY category
HAVING COUNT(*) < 3
ORDER BY category_product_count DESC;

SELECT order_id, SUM(quantity) AS order_total_quantity 
FROM order_details 
GROUP BY order_id
HAVING SUM(quantity) >= 150
ORDER BY order_total_quantity DESC;

SELECT ship_city, ROUND(AVG(shipping_fee), 2) AS ship_city_avg_shipping_fee
FROM orders 
GROUP BY ship_city
HAVING AVG(shipping_fee) >= 100
ORDER BY ship_city_avg_shipping_fee DESC;

SELECT customer_id, COUNT(*) AS customer_total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(*) >= 4
ORDER BY customer_total_orders DESC;