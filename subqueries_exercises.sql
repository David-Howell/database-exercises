/*
			Exercises
			Exercise Goals

			Use sub queries to find information in the employees database
			Create a file named subqueries_exercises.sql and craft queries to return the results for the following criteria:

			1.	Find all the current employees with the same hire date as employee 101010 using a sub-query.*/
            
            -- This one used a join... the one below this uses no joins
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
				
                SELECT * 										-- SELECT employees whose hire_date matches below
					FROM employees 
                    WHERE hire_date =	(
						SELECT hire_date					-- SELECT the hire date that 101010 has 
							FROM employees
							WHERE emp_no = 101010)
								AND emp_no IN	(		-- Make sure emp_no's are in th below
									SELECT emp_no	-- SELECT the emp_no's current to a dept
										FROM dept_emp
										WHERE to_date > NOW())
                                ; -- 55 rows

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
									ON e.emp_no = de.emp_no 
										AND e.first_name = 'Aamod' 
											AND de.to_date > NOW())
			GROUP BY title
            ORDER BY title
            ;	/*	Assistant Engineer
					Engineer
					Senior Engineer
                    Senior Staff
                    Staff
                    Technique Leader


/*			3.	How many people in the employees table are no longer working for the company? 
					•	Give the answer in a comment in your code.*/
                    
			SELECT * FROM employees;
            SELECT * FROM dept_emp WHERE to_date < NOW(); -- 91479
            SELECT * FROM dept_emp WHERE to_date > NOW(); -- 240124
            -- Will need not only roles that aren't active currently, but that were also not left for another role...
            -- Will need DISTINCT or GROUP BY emp_no's probably
            -- Maybe just make a list of all employees that have a 9999 to_date and subtract that from the total
            SELECT DISTINCT emp_no
				FROM dept_emp
                WHERE to_date < NOW() 
                AND emp_no NOT IN (
						SELECT emp_no 
                        FROM dept_emp 
                        WHERE to_date > NOW())
				ORDER BY emp_no DESC LIMIT 300000; 

            -- 59900
            SELECT emp_no 						-- SELECT emp_no's from employees 
				FROM employees
				WHERE emp_no				-- WHERE they're no in the below
					NOT IN (
						SELECT emp_no 	-- SELECT emp_no's current to departments
							FROM dept_emp 
							WHERE to_date > NOW());
/*            
            SELECT emp_no
				FROM salaries
                WHERE to_date < NOW()
                AND emp_no NOT IN (
						SELECT emp_no
                        FROM salaries
                        WHERE to_date > NOW())
                        GROUP BY emp_no
				ORDER BY emp_no LIMIT 300000; -- 
                
                SELECT emp_no
                        FROM salaries
                        WHERE to_date > NOW();
*/
/*			4.	Find all the current department managers that are female. List their names in a comment in your code.*/
			
            -- Find all the current managers
            SELECT * FROM dept_manager WHERE to_date > NOW();
            -- Find all the times those emp_no turn up in a selection of only gender = 'F'
            SELECT * FROM employees WHERE gender = 'F';
            
            SELECT first_name, last_name						-- SELECT names from employees who are in below managers	
				FROM employees
				WHERE emp_no IN	(
							SELECT emp_no					-- emp_no that are currently a dept_manager and IN below
								FROM dept_manager 
								WHERE to_date > NOW()		
									AND emp_no IN	(
										SELECT emp_no 	-- SELECT emp_no identifying 'F'
											FROM employees	
											WHERE gender = 'F'
								));
			
            /*	Isamu	Legleitner
				Karsten	Sigstam
                Leon	DasSarma
                Hillary	Kambil
                */

/*			5.	Find all the employees who currently have a higher salary than the companies overall, historical average salary.*/

			-- Current Salaries with their emp_no > AVG(salary) all-time, not current
            
            SELECT ROUND(AVG(salary)) FROM salaries;
            SELECT * FROM salaries WHERE to_date > NOW() AND salary > (SELECT ROUND(AVG(salary)) FROM salaries);
			
            SELECT CONCAT(first_name,' ',last_name) FROM employees WHERE emp_no IN
            (SELECT emp_no FROM salaries WHERE to_date > NOW() AND salary > (SELECT ROUND(AVG(salary)) FROM salaries));
            
/*			6.	How many current salaries are within 1 standard deviation of the current highest salary? 
					(Hint: you can use a built in function to calculate the standard deviation.) 
                    •	What percentage of all salaries is this?
					•	Hint You will likely use multiple subqueries in a variety of ways
					•	Hint It's a good practice to write out all of the small queries that you can. 
						Add a comment above the query showing the number of rows returned. 
                        You will use this number (or the query that produced it) in other, larger queries.*/
                        
				-- §The COUNT of §all current salaries WHERE salary >= §MAX(salary) - §1 STD(cur_salary)
                
                SELECT salary FROM salaries WHERE to_date > NOW(); -- This grabs all curent salaries | Alias as a table
                SELECT MAX(salary) FROM salaries WHERE to_date > NOW(); -- 158220 is the Scalar highest salary
                SELECT STD(all_cur_sals) FROM(SELECT salary all_cur_sals FROM salaries WHERE to_date > NOW())acs; -- Finds the STD of all current salaries 17,310
                SELECT COUNT(salary) FROM salaries WHERE to_date > NOW(); -- 240124 current salaries
                
                
                SELECT COUNT(salary) FROM salaries WHERE to_date > NOW() AND
						
                        salary >= ((SELECT MAX(salary) FROM salaries WHERE to_date > NOW())
								- (SELECT STD(all_cur_sals) FROM(SELECT salary all_cur_sals FROM salaries WHERE to_date > NOW())acs))
                ; -- 83
                SELECT CONCAT(83 / 2401.24, ' %') Percentage;
				
                SELECT CONCAT((
                        SELECT COUNT(salary) 
                        FROM salaries 
                        WHERE to_date > NOW() AND
                        salary >= 	(
							(
                            SELECT MAX(salary) 
                            FROM salaries 
                            WHERE to_date > NOW()
                            )- 
                                (
                                SELECT STD(all_cur_sals) 
                                FROM (
									SELECT salary all_cur_sals 
                                    FROM salaries 
                                    WHERE to_date > NOW()
										)acs
								)
									)
							)/	(
                        (
						SELECT COUNT(salary) 
                        FROM salaries 
                        WHERE to_date > NOW()
                        )/100
								), ' %') 'Percent of Salaries within 1 STD of Highest Salary'
                        ; -- 0.0346% 

/*			BONUS

/*			1.	Find all the department names that currently have female managers.*/

			-- I took the query from 4. above and...
			SELECT e.first_name, e.last_name, d.dept_name 	-- added d.dept_name and e.'s to prep joining
				FROM employees e							-- alias employees AS e
                JOIN dept_manager dm						-- JOIN dept_manager TABLE to put the emp_no together with the dept_no
                ON e.emp_no = dm.emp_no 
                JOIN departments d							-- JOIN the departments TABLE to get the dept_name from the dept_no
                ON d.dept_no = dm.dept_no
				WHERE e.emp_no IN           
            (
            SELECT emp_no
				FROM dept_manager 
                WHERE to_date > NOW()
                AND emp_no IN 
			(
			SELECT emp_no 
				FROM employees	
				WHERE gender = 'F'
								));
            /*	Isamu	Legleitner	Finance
				Karsten	Sigstam		Human Resources
                Leon	DasSarma	Development
                Hillary	Kambil		Research
                */                    
			
            
/*			2.	Find the first and last name of the employee with the highest salary.*/

			SELECT CONCAT(first_name,' ',last_name) 'Top Paid Emp' 
				FROM employees 							-- SELECT the name of the emp_no from salaries from below
                WHERE emp_no = (
					SELECT emp_no 					-- SELECT the emp_no from salaries where it equals the MAX(salary)
						FROM salaries 
						WHERE salary = (
							SELECT MAX(salary) 	-- SELECT the MAX(salary) currently
								FROM salaries 
                                WHERE to_date > NOW()
										)
								);            
            -- TOKUYASU PESCH

/*			3.	Find the department name that the employee with the highest salary works in.*/

			SELECT dept_name Department 							-- dept_name that matches the dept_no below
				FROM departments 
                WHERE dept_no = (
					SELECT dept_no								-- dept_no the at matches the emp_no below
						FROM dept_emp
                        WHERE emp_no = (
							SELECT emp_no 					-- emp_no that matches the MAX(salary) below
								FROM salaries 
								WHERE salary = (
									SELECT MAX(salary) 	-- MAX(salary) currently
										FROM salaries 
										WHERE to_date > NOW()
												)
										)
								);
			-- SALES