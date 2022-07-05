/*	Clauses
	Clauses are how we get specifically what we want
    (usually a single field or a combination of fields)
    
    WHERE: Five me results specifically under X conditions
    
    ORDER BY: Sort my results specifically to my needs
    
    LIMIT: Only five me some of the results back
    */
    
-- Show me what databases/schemas I have available
SHOW DATABASES;

-- USE the chema chipotle
USE chipotle;

-- SHOW TABLES I have available
SHOW TABLES;

-- Tell me what fields I have inside the orders table
DESCRIBE orders;

-- A good way to get a preview on our table:
-- LIMIT

SELECT * FROM orders LIMIT 5;

	/* 	Now that I know what the table fields look like 
		I have a better idea of narrowing down what I'm doing 
        
        WHERE comes at the end of a select statement,
        and it carries over
        
        A few different ways to use this so far:
        We need to specify what we want to narrow down
        establish equivalency: =
        LIKE: compare strung values
        BETWEEN: inclusive ranges
        inequality operators: <,>,<=,>=
        
        Give me everything in orders
        specifically, everything that has tomato in the item name
        */
        
SELECT * FROM orders WHERE item_name LIKE '%tomato%';

-- Give me the total unique item names with the word tomato

	/*	STRUCTURE:
		SELECT
        WHAT? - everything: *, some specific field
        at a specific field, (DISTINCT)
        FROM - WHERE this is coming from
        STIPULATIONS? Do we watn a *clause*to narrow this info
        
        USe a numerical compatison:
        Give me every choice_descrition, \
        but only if there were more than 3 ordered
        */
        
SELECT choice_description AS choice 
FROM orders
WHERE quantity > 3
AND choice_description <> 'nan';

SELECT *
FROM orders
WHERE quantity > 2
AND (
item_name LIKE '%tomato%'
OR choice_description LIKE '%rice%')
;

	/*	ORDER BY: How we sort our results
		*/
		-- SELECT everything
	SELECT *
		-- FROM the orders table
	FROM orders
		-- WHERE they ordered more than 2
	WHERE quantity > 2
		-- AND more specifically, where it also has
        -- tomato in the item_name or rice in the choice_description
	AND (
	item_name LIKE '%tomato%'
	OR choice_description LIKE '%rice%')
    ORDER BY quantity DESC
		-- Only give me the first 4 results
    LIMIT 4;
	
SELECT item_name, item_price FROM orders ;-- WHERE item_price > 10.00;
	-- The problem with the above query is that the item_price data type is VARCHAR not numerical