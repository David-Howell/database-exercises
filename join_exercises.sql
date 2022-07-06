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
        -- 	dept_no PRI	|	dept_name
        DESCRIBE dept_manager;
        -- 	|	emp_no PRI	|	dept_no PRI	|	from_date	|	to_date	|
        DESCRIBE employees;
        -- 	|	emp_no PRI	|	birth_date	|	first_name	|	last_name	|	gender	|	hire_date	|

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
/*		3.	Find the name of all departments currently managed by women.


/*
Department Name | Manager Name
----------------+-----------------
Development     | Leon DasSarma
Finance         | Isamu Legleitner
Human Resources | Karsetn Sigstam
Research        | Hilary Kambil

		4.	Find the current titles of employees currently working in the Customer Service department.


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

		5.	Find the current salary of all current managers.


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

		6.	Find the number of current employees in each department.


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
Which department has the highest average salary? Hint: Use current not historic information.


+-----------+----------------+
| dept_name | average_salary |
+-----------+----------------+
| Sales     | 88852.9695     |
+-----------+----------------+
Who is the highest paid employee in the Marketing department?


+------------+-----------+
| first_name | last_name |
+------------+-----------+
| Akemi      | Warwick   |
+------------+-----------+
Which current department manager has the highest salary?


+------------+-----------+--------+-----------+
| first_name | last_name | salary | dept_name |
+------------+-----------+--------+-----------+
| Vishwani   | Minakawa  | 106491 | Marketing |
+------------+-----------+--------+-----------+
Determine the average salary for each department. Use all salary information and round your results.


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
Bonus Find the names of all current employees, their department name, and their current manager's name.


240,124 Rows

Employee Name | Department Name  |  Manager Name
--------------|------------------|-----------------
 Huan Lortz   | Customer Service | Yuchang Weedman

 .....
Bonus Who is the highest paid employee within each department.