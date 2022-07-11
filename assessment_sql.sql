SELECT NOW();

SELECT SUBSTR("Data Scienterrific", 10, LENGTH("Data Scienterrific"));

USE leavitt_1877;

CREATE TEMPORARY TABLE customers (
		id INT UNSIGNED NOT NULL,
        firstname VARCHAR(20),
		lastname VARCHAR(20),
        prod_id INT UNSIGNED);
        
CREATE TEMPORARY TABLE current_products (
		prod_id INT UNSIGNED NOT NULL,
        prod_desc VARCHAR(20));
        
INSERT INTO customers (id,firstname,lastname,prod_id) VALUES
				(1, 'joanne', 'smith', 2),
                (2, 'sam', 'jones', 3),
                (3, 'jorge', 'gutierrez', 1),
                (4, 'ann marie', 'hooper', 2),
                (5, 'stephanie', 'sanchez', NULL);
                
INSERT INTO current_products (prod_id, prod_desc) VALUES
			(1, 'phone'),
            (2, 'internet'),
            (3, 'security');

select c.firstname, c.lastname, cp. prod_desc from customers c join current_products cp using (prod_id) WHERE prod_id > 0;


CREATE TEMPORARY TABLE numbers (
		id INT UNSIGNED NOT NULL,
        n INT);
        
INSERT INTO numbers (id, n) VALUES
		(1,1),
        (2,6),
        (3,24),
        (4,2),
        (5,15);
        
        select avg(n), min(n), max(n), sum(n), std(n) from numbers;
        
        SELECT * FROM numbers WHERE n < 20 OR id >= 3;
        
        SELECT * FROM numbers WHERE n + 2 > 7 AND id < 4;
        
        SELECT COUNT(*) FROM numbers;
        
        select n, count(*) from numbers group by n;