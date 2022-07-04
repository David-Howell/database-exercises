/*	SELECT Exercises:
	DAVID HOWELL
    2022-07-01 16:30:00
    */
    
-- 2. 	Use the albums_bd database (schema)
USE albums_db;

-- 3. 	Explore the structure of the albums table.
	-- a. 	How many rows are in the albums table?
    
SHOW TABLES;

--  1 row

	-- b. 	How many unique artist names are in the albums table?

SELECT DISTINCT artist FROM albums;

-- 23 unique artist names

	-- c. 	What is the Primary Key for the albums table?
DESCRIBE albums;
-- id - which is an INT UNSIGNED with AUTO_INCREMENT

	-- d. 	What is the oldest release date for any album in the albums table? 
    -- 	  	What is the most recent release date?
SELECT * FROM albums WHERE release_date < 2000 ORDER BY release_date;

-- 1967 - The Beatles - Sgt. Pepper's Lonely Hearts Club Band
/*  Wrong answer comments:
01:01:29	SELECT * FROM release_date WHERE release_date < 2000 
LIMIT 0, 1000	Error Code: 1146. Table 'albums_db.release_date' doesn't exist	0.046 sec


/*00:52:37	SELECT * release_date;	
Error Code: 1064. You have an error in your SQL syntax; 
check the manual that corresponds to your MySQL server version for the right syntax to use near 
'release_date' at line 1	0.050 sec

	SHOW * release_date FROM albums;
	  16:55:40	SHOW * release_date FROM albums	

Error Code: 1064. You have an error in your SQL syntax; 
check the manual that corresponds to your MySQL server version 
for the right syntax to use near '* release_date FROM albums' 
at line 1	
0.044 sec
*/

SELECT * FROM albums WHERE release_date >= 2000 ORDER BY release_date;
-- 2011 - Adele - 21

-- 4. Write queries to find the following information:
	-- a. The name of all albums by Pink Floyd
SELECT * FROM albums WHERE artist = 'Pink Floyd';
-- The Dark Side of the Moon 
-- The Wall

	-- b. The year Sgt. Pepper's Lonely Hearts Club Band was released
SELECT * FROM albums WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band';
-- 1967

	-- c. The genre for the album Nevermind
SELECT * FROM albums WHERE name = 'Nevermind';
-- Grunge, Alternative Rock

	-- d. Which albums were released in the 1990s
SELECT name FROM albums WHERE release_date >= 1990 AND release_date < 2000 ORDER BY release_date;
/* 	The Immaculate Collection
	Dangerous
	Metallica
    Nevermind
    The Bodygaurd
    Jagged Little Pill
    Falling into You
    Come on Over
    Let's Talk About Love
    Titanic: Music from the Motion Picture
    Supernatural
*/
	-- e. Which albums had less than 20 million certified sales
SELECT name FROM albums WHERE sales < 20 ORDER BY name;

/*	Abbey Road
	Bad
    Born in the U.S.A.
    Brothers in Arms
    Dangerous
    Dirty Dancing
    Grease: The Original Soundtrack from the Motion Picture
    Let's Talk About Love
    Nevermind
    Sgt. Pepper's Lonely Heart Club Band
    The Immaculate Collection
    The Wall
    Titanic: Music from the Motion Picture
*/

	-- f. All the albums with a genre of "Rock". 
    --    Why do these query results not include albums with 
    --    a genre of "Hard rock" or "Progressive rock"?
 
 SELECT * FROM albums WHERE genre = 'Rock';
 /* 
	Sgt. Pepper's Lonely Hearts Club Band
	1
    Abbey Road
    Born in the U.S.A.
    Supernatural
    
    The Reason we don't have Hard Rock and Progressive Rock 
    is because the genre field doesn't discern them as sub categories of Rock
    If you want to include those...
    */

SELECT * FROM albums WHERE genre = 'Rock' OR genre = 'Progressive rock' OR genre = 'Hard rock';

/*
	Additional Albums are:
    
    Back in Black
    The Dark Side of the Moon
    The Wall
    Appetitite for Destruction
    */
