USE sakila;
SHOW TABLES;
/* 
SELECT statements

Select all columns from the actor table. */
SELECT * FROM actor; -- ORDER BY last_name;

/*
Select only the last_name column from the actor table. */
SELECT last_name FROM actor;

/*
Select only the film_id, title, and release_year columns from the film table.*/
SELECT film_id, title, release_year FROM film;

/*
DISTINCT operator

Select all distinct (different) last names from the actor table.*/
SELECT DISTINCT(last_name) FROM actor;
-- SELECT COUNT(DISTINCT last_name) FROM actor; -- 121
/*
Select all distinct (different) postal codes from the address table.*/
SELECT * FROM address;
SELECT DISTINCT(postal_code) FROM address; 
/*
Select all distinct (different) ratings from the film table.*/
SELECT DISTINCT rating FROM film;
/*
WHERE clause

Select the title, description, rating, movie length columns from the films table that last 3 hours or longer.*/
DESCRIBE film;
SELECT * FROM film;
SELECT title, description, rating, length FROM film WHERE length >= (3*60);
/*
Select the payment id, amount, and payment date columns from the payments table for payments made on or after 05/27/2005.*/
SELECT * FROM payment;
SELECT payment_id, amount, payment_date FROM payment WHERE payment_date >= '2005-05-27' ORDER BY payment_date;
/*
Select the primary key, amount, and payment date columns from the payment table for payments made on 05/27/2005.*/
DESCRIBE payment;
-- SELECT payment_id, amount, payment_date FROM payment WHERE payment_date = '2005-05-27 *';
SELECT payment_id, amount, payment_date FROM payment WHERE payment_date >= '2005-05-27' AND payment_date < '2005-05-28';
/*
Select all columns from the customer table for rows that have a last names beginning with S and a first names ending with N.*/
-- SELECT * FROM customer WHERE last_name + ' ' + first_name LIKE 'S%n';
SELECT * FROM customer WHERE (last_name LIKE 'S%') AND (first_name LIKE '%n');
/*
Select all columns from the customer table for rows where the customer is inactive or has a last name beginning with "M".*/
SELECT * FROM customer WHERE active = 0 OR last_name LIKE 'M%';
/*
Select all columns from the category table for rows where the primary key is greater than 4 and the name field begins with either C, S or T.*/
DESCRIBE category;
-- SELECT * FROM category WHERE category_id > 4 AND name LIKE '^[C|S|T]';
SELECT * FROM category WHERE category_id > 4 AND (name LIKE 'C%' OR name LIKE 'S%' OR name LIKE 'T%');
/*
Select all columns minus the password column from the staff table for rows that contain a password.
Select all columns minus the password column from the staff table for rows that do not contain a password.
IN operator

Select the phone and district columns from the address table for addresses in California, England, Taipei, or West Java.
Select the payment id, amount, and payment date columns from the payment table for payments made on 05/25/2005, 05/27/2005, and 05/29/2005. (Use the IN operator and the DATE function, instead of the AND operator as in previous exercises.)
Select all columns from the film table for films rated G, PG-13 or NC-17.
BETWEEN operator

Select all columns from the payment table for payments made between midnight 05/25/2005 and 1 second before midnight 05/26/2005.
Select the film_id, title, and descrition columns from the film table for films where the length of the description is between 100 and 120.
LIKE operator

Select the following columns from the film table for rows where the description begins with "A Thoughtful".
Select the following columns from the film table for rows where the description ends with the word "Boat".
Select the following columns from the film table where the description contains the word "Database" and the length of the film is greater than 3 hours.
LIMIT Operator

Select all columns from the payment table and only include the first 20 rows.
Select the payment date and amount columns from the payment table for rows where the payment amount is greater than 5, and only select rows whose zero-based index in the result set is between 1000-2000.
Select all columns from the customer table, limiting results to those where the zero-based index is between 101-200.
ORDER BY statement

Select all columns from the film table and order rows by the length field in ascending order.
Select all distinct ratings from the film table ordered by rating in descending order.
Select the payment date and amount columns from the payment table for the first 20 payments ordered by payment amount in descending order.
Select the title, description, special features, length, and rental duration columns from the film table for the first 10 films with behind the scenes footage under 2 hours in length and a rental duration between 5 and 7 days, ordered by length in descending order.
JOINs

Select customer first_name/last_name and actor first_name/last_name columns from performing a left join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
Label customer first_name/last_name columns as customer_first_name/customer_last_name
Label actor first_name/last_name columns in a similar fashion.
returns correct number of records: 620
Select the customer first_name/last_name and actor first_name/last_name columns from performing a /right join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
returns correct number of records: 200
Select the customer first_name/last_name and actor first_name/last_name columns from performing an inner join between the customer and actor column on the last_name column in each table. (i.e. customer.last_name = actor.last_name)
returns correct number of records: 43
Select the city name and country name columns from the city table, performing a left join with the country table to get the country name column.
Returns correct records: 600
Select the title, description, release year, and language name columns from the film table, performing a left join with the language table to get the "language" column.
Label the language.name column as "language"
Returns 1000 rows
Select the first_name, last_name, address, address2, city name, district, and postal code columns from the staff table, performing 2 left joins with the address table then the city table to get the address and city related columns.
returns correct number of rows: 2
*/