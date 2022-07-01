-- SQL Tables Exercises 
-- DAVID HOWELL
-- 2022-07-01

USE employees;

SHOW TABLES;
-- The above SHOW TABLES commands give us the lisst below:

-- departmetns
-- dept_emp
-- dept_manager
-- employees
-- salaries
-- titles


DESCRIBE departments;
-- departments contatins dept_no CHAR(4) Primary Key and a dept_name VARCHAR(40) to name the departments
DESCRIBE dept_emp;
-- dept_emp contains 2 Primary Keys emp_no INT and dept_no CHAR(4) is the same probably from departments
-- it also then had a from_date DATE and to_date DATE which are both dates
-- all fields are NO Null
DESCRIBE dept_manager;
-- dept_manager is set up exactly the same as the dept_emp, probably just duplicated the table
DESCRIBE employees;
-- employees has the emp_no INT as it's only Primary Key which is used in the dept_emp and dept_manager tables as well
-- it includes the birth_date DATE first_name VARCHAR(14) and last_name VARCHAR(16)
-- gender is ENUM('M','F') which only allows 'M' or 'F' as possible values?
-- and hire_date DATE
DESCRIBE salaries;
-- salaries has 2 Primary Keys the emp_no INT from employees and the from_date DATE
-- (likely to show seniority, and automate the generation of the key) The drawback being that you can't hire two employees on the same day smh
-- the other two fields are salary INT and to_date DATE
-- all fields are NO null
DESCRIBE titles;
-- The titles table has 3 Primary keys emp_no INT from_date DATE and title VARCHAR(50)
-- seems inconvienient that there can only be one title per employee and not multiple eployees with the same title..
-- it also has the to_date as a field

-- Which tables do you think contain a numeric type column?
-- ALL with the exception of departments

-- Which tables do you think contain a string type column?
-- ALL with the exception of titles

-- Which tables do you think contain a date type column?
-- ALL with the exception of departments

-- What is the relationship between the employees and the departments tables?
-- The dept_no Primary Keys in dept_emp and dept_manager match the department table
-- The emp_no Primary Keys in dept_emp and dept_manager match the employees table

-- Show the SQL that created the dept_manager table

SHOW CREATE TABLE dept_manager;
-- 'dept_manager', 'CREATE TABLE `dept_manager` (\n  `emp_no` int NOT NULL,\n  `dept_no` char(4) NOT NULL,\n  `from_date` date NOT NULL,\n  `to_date` date NOT NULL,\n  PRIMARY KEY (`emp_no`,`dept_no`),\n  KEY `dept_no` (`dept_no`),\n  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,\n  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT\n) ENGINE=InnoDB DEFAULT CHARSET=latin1'


