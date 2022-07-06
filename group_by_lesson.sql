/*
	GROUP BY
	Lesson Goals

		Understand how to use the GROUP BY clause
	Grouping results based on data in columns allows us to 
    remove duplicates, much like using DISTINCT. 
    We can also use GROUP BY in combination with aggregate functions.

	Using the GROUP BY clause
		GROUP BY specifies a column or columns to group by.

		SELECT column FROM table GROUP BY column_name;
/*
	GROUP BY returns only the unique occurrences of the column specified.
*/

		SELECT DISTINCT first_name
		FROM employees;
/*
	The above query should return the same result set as:


		SELECT first_name
		FROM employees
		GROUP BY first_name;
/*	
    You can specify ASC or DESC for our output by adding an ORDER BY to your clause after the GROUP BY.


		SELECT first_name
		FROM employees
		GROUP BY first_name 
		ORDER BY first_name DESC;
/*	
    We can also use multiple columns:


		SELECT last_name, first_name
		FROM employees
		GROUP BY last_name, first_name;
/*
	The above query will return all of the unique combinations of 
		first and last names, 
        grouped by thier last name sorted alphebetically, 
        and within each last name group.

	Any column(s) that appear in the SELECT should also be in the GROUP BY clause unless they have a 1-to-1 relationship or are at the same level of granularity.

Aggregate Functions
The functions we have seen so far look at data in a single column or possibly across an entire row. An aggregate function works with data across all the rows in our result set. There are many aggregate functions listed in the MySQL documentation page. COUNT() is the most commonly used, and that is the one we will be taking a look at here. Other useful aggregate functions include MIN, MAX, AVG, and SUM.

COUNT
The COUNT() function will return the number of non-null expression values in a result set.

For example, COUNT(expression) for a count of non-null values or COUNT(DISTINCT expression) for a count of non-null unique values.

If we are only concerned about the values in a given column, we can pass that column name to the COUNT() function:


SELECT COUNT(first_name)
FROM employees
WHERE first_name NOT LIKE '%a%';
This query will return a count of all first name values that do not have an a in them from the employees table. The result should be 118_195. If for some reason an employee's first name was NULL, it would not be counted here.

You will also commonly see this function used as COUNT(*) which returns the total number of rows in a dataset whether a row contains NULL values or not.

If we want to see how many rows are in our employees table, we can run:


SELECT COUNT(*) FROM employees;
Using GROUP BY with Aggregate Functions
We can combine our use of aggregate functions with the GROUP BY clause to produce more meaningful results.

If we want to find out how many unique first names that do not contain an 'a', we know we can use a GROUP BY, but we can also combine this with the aggregate COUNT function to find how many employees have each unique last name:


SELECT first_name, COUNT(first_name)
FROM employees
WHERE first_name NOT LIKE '%a%'
GROUP BY first_name;
This query will output each unique first name without an 'a', as well as the number of employees with that first name. Notice also that this query returns 500 results. While there are 118,195 employees with a first name that did not have the letter a, there are only 500 unique first names that do not have an 'a' in them.

Take the query below as another example:


SELECT hire_date, COUNT(*)
FROM employees
GROUP BY hire_date
ORDER BY COUNT(*) DESC
LIMIT 10;
This will show us the 10 most common hire dates for employees.

The COUNT() function will be the one you used most frequently, but there are many others such as SUM(), AVG(), MIN() and MAX(). There are even functions that do statistical analysis like STDDEV() and VARIANCE(). Using aggregates can save a lot of tedious looping and arithmetic on your end.

Adding Conditions to Group By with HAVING
So far, we have used WHERE in order to apply a condition to a column. WHERE does not work with aggregate values, like we get from applying an aggregate function to a group by. The appropriate tool for adding a conditional to a group by is to use HAVING. For example:


SELECT last_name, count(*) AS n_same_last_name
FROM employees
GROUP BY last_name
HAVING n_same_last_name < 150;
and


SELECT concat(first_name, " ", last_name) AS full_name, count(*) AS n_same_full_name
FROM employees
GROUP BY full_name
HAVING n_same_full_name >= 5;