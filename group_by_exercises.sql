/*
		Exercises
			Exercise Goals

		Use the GROUP BY clause to create more complex queries
			
        1.	Create a new file named group_by_exercises.sql

		2.	In your script, use DISTINCT to find the unique titles in the titles table. 
			•	How many unique titles have there ever been? 
				Answer that in a comment in your SQL file.
                */
			USE employees;
            SHOW TABLES;
            SELECT DISTINCT title
            FROM titles;
		-- 7 titles
/*
		3.	Write a query to to find a list of 
				all unique last names of 
                all employees that 
                start and end with 'E' 
                using GROUP BY.
                */
			SELECT last_name
            FROM employees
            WHERE	last_name LIKE 'e%e'
            GROUP BY last_name;
/*
		4.	Write a query to to find all unique combinations of 
				first and last names of all employees whose 
                last names start and end with 'E'.
                */
			SELECT 	first_name,
					last_name
			FROM employees
            WHERE	last_name LIKE 'e%e'
            GROUP BY 	first_name,
						last_name
			ORDER BY last_name, first_name
            ;
            
/*
		5.	Write a query to find the unique last names 
				with a 'q' but not 'qu'. 
                •	Include those names in a comment in your sql code.
                */
			SELECT last_name
            FROM employees
            WHERE last_name LIKE '%q%'
            AND last_name NOT LIKE '%qu%'
            GROUP BY last_name;
		-- Chleq
		-- Lindqvist
        -- Qiwen
/*
		6.	Add a COUNT() to your results (the query above) to 
				find the number of employees with the same last name.
                */
			SELECT last_name,
					COUNT(last_name)
            FROM employees
            WHERE last_name LIKE '%q%'
            AND last_name NOT LIKE '%qu%'
            GROUP BY last_name;
		-- Chleq		189
        -- Lindqvist	190
        -- Qiwen		168
/*
		7.	Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. 
				Use COUNT(*) and GROUP BY to find 
                the number of employees for each gender with those names.
                */
			SELECT first_name, COUNT(*), gender
            FROM employees
            WHERE first_name IN (
				'Irena',
                'Vidya',
                'Maya'
                )
			GROUP BY first_name, gender
            ORDER BY first_name;
                
/*
		8.	Using your query that generates a username for all of the employees, 
				generate a count employees for each unique username. 
                •	Are there any duplicate usernames? 
                •	BONUS: How many duplicate usernames are there?
				*/
			SELECT LOWER(CONCAT(
				SUBSTR(first_name, 1, 1), 
                SUBSTR(last_name, 1, 4), 
                '_',
                DATE_FORMAT(birth_date, '%m%y')
                -- SUBSTR(birth_date, 6, 2),
                -- SUBSTR(birth_date, 3, 2)
                )) AS username,
                first_name,
                last_name,
                birth_date,
                COUNT(LOWER(CONCAT(
				SUBSTR(first_name, 1, 1), 
                SUBSTR(last_name, 1, 4), 
                '_',
                DATE_FORMAT(birth_date, '%m%y')))) AS num_users
			FROM employees
            GROUP BY username, first_name, last_name, birth_date
            HAVING num_users > 1;
            
            SELECT LOWER(CONCAT(
				SUBSTR(first_name, 1, 1), 
                SUBSTR(last_name, 1, 4), 
                '_',
                DATE_FORMAT(birth_date, '%m%y')
                -- SUBSTR(birth_date, 6, 2),
                -- SUBSTR(birth_date, 3, 2)
                )) AS username,
                first_name,
                last_name,
                birth_date,
                COUNT(*) AS num_users
                FROM employees
                GROUP BY username, first_name, last_name, birth_date
                HAVING num_users > 1
                ;
            
		-- YES there are 6 duplicate user names
/*
		9.	Bonus: More practice with aggregate functions:

			•	Determine the historic average salary for each employee. 
					When you hear, read, or think "for each" with regard to SQL, 
                    you'll probably be grouping by that exact column.
                    */
			SELECT 	CONCAT(employees.first_name, ' ', employees.last_name) AS emp_name, 
					AVG(salary) AS average_salary
			FROM salaries, employees
            WHERE salaries.emp_no = employees.emp_no
            GROUP BY employees.emp_no
            LIMIT 1000;
/*			•	Using the dept_emp table, count how many current employees work in each department. 
					The query result should show 9 rows, 
                    one for each department and the employee count.
                    */
                    DESCRIBE dept_emp;
				-- emp_no, int
                -- dept_no, char(4)
                -- from_date, date
                -- to_date, date
                SELECT * FROM dept_emp
                WHERE dept_no = 'd005' AND to_date = '9999-01-01'
                limit 40;
			SELECT 	departments.dept_name, 
					COUNT(dept_emp.emp_no)
			FROM	departments, dept_emp
            WHERE	departments.dept_no = dept_emp.dept_no
            AND		to_date = '9999-01-01'
            GROUP BY departments.dept_name;
				

/*			•	Determine how many different salaries each employee has had. 
					This includes both historic and current.
                    */
				DESCRIBE salaries;
                SELECT * FROM salaries
                LIMIT 20;
                
                SELECT 	CONCAT(first_name, ' ', last_name) AS Emp_Name,
						COUNT(salary) AS Num_of_Salaries
					FROM	employees,
							salaries
					WHERE	employees.emp_no = salaries.emp_no
				GROUP BY salaries.emp_no
                -- HAVING Num_of_Salaries > 17
                ORDER BY Emp_Name
                ;
                
                
                
/*			•	Find the maximum salary for each employee.
				*/
			SELECT 	CONCAT(first_name, ' ', last_name) AS Emp_Name,
						MAX(salary) AS Maximum_Salary,
                        COUNT(salary) AS Num_of_Salaries
					FROM	employees,
							salaries
					WHERE	employees.emp_no = salaries.emp_no
				GROUP BY salaries.emp_no
                HAVING Num_of_Salaries > 17
                ORDER BY Maximum_Salary DESC
                LIMIT 100;
/*			•	Find the minimum salary for each employee.
/*			•	Find the standard deviation of salaries for each employee.
/*			•	Now find the max salary for each employee where that max salary is greater than $150,000.
/*			•	Find the average salary for each employee where that average salary is between $80k and $90k.