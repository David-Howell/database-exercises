/*	SELECT Exercises:
	DAVID HOWELL
    2022-07-01 16:30:00
    */
    
-- 2. 	Use the albums_bd database (schema)
USE albums_db;

-- 3. 	Explore the structure of the albums table.
	-- a. 	How many rows are in the albums table?
SHOW TABLES;
SELECT * FROM albums; -- ORDER BY release_date;
--  31 rows

	-- b. 	How many unique artist names are in the albums table?
SELECT COUNT(DISTINCT artist) AS number_of_artists FROM albums;
-- 23 unique artist names

	-- c. 	What is the Primary Key for the albums table?
DESCRIBE albums;
-- id - which is an INT UNSIGNED with AUTO_INCREMENT

	-- d. 	What is the oldest release date for any album in the albums table? 
    -- 	  	What is the most recent release date?
SELECT MIN(release_date) FROM albums;
-- 1967 - The Beatles - Sgt. Pepper's Lonely Hearts Club Band

SELECT MAX(release_date) FROM albums;
-- 2011 - Adele - 21

-- Another way to do this would be: 
-- [Uncomment the line below to see a Reslut Grid with all albums listed from earliest to latest]
-- SELECT * FROM albums ORDER BY release_date;

-- 4. Write queries to find the following information:
	-- a. The name of all albums by Pink Floyd
SELECT name FROM albums WHERE artist = 'Pink Floyd';
-- The Dark Side of the Moon 
-- The Wall

	-- b. The year Sgt. Pepper's Lonely Hearts Club Band was released
SELECT release_date FROM albums WHERE name = 'Sgt. Pepper\'s Lonely Hearts Club Band';
-- 1967

	-- c. The genre for the album Nevermind
SELECT genre FROM albums WHERE name = 'Nevermind';
-- Grunge, Alternative Rock

	-- d. Which albums were released in the 1990s
SELECT name FROM albums WHERE release_date >= 1990 AND release_date < 2000 ORDER BY release_date;
SELECT name FROM albums WHERE release_date BETWEEN 1990 AND 1999 ORDER BY release_date;
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
-- The below gives a perhaps more usefull Results Grid with each album under 20M in sales ordered by sales
SELECT name, sales FROM albums WHERE sales < 20 ORDER BY sales;

	-- f. All the albums with a genre of "Rock". 
    --    Why do these query results not include albums with 
    --    a genre of "Hard rock" or "Progressive rock"?
 
 SELECT name FROM albums WHERE genre = 'Rock';

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

SELECT name FROM albums WHERE genre = 'Progressive rock' OR genre = 'Hard rock';

/*
	Additional Albums are:
    
    Back in Black
    The Dark Side of the Moon
    The Wall
    Appetitite for Destruction
    */
    
SELECT name, genre FROM albums WHERE genre LIKE '%Rock%';
-- The above shows us everything with 'Rock' in genre anywhere

