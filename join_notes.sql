
USE join_example_db;

SHOW TABLES;
-- roles, users
DESCRIBE roles;
-- id int un-+ PRI
-- name varchar(100)
DESCRIBE users;
-- id int un-+ PRI 
-- name
-- email
-- role_id MUL
SELECT * FROM users;


-- INNER joins:
-- Inner joins will be our default join structure

SELECT *
FROM users
-- join all fields
JOIN roles
-- how do we want to make that connection
ON users.role_id = roles.id;

-- The Null values from the users.role_id and the Value from roles.id that don't have a match are both dropped

SELECT users.name, roles.name, role_id
FROM users AS u
-- join all fields
JOIN roles AS r
-- how do we want to make that connection
ON users.role_id = roles.id;

-- The FROM __ AS and the JOIN __ AS alias the whole statement
SELECT u.name AS user, r.name AS role, role_id
FROM users AS u
-- join all fields
JOIN roles AS r
-- how do we want to make that connection
ON u.role_id = r.id;

-- We also don't actually need the AS...

SELECT u.name user, r.name role, role_id
FROM users u
JOIN roles r
ON u.role_id = r.id;


-- Left/Right Joins

SELECT * FROM users u JOIN roles r ON r.id = u.role_id;

SELECT * FROM users u LEFT JOIN roles r ON r.id = u.role_id;

SELECT * FROM users u RIGHT JOIN roles r ON r.id = u.role_id;

-- LEFT and RIGHT JOINs are the same thing.
-- it just depends on what order you put your tables in your query


-- Change Schema
USE world;
-- see what's in there
SHOW TABLES;
-- 	city	country	 countrylanguage
	DESCRIBE city;
	-- ID int PRI
	-- Name	CountryCode	District	Population
	SELECT * FROM city; -- 4079 rows
    
    DESCRIBE country;
    -- Code CHAR(3) PRI
    SELECT * FROM country
    LIMIT 5;
    
    DESCRIBE countrylanguage;
    -- CountryCode CHAR(3) AND Language CHAR(30) = PRI
    
    SELECT*
    FROM city
    JOIN country
    ON city.countrycode = country.code
    JOIN countrylanguage
    ON country.code= countrylanguage.CountryCode
    ;

-- USING:
-- We need to use the keword ON when establishing equivalence between
-- with different foreign/primary key pair value names
-- but if they have the dame field nam, we can elect to use USING()

	SELECT *
    FROM city
    JOIN countrylanguage
    ON city.countrycode = countrylanguage.countrycode;
    
    SELECT *
    FROM city
    JOIN countrylanguage
    USING(CountryCode);