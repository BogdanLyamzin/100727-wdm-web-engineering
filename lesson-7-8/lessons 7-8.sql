CREATE DATABASE university;

USE university;
/*
название курса
ФИО учителя
дата начала курса
длительность в академических часах
цена
статус
онлайн/офлайн
может ли быть такое что с этим типом данных в эту колонку сохраниться неподходящее
с точки зрения бизнеса значение?
*/
CREATE TABLE courses (
	id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL UNIQUE,
    teacher_name VARCHAR(100),
    start_date DATE NOT NULL,
    duration_hours INT NOT NULL CHECK(duration_hours > 0),
    price DECIMAL(8,2) NOT NULL CHECK(price > 0),
    status VARCHAR(20) NOT NULL DEFAULT 'planned',
    is_online BOOLEAN NOT NULL DEFAULT TRUE
);
/*
coords VARCHAR(20) '34.23 32.22'
const [lat, lng] = station.coords.split(" ");
*/

CREATE TABLE students (
	id INT PRIMARY KEY AUTO_INCREMENT,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL,
    birth_date DATE NOT NULL CHECK(start_date < CURDATE()),
    registration_date DATE NOT NULL  DEFAULT CURDATE(),
    is_active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE teachers (
    id INT,
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(50),
    birth_date DATE NOT NULL CHECK(start_date < CURDATE()),
    contract_start_date DATE NOT NULL,
    hour_rate DECIMAL(8,2) CHECK(hour_rate > 0),
    is_online BOOLEAN NOT NULL DEFAULT TRUE,
    is_active BOOLEAN NOT NULL DEFAULT TRUE
);

INSERT INTO courses (
title,
teacher_name,
start_date,
duration_hours,
price,
status,
is_online
)
VALUES (
	'Javascript basic',
    'Anna Weber'.
    '2026-12-10',
    120,
    599.00,
    'planned',
    true
);

INSERT INTO courses (
 title,
 teacher_name,
 start_date,
 duration_hours,
 price,
 status,
 is_online
 )
 VALUES (
  'Javascript basic',
     'Anna Weber',
     '2026-12-10',
     120,
     599.00,
     'planned',
     true
 );	
 
 INSERT INTO courses (
 title,
 teacher_name,
 start_date,
 duration_hours,
 price
 )
 VALUES (
  'SQL for Beginners',
     'Max Fischer',
     '2026-12-10',
     80,
     399.00
 );	
 
 INSERT INTO courses (
 title,
 teacher_name,
 start_date,
 duration_hours,
 price,
 status,
 is_online
 )
 VALUES (
  'Frontend Advanced',
     'Olena Ivanova',
     '2027-01-15',
     96,
     749.00,
     'planned',
     true
 ),
 (
  'Python Basic',
     'David Klein',
     '2027-02-03',
     72,
     429.00,
     'planned',
     false
 )
 ;	
 
 INSERT INTO courses (
 title,
 teacher_name,
 start_date,
 duration_hours,
 price,
 status,
 is_online
 )
 VALUES (
  'Javascript',
     'Anna Weber',
     '2026-12-10',
     120,
     599.00,
     'planned',
     NULL
 );	
 
SELECT id, title, status from courses WHERE title = 'Javascript basic';

UPDATE courses
SET status = 'active'
WHERE title = 'Javascript basic';

SELECT id, title, price, status from courses WHERE title = 'SQL for Beginners';

UPDATE courses
SET 
	price = 349.00,
    status = 'active'
WHERE title = 'SQL for Beginners';

SELECT id, title, price, status from courses WHERE title = 'SQL for Beginners';

SELECT id, title, duration_hours from courses WHERE title = 'Python basic';

UPDATE courses
SET duration_hours = duration_hours + 10
WHERE title = 'Python basic';

SELECT id, title, duration_hours from courses WHERE title = 'Python basic';

SELECT id, title, status from courses WHERE status = 'planned';

UPDATE courses
SET status = 'active'
WHERE id > 0;

SELECT @@SQL_SAFE_UPDATES;

SET @previous_safe_updates = @@SQL_SAFE_UPDATES;

SET @@SQL_SAFE_UPDATES = 0;

UPDATE courses
SET status = 'planned'
WHERE status = 'active';

SET @@SQL_SAFE_UPDATES = @previous_safe_updates;

CREATE TABLE courses_copy AS SELECT * FROM courses;

CREATE TABLE courses_active AS SELECT * FROM courses WHERE status = 'active';

CREATE TABLE discounted_courses 
AS SELECT title, price, price * 0.9 AS discounted_price
FROM courses;

UPDATE courses
SET price = 999.00
WHERE title = 'Javascript basic';

SELECT id, title, price, price * 0.9 AS discounted_price FROM courses;

CREATE VIEW discounted_courses 
AS SELECT id, title, price, price * 0.9 AS discounted_price 
FROM courses;

SELECT * FROM discounted_courses; -- SELECT id, title, price, price * 0.9 AS discounted_price FROM courses;

SELECT id, title, duration_hours,
CASE
	WHEN duration_hours <= 60 THEN 'short'
    WHEN duration_hours <= 100 THEN 'medium'
    ELSE 'long'
END AS duration_category
 FROM courses;
 
CREATE OR REPLACE VIEW courses_with_duration_category AS 
SELECT id, title, duration_hours,
CASE
	WHEN duration_hours <= 50 THEN 'short'
    WHEN duration_hours <= 100 THEN 'medium'
    ELSE 'long'
END AS duration_category
 FROM courses;
 
SELECT * FROM courses_with_duration_category;	

CREATE OR REPLACE MATERIALIZED VIEW courses_with_duration_category AS 
SELECT id, title, duration_hours,
CASE
	WHEN duration_hours <= 50 THEN 'short'
    WHEN duration_hours <= 100 THEN 'medium'
    ELSE 'long'
END AS duration_category
 FROM courses;
 
REFRESH MATERIALIZED VIEW courses_with_duration_category;