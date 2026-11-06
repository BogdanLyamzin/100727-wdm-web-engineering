USE northwind;

SELECT id, company, last_name, first_name, job_title AS position FROM employees;

SELECT id, product_name, standard_cost,
CASE
	WHEN standard_cost > 20 THEN 'expensive'
    ELSE 'affordable'
END AS standard_price_category
FROM products;

SELECT id, product_name, list_price,
CASE
	WHEN list_price > 50 THEN 'expensive'
    WHEN list_price > 20 THEN 'medium'
    ELSE 'cheap'
END AS list_price_category
FROM products;

-- WA, CA 5%
-- ID, OR 7%
-- UT, NV 13%
-- ELSE 0%

SELECT id, company, state_province, 
CASE
	WHEN state_province IN ('WA', 'CA') THEN 5
    WHEN state_province IN ('ID', 'OR') THEN 7
    WHEN state_province IN ('UT', 'NV') THEN 13
    ELSE 0
END AS discount_percent
FROM customers;

SELECT id, last_name, first_name, job_title,
CASE
	WHEN job_title = 'Vice President, Sales' THEN 'top management'
    WHEN job_title = 'Sales Manager' THEN 'management'
END AS management_level 
FROM employees;
 
 
SELECT id, product_name, standard_cost,
IF(standard_cost > 20, 'expensive', 'affordable') AS standard_price_category
FROM products; 

SELECT id, first_name, last_name,
IF(notes IS NOT NULL, 'has notes', 'not notes') AS notes_status
FROM employees;

SELECT id, product_name, list_price, list_price - 2 AS holiday_price FROM products;
 
SELECT id, product_name, list_price, standard_cost,
list_price - standard_cost AS price_difference
FROM products;

SELECT id, product_id, unit_price, quantity,
unit_price * quantity AS total_price
FROM order_details;

SELECT id, product_id, unit_price, quantity, discount,
unit_price * quantity AS total_price,
unit_price * quantity * (1 - discount) AS total_price_with_discount
FROM order_details WHERE unit_price IS NOT NULL;

SELECT id, company, city,
LEFT(city, 3) AS short_city
FROM customers;

SELECT id, product_name, product_code,
RIGHT(product_code, 2) AS product_code_end
FROM products;

SELECT id, product_name,
SUBSTRING(product_name, 19, 2) AS product_short_name
FROM products;

SELECT id, product_name,
SUBSTRING(product_name, 19) AS product_short_name
FROM products;

SELECT id, first_name, last_name,
CONCAT(first_name, ' ', last_name) AS full_name
FROM employees;

SELECT id, 
CONCAT(ship_country_region, ', ', ship_state_province, ' ', ship_city, ', ', ship_address, ', ', ship_name) AS full_ship_address
FROM orders;

SELECT id, order_date, shipped_date,
CASE 
	WHEN shipped_date IS NOT NULL THEN shipped_date
    ELSE order_date
END AS display_date
FROM orders;

/*
const shipped_date = '2006-01-22';
const order_date = '2006-01-20';
const display_date = shipped_date || order_date;
*/

SELECT id, order_date, shipped_date,
COALESCE(shipped_date, order_date) AS display_date
FROM orders;

SELECT first_name, last_name, mobile_phone, business_phone, home_phone,
COALESCE(mobile_phone, business_phone, home_phone) AS contact_phone
FROM employees;

SELECT first_name, last_name, notes, 
COALESCE(notes, 'Not filled') as notes_text
FROM employees;

SELECT id, last_name, first_name FROM employees ORDER BY last_name DESC;

SELECT id, product_name, standard_cost FROM products ORDER BY standard_cost;

SELECT id, company, state_province, 
CASE
	WHEN state_province IN ('WA', 'CA') THEN 5
    WHEN state_province IN ('ID', 'OR') THEN 7
    WHEN state_province IN ('UT', 'NV') THEN 13
    ELSE 0
END AS discount_percent
FROM customers ORDER BY discount_percent;

SELECT company, state_province, city FROM customers ORDER BY state_province ASC, company;

SELECT id, product_id, unit_price, quantity,
unit_price * quantity AS total_price
FROM order_details ORDER BY total_price;

select id, payment_type,
COALESCE(payment_type, 'Not selected') AS payment_info
from orders;

select product_name, minimum_reorder_quantity,
COALESCE(minimum_reorder_quantity, 0) as reorder_quantity
from products;

select id, order_date, shipped_date from orders order by order_date ASC;

select product_name, category, list_price from products order by category,  list_price DESC;

select id, order_date from orders order by order_date DESC LIMIT 10;

SELECT id, product_name, list_price FROM products ORDER BY list_price DESC LIMIT 5;

select id, order_date from orders order by order_date DESC LIMIT 10 OFFSET 20;

SELECT DISTINCT city FROM customers ORDER BY city;

SELECT DISTINCT category FROM products ORDER BY category ASC;

SELECT DISTINCT ship_city, payment_type FROM orders ORDER BY ship_city, payment_type;

SELECT DISTINCT payment_type FROM orders ORDER BY payment_type DESC;