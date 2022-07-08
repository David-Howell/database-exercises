/*
		CASE STATEMENTS
        Our means of categorizing informationbased on trithful logic
        
        We will:
        Create conditions
        Get a result of said conditions
        These results. will fo toward an output
        */
        
        USE chipotle;
        
        -- orders is the only table here (no joins!)
        
        SELECT * FROM orders LIMIT 5;
        
        -- |	id	|	order_id	|	quantity	|	item_name	|	Choice_description	|	item_price	|
        
        SELECT item_name FROM orders WHERE item_name LIKE '%chicken%';
        
        -- picking from this list:
        -- grab Chicken Currito, crispy tacos, and soft tacos
        -- refer to this as chicken tortilla
        
        SELECT item_name,
				CASE item_name
					WHEN 'Chicken Bowl' THEN 'chickkybowl'
                    WHEN 'Chicken Burrito' THEN 'chickkyburrito'
                    ELSE 'something else'
				END
                AS modified_item_name
                FROM orders;
        
        SELECT COUNT(*),
        CASE
			WHEN item_name IN (	'Chicken Burrito', 
								'Chicken Crispy Tacos', 
                                'Chicken Soft Tacos') 
					THEN 'chicken_type_beat' 
                    ELSE 'something_else' 
                    END AS 'chicken_item_field'
			FROM orders
            GROUP BY chicken_item_field;
            
            
		-- IF statements
        
        SELECT item_name, 
				IF (item_name = 'chicken Burrito', TRUE, FALSE) AS is_chick_burr
                FROM orders;
                
		
        -- TEMP TABLES:
        
        SHOW DATABASES;
        USE leavitt_1877;
        SHOW TABLES;
        
        -- 
        CREATE TEMPORARY TABLE my_first_table (
			n INT UNSIGNED NOT NULL);
            
            SHOW TABLES;
           -- it won't show up, but dwe can use it 
            SELECT * FROM my_first_table;
            
            INSERT INTO my_first_table(n) VALUES (1), (2), (3), (10);
            
            SELECT * FROM my_first_table;
            
            ALTER TABLE my_first_table ADD bonus_col VARCHAR (30);
            
            SELECT * FROM my_first_table;
            -- Nevermind bonus columns suck
            ALTER TABLE my_first_table DROP COLUMN bonus_col;
            
            SELECT * FROM my_first_table;
            
            -- CREATE a table with multiple fields
            
            CREATE TEMPORARY TABLE tbl2 (
				col1 INT UNSIGNED NOT NULL,
                col2 VARCHAR(30));
                
			SELECT * FROM tbl2;
            
            INSERT INTO tbl2 (col1,col2) VALUES
				(3, 'hamsandwich'),
                (8, 'pizza'),
                (84, 'happy_friday');
                
			SELECT * FROM tbl2;
            
            DROP TABLE tbl2;
            SELECT * FROM tbl2;
            
            
            --
            CREATE TEMPORARY TABLE chipotle_copy(
            SELECT * FROM chipotle.orders);
            
            SELECT * FROM chipotle_copy;
            
            ALTER TABLE chipotle_copy ADD quant_plus INT;
            
            SELECT * FROM chipotle_copy LIMIT 5;
            -- BOOM! it's there!
            
            UPDATE chipotle_copy SET quant_plus = quantity + 1;
            -- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.

			SELECT quantity, quant_plus FROM chipotle_copy;
            
            ALTER TABLE chipotle_copy DROP COLUMN quantity;
            
            SELECT quant_plus FROM chipotle_copy;
			