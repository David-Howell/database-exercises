/*
		GROUP BY: An Introduction to Aggregation
        
        select our schema
*/
		USE chipotle;
        
        SHOW TABLES;
        DESCRIBE orders;
/*		 	String types in fields: item_price,
									choice_description,
                                    item_name
			Num types in fields:	id (pk)
									order_id,
                                    quantity
*/							
		SELECT
        DISTINCT 	item_name,
					quantity
        FROM orders;
        
        -- some redundancy here:
        -- GROUP BY on its own works similar to DISTINCT
        
        SELECT item_name 
        FROM orders 
        GROUP BY item_name;
        
        -- GROUP BY with two columns:
        
        SELECT	item_name,
				quantity
		FROM orders
        GROUP BY item_name, quantity;
        
        -- First use-case of aggregative finctions
        -- in conjunction with GROUP BY
        
        -- Flexability:
        -- When using count inside of your aggregate call,
        -- we can use different field names. It will consistently
        -- give you the number of instances the grouped field contains
        -- it will be common to see COUNT(*)
        SELECT	item_name,
				COUNT(quantity)
		FROM orders
        GROUP BY item_name;
        
        -- Adding complexity with a WHERE clause:
        
        SELECT	item_name,
				COUNT(quantity) AS num_o_orders
		FROM orders
        WHERE item_name LIKE '%burrito%'
        -- AND CLAUSE doesn't work here
        GROUP BY item_name
        HAVING num_o_orders > 1
        ORDER BY num_o_orders DESC
        LIMIT 1;
        
        -- Select the fields we want
        SELECT item_name, item_price,
        -- if we are not grouping by a secondart field, what to do with it
        MAX(quantity) AS max_num_ordered
        -- From what table are we pulling
        FROM orders
        -- do we need a WHERE to narrow down
        WHERE item_name LIKE '%veggie%'
        -- for all grouped fields, specify order
        GROUP BY item_name, item_price
        -- do we want to narrow down our aggregated function value with a 
        -- 	HAVING
        HAVING max_num_ordered > 1;
        -- do we have an order to sort by?
        -- do we have a limit to the number of fields