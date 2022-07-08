/*
			Exercises
			Exercise Goals

			Use sub queries to find information in the employees database
			Create a file named subqueries_exercises.sql and craft queries to return the results for the following criteria:

			1.	Find all the current employees with the same hire date as employee 101010 using a sub-query.*/
            
            SELECT * 
            FROM dept_emp de
            JOIN employees e
            ON e.emp_no = de.emp_no
            AND hire_date = (
				SELECT hire_date
				FROM employees
				WHERE emp_no = 101010)
			AND de.to_date > NOW()
            ;

/*			2.	Find all the titles ever held by all current employees with the first name Aamod.*/

			-- titles —all regardless of current
            -- employees —current only
            -- employees —first name aamod
            
            SELECT * FROM employees WHERE first_name = 'Aamod';
            -- 216 rows            
            SELECT * FROM employees e JOIN dept_emp de ON e.emp_no = de.emp_no AND e.first_name = 'Aamod' AND de.to_date > NOW();
            -- 168 rows First Name and current | test emp_no's 11973, 15430
            SELECT * FROM titles WHERE emp_no IN (11973, 15430);
            
			SELECT title
            FROM titles 
            WHERE emp_no 
            IN (
					SELECT e.emp_no 
                    FROM employees e 
                    JOIN dept_emp de 
                    ON e.emp_no = de.emp_no AND e.first_name = 'Aamod' AND de.to_date > NOW())
			GROUP BY title
            ORDER BY title
            ;	


/*			3.	How many people in the employees table are no longer working for the company? 
					•	Give the answer in a comment in your code.*/
                    
			SELECT * FROM employees;
            SELECT * FROM dept_emp WHERE to_date < NOW();
            -- Will need not only roles that aren't active currently, but that were also not left for another role...
            -- Will need DISTINCT or GROUP BY emp_no's probably
            
            

/*			4.	Find all the current department managers that are female. List their names in a comment in your code.*/

/*			5.	Find all the employees who currently have a higher salary than the companies overall, historical average salary.*/

/*			6.	How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

					•	Hint You will likely use multiple subqueries in a variety of ways
					•	Hint It's a good practice to write out all of the small queries that you can. Add a comment above the query showing the number of rows returned. You will use this number (or the query that produced it) in other, larger queries.*/
/*			BONUS

/*			1.	Find all the department names that currently have female managers.*/
/*			2.	Find the first and last name of the employee with the highest salary.*/
/*			3.	Find the department name that the employee with the highest salary works in.*/