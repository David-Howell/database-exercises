/*		Join Exercises
		David Howell
		2022-07-06

		Exercises
			Exercise Goals

Use join, left join, and right join statements on our Join Example DB
Integrate aggregate functions and clauses into our queries with JOIN statements
Create a file named join_exercises.sql to do your work in.

		Join Example Database

		1.	Use the join_example_db. Select all the records from both the users and roles tables.*/
        
        USE join_example_db;
        DESCRIBE users;
			-- id	name	email	role_id
        DESCRIBE roles;
			-- id	name
        SELECT * 
        FROM users
        JOIN roles
        ON users.role_id = roles.id;

/*		2. 	Use join, left join, and right join to combine results 
				from the users and roles tables as we did in the lesson. 
				Before you run each query, guess the expected number of results.*/
                
		SELECT * FROM users; -- 6 rows , 2 NULLS on role_id
        SELECT * FROM roles; -- 4 rows
        
        -- The below should have the 4 rows inclusive of both tables
        SELECT * FROM users u JOIN roles r ON u.role_id = r.id;			-- Yep!
        -- Next we should have 6 rows from the users without any missing
        SELECT * FROM users u LEFT JOIN roles r ON u.role_id = r.id;	-- Good again
        -- Next we have the 4 rows from the inner JOIN plus 1 from just the RIGHT table total 5
        SELECT * FROM users u RIGHT JOIN roles r ON u.role_id = r.id;	-- Boom bisquit!

/*		3.	Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. 
				Use count and the appropriate join type to get a list of roles along with the number of users that has the role. 
				Hint: You will also need to use group by in the query.*/
		
        SELECT r.name, COUNT(u.id)
		FROM users u, roles r
        WHERE u.role_id = r.id
        GROUP BY r.name
        ; -- Is the same as a Inner JOIN
        SELECT r.name, COUNT(u.id)
        FROM users u
        JOIN roles r
        ON u.role_id = r.id
        GROUP BY r.name
        ; -- Gives us the | admin : 1 | author : 2 | reviewer : 3 |
        SELECT r.name, COUNT(u.id)
        FROM users u
        LEFT JOIN roles r
        ON u.role_id = r.id
        GROUP BY r.name
        ; -- Gives us the | NULL : 2 | admin : 1 | author : 2 | reviewer : 3 |
        SELECT r.name, COUNT(u.id)
        FROM users u
        RIGHT JOIN roles r
        ON u.role_id = r.id
        GROUP BY r.name
        ; -- Gives us the | admin : 1 | author : 2 | reviewer : 3 | commenter : 0 |

/*		Employees Database
		
/*      1.	Use the employees database.*/
		USE employees;
        SHOW TABLES;
        -- 	| 	departments	|	dept_emp	|	dept_manager	|	employees	|	salaries	|	titles	|
        DESCRIBE departments;
        -- 	|	dept_no PRI	|	dept_name	|
        DESCRIBE dept_manager;
        -- 	|	emp_no PRI	|	dept_no PRI	|	from_date	|	to_date		|
        DESCRIBE employees;
        -- 	|	emp_no PRI	|	birth_date	|	first_name	|	last_name	|	gender	|	hire_date	|
        DESCRIBE dept_emp;
        -- 	|	emp_no PRI	|	dept_no PRI	|	from_date	|	to_date		|
        DESCRIBE salaries;
        -- 	|	emp_no PRI	|	salarty		|	from_date	|	to_date		|
        DESCRIBE titles;
        -- 	|	emp_no PRI	|	title PRI	|	from_datePRI|	to_date		|

/*		2.	Using the example in the Associative Table Joins section as a guide, 
				write a query that shows each department along with the name of the current manager for that department.*/
                
		SELECT 	d.dept_name Department_Name,
				CONCAT(e.first_name, ' ', e.last_name) Department_Manager
			FROM departments d
            JOIN dept_manager dm -- AND dm.to_date > NOW()
            USING(dept_no)
            JOIN employees e
            USING(emp_no)
            WHERE dm.to_date > NOW()
		GROUP BY 	Department_Name,
					Department_Manager
			-- HAVING dm.to_date > NOW()
        ;			

/*
		  Department Name    | Department Manager
		 --------------------+--------------------
		  Customer Service   | Yuchang Weedman
		  Development        | Leon DasSarma
		  Finance            | Isamu Legleitner
		  Human Resources    | Karsten Sigstam
		  Marketing          | Vishwani Minakawa
		  Production         | Oscar Ghazalie
		  Quality Management | Dung Pesch
		  Research           | Hilary Kambil
		  Sales              | Hauke Zhang
/*		3.	Find the name of all departments currently managed by women.*/

		SELECT 	d.dept_name Department_Name,
				CONCAT(e.first_name, ' ', e.last_name) Department_Manager
        FROM departments d
        JOIN dept_manager dm
        USING (dept_no)
        JOIN employees e
        USING(emp_no)
        WHERE e.gender = 'F' AND dm.to_date > NOW()
        GROUP BY 	Department_Name,
					Department_Manager
                    ;


/*
		Department Name | Manager Name
		----------------+-----------------
		Development     | Leon DasSarma
		Finance         | Isamu Legleitner
		Human Resources | Karsetn Sigstam
		Research        | Hilary Kambil

		4.	Find the current titles of employees currently working in the Customer Service department.*/
        -- dept_name : Customer service = dept_no : d009 IN departments
        -- Currently working is to_date IN titles AND IN employees
        -- titles AND employees match by emp_no
        -- dept_emp has dept_no and emp_no
        
        SELECT 	t.title Title, 
				COUNT(d.dept_name) Count, 
                d.dept_name Department
			FROM titles t
        JOIN employees e
			ON t.emp_no = e.emp_no
        JOIN dept_emp de
			ON de.emp_no = t.emp_no
        JOIN departments d
			ON d.dept_no = de.dept_no
        WHERE 	t.to_date > NOW() 
			AND de.to_date > NOW()
			AND de.dept_no = 'd009'
        GROUP BY t.title, d.dept_name
        LIMIT 100;
        


/*
		Title              | Count
		-------------------+------
		Assistant Engineer |    68
		Engineer           |   627
		Manager            |     1
		Senior Engineer    |  1790
		Senior Staff       | 11268
		Staff              |  3574
		Technique Leader   |   241

		5.	Find the current salary of all current managers.*/
        
        SELECT *
        FROM salaries
        WHERE to_date > NOW()
        ;
		SELECT *
        FROM dept_manager
        WHERE to_date > NOW()
        ;
		SELECT *
        FROM employees
        ;
        SELECT d.dept_name Department_Name, CONCAT(e.first_name, ' ', e.last_name) Name, s.salary Salary
        FROM dept_manager dm
        JOIN salaries s
        ON s.emp_no = dm.emp_no
        JOIN employees e
        ON dm.emp_no = e.emp_no
        JOIN departments d
        ON d.dept_no = dm.dept_no
        WHERE s.to_date > NOW() AND dm.to_date > NOW()
        ORDER BY d.dept_name
        ;
/*
		Department Name    | Name              | Salary
		-------------------+-------------------+-------
		Customer Service   | Yuchang Weedman   |  58745
		Development        | Leon DasSarma     |  74510
		Finance            | Isamu Legleitner  |  83457
		Human Resources    | Karsten Sigstam   |  65400
		Marketing          | Vishwani Minakawa | 106491
		Production         | Oscar Ghazalie    |  56654
		Quality Management | Dung Pesch        |  72876
		Research           | Hilary Kambil     |  79393
		Sales              | Hauke Zhang       | 101987

		6.	Find the number of current employees in each department.*/
        
        SELECT *
        FROM departments
        ;
        SELECT *
        FROM dept_emp
        WHERE to_date > NOW()
        ;
        SELECT d.dept_no,
				d.dept_name,
                COUNT(de.emp_no) num_employees
		FROM dept_emp de
        JOIN departments d
        ON d.dept_no = de.dept_no
        WHERE de.to_date > NOW()
        GROUP BY d.dept_no, d.dept_name
        ORDER BY d.dept_no
        ;


/*
		+---------+--------------------+---------------+
		| dept_no | dept_name          | num_employees |
		+---------+--------------------+---------------+
		| d001    | Marketing          | 14842         |
		| d002    | Finance            | 12437         |
		| d003    | Human Resources    | 12898         |
		| d004    | Production         | 53304         |
		| d005    | Development        | 61386         |
		| d006    | Quality Management | 14546         |
		| d007    | Sales              | 37701         |
		| d008    | Research           | 15441         |
		| d009    | Customer Service   | 17569         |
		+---------+--------------------+---------------+
		7.	Which department has the highest average salary? Hint: Use current not historic information.*/
        
        SELECT *
        FROM salaries s
        WHERE s.to_date > NOW()
        ;
        -- salaries has the salary and to_date with the emp_no
        -- dept_emp has the emp_no and the dept_no
        -- departments has the dept_no and the dept_name
        
        SELECT 	d.dept_name Department,
				AVG(s.salary) average_salary
        FROM salaries s
        LEFT JOIN dept_emp de
        ON s.emp_no = de.emp_no
        -- LEFT JOIN dept_manager dm
        -- ON s.emp_no = dm.emp_no
        JOIN departments d
        ON de.dept_no = d.dept_no
        WHERE s.to_date > NOW() AND de.to_date > NOW() -- AND dm.to_date > NOW()
        GROUP BY d.dept_name
        ORDER BY average_salary DESC
        LIMIT 1
        ;
        
/*
		+-----------+----------------+
		| dept_name | average_salary |
		+-----------+----------------+
		| Sales     | 88852.9695     |
		+-----------+----------------+
		8.	Who is the highest paid employee in the Marketing department?*/
		
        SELECT *
        FROM departments d
        WHERE dept_no LIKE '%1'
        ;
        SELECT *
        FROM salaries s
        ;
        SELECT * 
        FROM dept_emp de
        WHERE de.to_date > NOW()
        AND de.dept_no LIKE '%1'
        ;
        SELECT CONCAT(e.first_name,' ',e.last_name) Highest_paid_emp, s.salary Money
        FROM dept_emp de 
        JOIN salaries s 
        ON de.emp_no = s.emp_no AND de.to_date > NOW() AND de.dept_no LIKE '%1'
        JOIN employees e
        ON s.emp_no = e.emp_no AND s.to_date > NOW()
        ORDER BY s.salary DESC
        LIMIT 1
        ;

/*
		+------------+-----------+
		| first_name | last_name |
		+------------+-----------+
		| Akemi      | Warwick   |
		+------------+-----------+
		9.	Which current department manager has the highest salary?*/
        
        SELECT CONCAT(e.first_name,' ',e.last_name) Highest_paid_mgr, s.salary Money, d.dept_name
        FROM dept_manager dm 
        JOIN salaries s 
        ON dm.emp_no = s.emp_no AND dm.to_date > NOW() -- AND dm.dept_no LIKE '%1'
        JOIN employees e
        ON s.emp_no = e.emp_no AND s.to_date > NOW()
        JOIN departments d
        ON d.dept_no = dm.dept_no
        ORDER BY s.salary DESC
        LIMIT 1
        ;

/*
		+------------+-----------+--------+-----------+
		| first_name | last_name | salary | dept_name |
		+------------+-----------+--------+-----------+
		| Vishwani   | Minakawa  | 106491 | Marketing |
		+------------+-----------+--------+-----------+
		10.	Determine the average salary for each department. Use all salary information and round your results.*/
        
        SELECT * FROM departments d;
        SELECT * FROM dept_emp de;
        SELECT * FROM salaries s;
        -- START with de and JOIN d ON dept_no then join s on emp_no
        -- GROUP BY d.dept_name and AVG(s.salary)
        SELECT d.dept_name Department, ROUND(AVG(s.salary), 0) Average_Salary
        FROM dept_emp de
        JOIN departments d
        ON d.dept_no = de.dept_no
        JOIN salaries s
        ON de.emp_no = s.emp_no
        GROUP BY d.dept_name
        ORDER BY Average_Salary DESC
        ;

/*
			+--------------------+----------------+
			| dept_name          | average_salary | 
			+--------------------+----------------+
			| Sales              | 80668          | 
			+--------------------+----------------+
			| Marketing          | 71913          |
			+--------------------+----------------+
			| Finance            | 70489          |
			+--------------------+----------------+
			| Research           | 59665          |
			+--------------------+----------------+
			| Production         | 59605          |
			+--------------------+----------------+
			| Development        | 59479          |
			+--------------------+----------------+
			| Customer Service   | 58770          |
			+--------------------+----------------+
			| Quality Management | 57251          |
			+--------------------+----------------+
			| Human Resources    | 55575          |
			+--------------------+----------------+
			Bonus Find the names of all current employees, their department name, and their current manager's name.*/
            
            SELECT * FROM employees e;
            SELECT * FROM dept_emp de 		WHERE de.to_date > NOW();
            SELECT * FROM dept_manager dm	WHERE dm.to_date > NOW();
            SELECT * FROM departments d;
            
            SELECT CONCAT(e.first_name, ' ' ,e.last_name) Employee,
					d.dept_name Department,
                    CONCAT(em.first_name, ' ' ,em.last_name) Manager
            FROM departments d
            JOIN dept_emp de
            ON de.dept_no = d.dept_no AND de.to_date > NOW()
            JOIN dept_manager dm
            ON de.dept_no = dm.dept_no AND dm.to_date > NOW()
            JOIN employees e
            ON e.emp_no = de.emp_no 
            JOIN employees em
            ON dm.emp_no = em.emp_no
            ORDER BY Department, e.emp_no
            LIMIT 250000
            ;
            
            
            /*	THIS WAS BAD!! I FIXED IT ABOVE
            SELECT * -- CONCAT(e.first_name,' ',e.last_name) Emp_Name, d.dept_name Department, 
            -- We start with the departments which will have all the dept_name matched with the dept_no
            FROM departments d
            -- We JOIN the dept_manager ON the dept_no linking the managers to the department
            JOIN dept_manager dm
            -- We ADD that the managers should be current
            ON d.dept_no = dm.dept_no AND dm.to_date > NOW()
            -- Next we JOIN the dept_emp ON the dept_no linking each employee to the department
            JOIN dept_emp de
            -- We ADD that the employees should be current
            ON d.dept_no = de.dept_no AND de.to_date > NOW()
            -- We JOIN the employees ON emp_no and 
            -- since we've already made sure everything is current we don't have to do that again
            JOIN employees e
            ON e.emp_no = de.emp_no OR e.emp_no = dm.emp_no
            ;
            

/*
			240,124 Rows

			Employee Name | Department Name  |  Manager Name
			--------------|------------------|-----------------
			 Huan Lortz   | Customer Service | Yuchang Weedman

 .....
		Bonus Who is the highest paid employee within each department.*/
		
		/*SELECT *
        FROM
				(	SELECT *
					FROM departments  */
        
		SELECT 	d.dept_name Department,
				d.dept_no,
				CONCAT(e.first_name,' ',e.last_name) Employee,
                MAX(s.salary) Salary
        FROM departments d
        JOIN dept_emp de
        ON d.dept_no = de.dept_no AND de.to_date > NOW()
        JOIN salaries s
        ON de.emp_no = s.emp_no AND s.to_date > NOW() -- AND s.salary = MAX(s.salary)
        JOIN employees e
        ON s.emp_no = e.emp_no
        GROUP BY Department, Employee
        ;
        
        SELECT * FROM departments d;
        SELECT * FROM salaries s WHERE s.to_date >NOW();
        SELECT * FROM dept_emp de WHERE de.to_date >NOW();
        SELECT * FROM employees e ;
        
        SELECT msal.dept Department, CONCAT(ei.efn,' ',ei.eln) Employee, msal.sal Makes
        FROM
        (
        
        SELECT de.dept_no dno, MAX(s.salary) sal, d.dept_name dept
        FROM salaries s
        JOIN dept_emp de
        ON s.emp_no = de.emp_no AND de.to_date > NOW()
        JOIN departments d
        ON d.dept_no = de.dept_no
        GROUP BY de.dept_no
        ) msal
        JOIN
        (
        SELECT e.emp_no eno, s.salary sal, e.first_name efn, e.last_name eln, de.dept_no dno
        FROM salaries s
        JOIN employees e
        ON s.emp_no = e.emp_no AND s.to_date > NOW()
        JOIN dept_emp de
        ON de.emp_no = s.emp_no
        ) ei
        ON msal.sal = ei.sal AND msal.dno = ei.dno
        ORDER BY msal.dno
        ;