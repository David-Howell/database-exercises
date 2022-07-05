/*		David Howell
		order_by_exercises.sql
        2022-07-05
        14:30
        */

/*	1.	Create a file named where_exercises.sql. Make sure to use the employees database.
	1.	Create a new file named order_by_exercises.sql and 
		copy in the contents of your exercise from the previous lesson.
		*/
    USE employees;

/*	2.	Find all current or previous employees with 
		first names 'Irena', 'Vidya', or 'Maya' using IN. 
		Enter a comment with the number of records returned.
	2.	Find all employees with first names 'Irena', 'Vidya', or 'Maya', and 
		order your results returned by first name. In your comments, answer: 
        • 	What was the first and last name in the first row of the results? 
        • 	What was the first and last name of the last person in the table?	
        */
		DESCRIBE employees;
		SHOW TABLES;
		SELECT * FROM employees 
		WHERE first_name IN ('Irena', 'Vidya', 'Maya')
        ORDER BY first_name;
	-- 709 rows returned
    -- Irena Reutenauer
    -- Vidya Simmen
        
/* 	3.	Find all current or previous employees with 
		first names 'Irena', 'Vidya', or 'Maya', as in Q2, 
		but use OR instead of IN. Enter a comment with the number of records returned. 
		• 	Does it match number of rows from Q2?
	3.	Find all employees with first names 'Irena', 'Vidya', or 'Maya', and 
		order your results returned by first name and then last name. 
        In your comments, answer: 
        • 	What was the first and last name in the first row of the results? 
        • 	What was the first and last name of the last person in the table?
        */
		SELECT * FROM employees
		WHERE 	first_name = 'Irena' OR
			first_name = 'Vidya' OR
            first_name = 'Maya'
		ORDER BY	first_name,
					last_name;
	-- YES 709 rows returned
    -- Irena Acton
    -- Vidya Zweizig
        
/*	4.	Find all current or previous employees with 
		first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. 
        • 	Enter a comment with the number of records returned.
	4.	Find all employees with first names 'Irena', 'Vidya', or 'Maya', and 
		order your results returned by last name and then first name. 
        In your comments, answer: 
        • 	What was the first and last name in the first row of the results? 
        • 	What was the first and last name of the last person in the table?
        ******** Becuase the first and last employee in the Results Grid are both male
        the question doesn't require that we filter for that, but that was in the original question ******
        */
        SELECT * FROM employees
        WHERE (
			first_name = 'Irena' OR
            first_name = 'Vidya' OR
            first_name = 'Maya' )
		ORDER BY 	last_name,
					first_name;
        -- AND
		-- 	gender = 'M';
	-- 441 rows returned
    -- Irena Acton
    -- Maya Zyda

/*	5.	Find all current or previous employees whose 
		last name starts with 'E'. 
        • 	Enter a comment with the number of employees whose last name starts with E.
	5.	Write a query to to find all employees whose 
		last name starts and ends with 'E'. 
        Sort the results by their employee number. 
        • 	Enter a comment with 
				the number of employees returned, 
				the first employee number and their first and last name, and 
				the last employee number with their first and last name.
        */
        SELECT * FROM employees
        WHERE last_name LIKE 'E%'
        ORDER BY emp_no;
	-- 7330 rows returned
    -- 10021 Ramzi Erde
    -- 499968 Dharmaraja Ertl
        
/*	6.	Find all current or previous employees whose 
		last name starts or ends with 'E'. 
        • 	Enter a comment with the number of employees whose last name starts or ends with E. 
        •	How many employees have a last name that ends with E, but does not start with E?
	6.	Write a query to to find all employees whose last name starts and ends with 'E'. 
		Sort the results by their hire date, 
        so that the newest employees are listed first. 
        • 	Enter a comment with 
				the number of employees returned, 
				the name of the newest employee, and 
				the name of the oldest employee.
        */
        SELECT * FROM employees
        WHERE 	last_name LIKE 'E%e'
        ORDER BY hire_date DESC;
	-- 899 rows returned
    -- Teiji Eldridge
    -- Sergi Erde

/*	7.	Find all current or previous employees whose 
		last name starts and ends with 'E'. 
        • 	Enter a comment with the number of employees whose last name starts and ends with E. 
        • 	How many employees' last names end with E, regardless of whether they start with E?
	7.	Find all employees hired in the 90s and born on Christmas. 
		Sort the results so that 
        the oldest employee who was hired last is the first result. 
        •	Enter a comment with 
				the number of employees returned, 
				the name of the oldest employee who was hired last, and 
                the name of the youngest employee who was hired first.
        */
        SELECT * FROM employees
        WHERE 	hire_date
        BETWEEN '1990-01-01' AND '1999-12-31'
        AND 	birth_date
        LIKE	'%12-25'
        ORDER BY birth_date DESC, hire_date DESC;
	-- 362 rows returned
    -- Gudjon Vakili
    -- Tremaine Eugenio
