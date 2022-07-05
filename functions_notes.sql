/*	FUNCTIONS
	
    Functions in SQL work similarly as they di in other programming
    languages, which you may not intuit since it is a 
    CRUD/query language
    
    •	User-defined finctions are possible, but ar outside the scope of what we will be going over today
    
    •	We can use them as a powerful tool to maipulate the data we are looking at in a way that makes things more...
    
    #	String functions
		Concatination, like/notlike, case fomatting, replacement, substrings
        
	#	Casting
		type formatting, concatination vs...
        
        
	String functions
    
    SELECT CONCAT ('ting1', 'thing2'); --- thing1thing2
    
    SUBSTR (subject_string, start_index, number of characters)
		substring gives a subset of a string, where you specify where you want int the sting by index, and how long you want to go
        
	REPLACE(subject_string, old, new)
    
    Case conversion UPPER(), LOWER()
    
*/
SELECT CONCAT('hi', ' ', 'leavitt');

-- Same as:
SELECT CONCAT('hi', ' leavitt');

-- We can also label it AS:
SELECT CONCAT('hi', ' leavitt') AS Message;

USE fruits_db;
SHOW TABLES;
SELECT * FROM fruits;

USE employees;

SHOW TABLES;
SELECT * FROM employees LIMIT 5;
SELECT CONCAT(first_name, ' ', last_name) AS 'Full Name'
FROM employees LIMIT 5;

-- substrings:
SELECT SUBSTR('Howdy leavitt', 2, 6);

SELECT SUBSTR(first_name, 1, 2) FROM employees LIMIT 5;

-- nesting:
SELECT CONCAT(SUBSTR(first_name, 1, 1), ' ', last_name)
FROM employees
LIMIT 20;

-- UPPER and LOWER:

SELECT UPPER(first_name) FROM employees LIMIT 20;

-- REPLACE

SELECT REPLACE('Hey $ $ $', '$', 'Leavitt');
SELECT REPLACE('Howdy $$$$', '$$$', 'Leavitt');


/*	DATE FUNCTIONS

	NOW()
		Return format: YYYY-MM-DD HH:MM:SS
	CURDATE()  : YYYY-MM-DD
    CURTIME()  : HH:MM:SS
    */
    
    SELECT NOW();
    
    SELECT UNIX_TIMESTAMP();
    
    /* MATH FUNCTIONS
    
    AVG()	Returns the mean
    
    MIN()	Returns the min
    
    MAX()	Returns the max
    
    We can use these within previous clauses for efficiency
    */
    
    SELECT * FROM employees LIMIT 5;
    SELECT MIN(emp_no) FROM employees;
    
    -- THIS DOESN'T WORK THOUGH 
    SELECT * FROM employees WHERE MIN(emp_no);
    
    
    /*	CASTING 
		Force a data type into a new data type
        */
        
	USE chipotle;
    SELECT * FROM orders LIMIT 5;
    
    -- WHEN utilizing cast, we separate the arguments with AS
    -- similarly to the way we do aliasing
    SELECT CAST('5.99' AS FLOAT);
    
    SELECT REPLACE('$5.99', '$', '');
    
    SELECT CAST(REPLACE(item_price, '$', '') AS FLOAT) AS numerical_price FROM orders;
    
    SELECT CONCAT( 'Calculations take about ', NOW() - NOW() , ' to calculate' ) AS 'No Time!';