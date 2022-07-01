-- CRUD
-- create, read, update, delete
-- DDL: data defenition language: create, update, delete
-- DML: data manipulation language: read!

-- SELECT is the primary read statement that we will be using

-- SLECT (bring me information)
-- __subject__ (dield names, computations, etc.)
-- FROM (what tavle do you want this information from? ist it from a table?)
-- __source __ (either with a bot notation or living inside of a schema)

SHOW DATABASES;

/* SELECT (*: every field) FROM schema chipotle 
and table named orders */
SELECT * FROM chipotle.orders;

-- lets change to the fruits db
USE fruits_db;
-- Show me what tables are here. (looks like its just fruits)
SHOW TABLES;
-- show me (SELECT) everything(*) FROM the table I want (fruits)
SELECT * FROM fruits;
-- more info on the table?
DESCRIBE fruits;

-- select only specific fields?
SELECT name FROM fruits;
-- more than one?
SELECT id, name FROM fruits;
-- give me evrything in the fruits table (all Fields) where the name field
-- matches the string 'mango'

SELECT * FROM fruits WHERE name = 'mango';

/* basic clause:
	coming after the select statement, after wher we are pulling from
	we specify what filter we want: WHER clause, based on fruits_db.fruits.name
    match it where the cell values inside of fruits.name match mango
    
    sytax:
    equivalence is denoted by a single =
    string values exist inside of 'single quotes'
    
    DISTINCT will give us unique values is a field */
SELECT DISTINCT name FROM fruits;

SELECT DISTINCT name, quantity FROM fruits;

-- This gives us only the unique values. use DISTINCT before the name of the column we're wanting

-- We can utilize more numerical comparisons with WHERE
SELECT * FROM fruits WHERE quantity > 2;

SELECT * FROM fruits WHERE quantity >= 2;

/*	Comparison operators:
	
    = equals
    !=, <> not equal
    <, > lass than, greater than
    <=, >= less than or equal, greater than or equal
    BETWEEN means greater than or equal to first value, less than or equal to second value (chained with an AND) */
    
SELECT * FROM fruits_db.fruits WHERE quantity BETWEEN 2 AND 15;

SELECT 'this is some output';

SELECT 2=2;

SELECT 2=3;

SELECT 2+3;

SELECT 2+4, 'This is some output';

SELECT 2=2, 2+3, 2 BETWEEN 3 AND 5;

-- 	aliasing:

SELECT 2=2 AS 'equivalency_demo';

SELECT 2=3 AS equivalency_demo_1;

SELECT name AS fruit_type FROM fruits;
