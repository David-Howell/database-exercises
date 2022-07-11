/*
			Exercises
			Exercise Goals

			Use CASE statements or IF() function to explore information in the employees database
			Create a file named case_exercises.sql and craft queries to return the results for the following criteria:*/
			USE employees;
/*			1.	Write a query that returns all employees, 
											their department number, 
                                            their start date, 
                                            their end date, 
                                            and a new column 'is_current_employee' 
						that is a 1 if the employee is still with the company and 0 if not.*/
             SELECT * FROM dept_emp de;
             
             SELECT COUNT(emp_no), 
					CASE to_date 
						WHEN '9999-01-01' THEN 1 ELSE 0 
                        END 
					AS is_current_employee 
                    FROM dept_emp 
                    GROUP BY is_current_employee;
                    
			SELECT
				de.emp_no,
				de.dept_no,
				de.from_date AS start_date,
				de.to_date AS end_date,
				de.to_date > NOW() AS is_current_employee
			FROM dept_emp de
			ORDER BY emp_no
			LIMIT 100;
             
           
/*			2.	Write a query that returns all employee names (previous and current), 
											and a new column 'alpha_group' that returns 
												'A-H', 'I-Q', or 'R-Z' depending on 
                                                the first letter of their last name.*/
            SELECT COUNT(*), -- CONCAT(first_name,' ',last_name), 
					CASE 
						WHEN SUBSTR(last_name, 1, 1) BETWEEN 'A' AND 'H' THEN 'A-H'
                        WHEN SUBSTR(last_name, 1, 1) BETWEEN 'I' AND 'Q' THEN 'I-Q'
                        WHEN SUBSTR(last_name, 1, 1) BETWEEN 'R' AND 'Z' THEN 'R-Z'
					END AS 'alpha_group'
				FROM employees
                GROUP BY alpha_group;
                                                
/*			3.	How many employees (current or previous) were born in each decade?*/

			SELECT COUNT(birth_date),
					CASE
						WHEN birth_date BETWEEN '1950-01-01' AND '1959-12-31' THEN '1950s'
                        WHEN birth_date BETWEEN '1960-01-01' AND '1969-12-31' THEN '1960s'
                        WHEN birth_date BETWEEN '1970-01-01' AND '1979-12-31' THEN '1970s'
					END AS Born_in_the
				FROM employees
                GROUP BY Born_in_the;


/*			4.	What is the current average salary for each of the following department groups: 
								R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?*/
                                
			SELECT * FROM salaries LIMIT 10; -- emp_no | salary | from_date | to_date | for •current• need to_date > NOW()
            
            SELECT emp_no, salary
				FROM salaries
                WHERE to_date > NOW(); -- gives us the current salaries with emp_no
                
			SELECT * FROM dept_emp LIMIT 10; -- The emp_no lines up with the dept_no but again, we need •current• so to_date > NOW()