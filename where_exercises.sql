/*		David Howell
		where_exercises.sql
        2022-07-05
        11:45:00
        */

/*	1.	Create a file named where_exercises.sql. Make sure to use the employees database.
		*/
    USE employees;

/*	2.	Find all current or previous employees with 
		first names 'Irena', 'Vidya', or 'Maya' using IN. 
		Enter a comment with the number of records returned.
		*/
    DESCRIBE employees;
    SHOW TABLES;
    SELECT * FROM employees 
    WHERE first_name IN ('Irena', 'Vidya', 'Maya');
		-- 709 rows returned
        
/* 	3.	Find all current or previous employees with 
		first names 'Irena', 'Vidya', or 'Maya', as in Q2, 
		but use OR instead of IN. Enter a comment with the number of records returned. 
		• Does it match number of rows from Q2?
		*/
	SELECT * FROM employees
    WHERE 	first_name = 'Irena' OR
			first_name = 'Vidya' OR
            first_name = 'Maya';
		-- YES 709 rows returned
        
        
/*	4.	Find all current or previous employees with 
		first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. 
        • Enter a comment with the number of records returned.
        */
        SELECT * FROM employees
        WHERE (
			first_name = 'Irena' OR
            first_name = 'Vidya' OR
            first_name = 'Maya' )
		AND
			gender = 'M';
	-- 441 rows returned

/*	5.	Find all current or previous employees whose 
		last name starts with 'E'. 
        • Enter a comment with the number of employees whose last name starts with E.
        */
        SELECT * FROM employees
        WHERE last_name LIKE 'E%';
	-- 7330 rows returned
        
/*	6.	Find all current or previous employees whose 
		last name starts or ends with 'E'. 
        • Enter a comment with the number of employees whose last name starts or ends with E. 
        • How many employees have a last name that ends with E, but does not start with E?
        */
        SELECT * FROM employees
        WHERE 	last_name LIKE 'E%' or
				last_name LIKE '%e';
	-- 30723 rows returned | -h 30.7K
		SELECT * FROM employees
        WHERE	last_name NOT LIKE 'E%' AND
				last_name LIKE '%e';
	-- 23393 rows returned | -h 23.4K

/*	7.	Find all current or previous employees whose 
		last name starts and ends with 'E'. 
        • Enter a comment with the number of employees whose last name starts and ends with E. 
        • How many employees' last names end with E, regardless of whether they start with E?
        */
        SELECT * FROM employees
        WHERE 	last_name LIKE 'E%e';
	-- 899 rows returned
    
		SELECT * FROM employees
        WHERE 	last_name LIKE '%e';
	-- 24292 rows returned | -h 24.9K

/*	8.	Find all current or previous employees 
		hired in the 90s. 
        • Enter a comment with the number of employees returned.
        */
        SELECT * FROM employees
        WHERE	hire_date
        BETWEEN '1990-01-01' AND '1999-12-31'
        ORDER BY hire_date;
	-- 135214 rows returned | -h 135K

/*	9.	Find all current or previous employees 
		born on Christmas. 
        • Enter a comment with the number of employees returned.
        */
        SELECT * FROM employees
        WHERE 	MONTH(birth_date) = 12 AND
				DAY(birth_date) = 25;
	-- 842 rows returned
		/*	SELECT * FROM employees
			WHERE birth_date LIKE '%12-25'; -- Also works
        */

/*	10.	Find all current or previous employees 
		hired in the 90s and born on Christmas. 
        • Enter a comment with the number of employees returned.
        */
        SELECT * FROM employees
        WHERE	hire_date
		BETWEEN '1990-01-01' AND '1999-12-31'
        AND 	birth_date LIKE '%12-25'
        ORDER BY hire_date;
	-- 362 rows returned
    -- SELECT 135214 / 365; -- 370
        
/*	11.	Find all current or previous employees 
		with a 'q' in their last name. 
        • Enter a comment with the number of records returned.
        */
        SELECT * FROM employees
        WHERE last_name LIKE '%q%';
	-- 1873 rows returned

/*	12.	Find all current or previous employees 
		with a 'q' in their last name but not 'qu'. 
        • How many employees are found?
        */
        SELECT * FROM employees
        WHERE 	last_name LIKE '%q%'
        AND 	last_name NOT LIKE '%qu%'
        ORDER BY last_name;
	-- 547 rows returned