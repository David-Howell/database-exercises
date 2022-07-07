SELECT e.first_name, e.last_name, e.birth_date, dm.to_date
FROM employees e, dept_manager dm
WHERE e.emp_no IN (
    SELECT emp_no
    FROM dept_manager
    WHERE to_date > NOW()
)
AND dm.to_date > NOW()
GROUP BY e.first_name, e.last_name, e.birth_date, dm.to_date
-- LIMIT 10
;
SELECT first_name, last_name, birth_date
FROM employees
WHERE emp_no IN (
    SELECT emp_no
    FROM dept_manager
    WHERE to_date > NOW()
)
-- LIMIT 10
;

