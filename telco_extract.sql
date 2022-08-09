USE employees;

SELECT e.emp_no, e.hire_date FROM employees e; -- 

SELECT * FROM salaries s WHERE s.to_date > NOW(); -- emp_no, salary, from_date, to_date

SELECT * FROM titles; -- emp_no, title, from_date, to_date

		SELECT e.hire_date, s.salary
			FROM employees e
		JOIN salaries s
			ON s.emp_no = e.emp_no
		WHERE s.to_date > NOW();
        
        SELECT e.emp_no, e.hire_date, ss.salary starting_salary, s.salary current_salary
			FROM employees e
		JOIN salaries s
			ON s.emp_no = e.emp_no
        JOIN salaries ss
			ON e.emp_no = ss.emp_no
            WHERE s.to_date > NOW() AND ss.from_date = e.hire_date;
            
		SELECT e.emp_no, e.hire_date, COUNT(t.emp_no)
			FROM employees e
		JOIN titles t
			ON e.emp_no = t.emp_no
		GROUP BY e.emp_no;
/*Error Code: 1055. Expression #3 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'employees.t.title' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by

*/
USE employees;


		SELECT e.emp_no, e.gender, d.dept_name dept
			FROM employees e
		JOIN dept_emp de
			ON e.emp_no = de.emp_no
		JOIN departments d
			ON d.dept_no = de.dept_no
        ;
        
        SELECT * FROM departments; -- d001 = Marketing, d007 = Sales

		SELECT e.emp_no, e.gender, dm.emp_no manager
			FROM employees e
		LEFT JOIN dept_manager dm
			ON e.emp_no = dm.emp_no;
            
            
		USE iris_db;
        
        SHOW TABLES;
        
        SELECT * FROM measurements m
			JOIN species s
            ON s.species_id = m.species_id;
            
            
		USE telco_churn;
        
        SHOW TABLES;
        -- |contract_types|customer_churn|customer_contracts|customer_details
		-- |customer_payments|customer_signups|customer_subscriptions
        -- |customers|internet_service_types|payment_types
        
        SELECT * FROM internet_service_types; -- ON internet_service_type_id
        
        SELECT * FROM customers;
        
        -- SELECT * FROM customer_contracts cc; -- customer_id, 
        
		-- SELECT * FROM customer_churn LIMIT 2000; -- everyone churned in January
        
        SELECT * FROM contract_types;-- contract_type_id

		SELECT * FROM payment_types;-- payment_type_id
            
		-- SELECT * FROM customer_payments; -- don't need, redundant
        
        SELECT c.customer_id, c.gender, c.senior_citizen, c.partner, c.dependents, c.tenure, c.phone_service, c.multiple_lines,
			c.internet_service_type_id, ist.internet_service_type, c.online_security, c.online_backup, c.device_protection,
            c.tech_support, c.streaming_tv, c.streaming_movies, c.contract_type_id, ct.contract_type, c.paperless_billing,
            c.payment_type_id, pt.payment_type, c.monthly_charges, c.total_charges, c.churn
        
        FROM customers c
			JOIN internet_service_types ist
				ON c.internet_service_type_id = ist.internet_service_type_id
			JOIN contract_types ct
				ON c.contract_type_id = ct.contract_type_id
			JOIN payment_types pt
				ON c.payment_type_id = pt.payment_type_id;
                
-- Error Code: 1054. Unknown column 'c.dependants' in 'field list'
