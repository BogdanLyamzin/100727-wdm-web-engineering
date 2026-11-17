use northwind;

DESCRIBE products;

SELECT CAST('2006-01-15 00:00:00' AS DATE) AS value;

SELECT CAST('2006-01-15' AS DATETIME) AS value;

SELECT CAST('name' AS SIGNED) AS str_to_number;

SELECT id, product_name, supplier_ids 
FROM products 
WHERE supplier_ids NOT LIKE '%;%'
ORDER BY CAST(supplier_ids AS UNSIGNED);

SELECT id, product_name, supplier_ids, 
CAST(supplier_ids AS UNSIGNED) AS supplier_id_number
FROM products 
WHERE supplier_ids NOT LIKE '%;%'
ORDER BY supplier_id_number;

SELECT id, invoice_date FROM invoices
WHERE invoice_date = '2006-03-22';
-- '2006-03-22 16:08:59' = '2006-03-22 00:00:00'

SELECT id, invoice_date FROM invoices
WHERE CAST(invoice_date AS DATE) = '2006-03-22';

SELECT id, product_name, 
CAST(list_price AS DECIMAL(10,2)) AS catalog_price FROM products;

SELECT id, CONCAT('Order №', id) AS order_label FROM orders;

SELECT id, product_name, list_price, 
list_price + '5' AS new_price
FROM products
ORDER BY new_price;

SELECT id, product_name FROM products WHERE id = '1';

SELECT CURDATE() AS today;

SELECT NOW() AS current_datetime;

SELECT id, order_date,
CURDATE() AS report_date,
NOW() AS report_datetime
FROM orders WHERE ship_city = 'Las Vegas';

SELECT DATEDIFF('2026-11-10', '2026-11-07') AS date_difference;

SELECT DATEDIFF('2026-11-07', '2026-11-10') AS date_difference;

SELECT DATEDIFF('2026-11-10 01:00:00', '2026-11-09 23:00:00') AS date_difference;

SELECT id, order_date, shipped_date,
DATEDIFF(shipped_date, order_date) AS shipping_days
FROM orders
ORDER BY shipping_days DESC;

SELECT * FROM orders WHERE id = 42;

SELECT 15 + NULL;

SELECT id, order_date, shipped_date,
DATEDIFF(shipped_date, order_date) AS shipping_days
FROM orders
WHERE shipped_date IS NOT NULL
ORDER BY shipping_days DESC;

SELECT id, creation_date, approved_date,
DATEDIFF(approved_date, creation_date) AS approval_days
FROM purchase_orders
WHERE approved_date IS NOT NULL
ORDER BY approval_days DESC;

SELECT id, invoice_date,
DATEDIFF(CURDATE(), invoice_date) AS invoice_age_days 
FROM invoices
ORDER BY invoice_age_days ASC;

SELECT id, submitted_date, approved_date,  
DATEDIFF(approved_date, submitted_date) AS days_to_approve
FROM purchase_orders
WHERE submitted_date IS NOT NULL
AND approved_date IS NOT NULL
ORDER BY days_to_approve DESC;

SELECT DAYNAME('2026-11-10') as day_name;

SELECT id, order_date,
DAYNAME(order_date) AS order_day
FROM orders;

SELECT DAYOFWEEK('2026-11-08') AS day_of_week;
SELECT DAYOFWEEK('2026-11-14') AS day_of_week;

SELECT id, approved_date,
DAYOFWEEK(approved_date) AS approval_day_number,
DAYNAME(approved_date) AS approval_day_name
FROM purchase_orders;

SELECT WEEKDAY('2026-11-09') AS day_of_week;
SELECT WEEKDAY('2026-11-15') AS day_of_week;

SELECT id, approved_date,
WEEKDAY(approved_date) AS approval_day_number,
DAYNAME(approved_date) AS approval_day_name
FROM purchase_orders;

SELECT id, order_date,
DAYNAME(order_date) AS order_day
FROM orders
WHERE WEEKDAY(order_date) BETWEEN 0 AND 4;

SELECT id, order_date,
DAYNAME(order_date) AS order_day
FROM orders
WHERE DAYOFWEEK(order_date) BETWEEN 2 AND 6;

SELECT id, order_date,
DAYNAME(order_date) AS order_day
FROM orders
WHERE DAYNAME(order_date) IN ('Monday', 'Tuesday', 'Wednesday', 'Thurday', 'Friday');

SELECT id, invoice_date,
CONCAT('Order №', id, ' - order day ', DAYNAME(invoice_date)) AS invoice_info
FROM invoices;

INTERVAL 5 DAY; -- WEEK, MONTH, YEAR, HOUR, MINUTE

SELECT DATE_ADD('2026-11-10', INTERVAL 5 DAY);
SELECT DATE_ADD(CURDATE(), INTERVAL 5 DAY);
SELECT DATE_ADD(CURDATE(), INTERVAL -5 DAY);

SELECT id, order_date,
DATE_ADD(order_date, INTERVAL 2 DAY) AS confirmation_deadline
FROM orders;

SELECT DATE_SUB('2026-11-10', INTERVAL 5 DAY);
SELECT DATE_SUB(CURDATE(), INTERVAL 5 DAY);
SELECT DATE_SUB(CURDATE(), INTERVAL -5 DAY);

SELECT id, order_date, shipped_date,
DATEDIFF(shipped_date, order_date) AS shipping_days,
DATEDIFF(DATE_ADD(order_date, INTERVAL 5 DAY), shipped_date) AS result
FROM orders
WHERE shipped_date IS NOT NULL
ORDER BY result ASC;

SELECT DATE_FORMAT('2026-11-10', '%d.%m.%Y');
SELECT DATE_FORMAT(CURDATE(), '%d.%m.%Y');
/*
%d - день
%m - месяц (всегда две цифры)
%Y - год (всегда 4 цифры)
%y - год (всегда две цифра)
%H - часы (всегда 2 цифры от 00 до 23)
%i - минуты (всегда 2 цифры)
%s - секунды (всегда 2 цифры)
%W - название для недели строкой
%M - название месяца
*/

SELECT id, order_date,
DATE_FORMAT(order_date, '%Y.%m.%d %H-%i-%s %W $M') AS full_order_date
FROM orders;