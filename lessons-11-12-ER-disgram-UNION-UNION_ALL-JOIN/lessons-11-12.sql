USE northwind;

SELECT first_name, last_name FROM employees
UNION ALL
SELECT first_name, last_name FROM customers;

SELECT first_name, last_name FROM employees
UNION
SELECT first_name, last_name FROM customers;

SELECT first_name, last_name, 'employee' AS person_type FROM employees
UNION
SELECT first_name, last_name, 'customer' AS person_type FROM customers;

SELECT first_name, last_name, 'employee' AS person_type FROM employees
UNION
SELECT first_name, 'customer' AS person_type FROM customers;

SELECT first_name, last_name, 'employee' AS person_type FROM employees
UNION
SELECT last_name, first_name, 'customer' AS person_type FROM customers;


SELECT first_name, last_name, order_date
FROM customers
INNER JOIN orders
ON customers.id = orders.customer_id
WHERE payment_type = 'Check';

SELECT order_id, order_details.id AS order_detail_id, 
products.id AS product_id,
product_name, quantity
FROM order_details
JOIN products
ON order_details.product_id = products.id
WHERE order_id = 30;

SELECT o.id AS order_id,
e.id AS employee_id,
e.first_name, e.last_name, o.order_date
FROM orders o
JOIN employees e
ON o.employee_id = e.id
WHERE o.id = 30
ORDER BY o.order_date;

SELECT customers.id, first_name, last_name, order_date
FROM customers
LEFT JOIN orders
ON customers.id = orders.customer_id
WHERE customers.id IN (2, 8);

SELECT c.id, c.first_name, c.last_name, o.order_date
FROM customers c
LEFT JOIN orders o
ON c.id = o.customer_id
WHERE o.order_date IS NULL;

SELECT o.id AS order_id,
		od.id AS detail_id,
        od.product_id,
        p.product_name,
        od.quantity,
        od.unit_price
FROM orders o
JOIN order_details od
ON o.id = od.order_id
JOIN products p
ON od.product_id = p.id;
