-- This is how we make comments in SQL

-- I want to see the sections in the library
-- The sections are what we may describe as schema, or databasws.alter

SHOW DATABASES; -- the semicolon is needed to tell SQL to execute the line of code

-- Now I can see the names of the different schema

-- Select everything 
-- FROM the database schema of mysql
-- From the table of user
SELECT * FROM mysql.user;

-- How do I fet into that section? 
-- in CLI we would change directories into our location (cd) we would list contents (ls)
-- We will replicate this process by saying USE a specific schema, and SHOW the contents

USE mysql;

SHOW TABLES;
--  show me all the field in the ravle called user
SELECT * FROM user;

-- SQL Injection: is invading their SQL queries that can then do malicious things and damage a backend

-- ust the fruits-db schema
USE fruits_db;

-- now we can learn about this db
-- i got lost in the library, where am i?

SELECT database();

-- I want to know details about the creation of fruits_db 
-- SHOW command
-- The dtails of the CREATE command
-- for the DATABASE of fruits_db
SHOW CREATE DATABASE fruits_db;

-- USE farmers_market;
-- SHOW TABLES;

-- It seems like it's still using farmers_market instead of employees

USE employees;
SHOW TABLES;


-- TABLES
-- SQL Table structures:
-- 1. Data Types
-- 1a. Null types
-- 2. Primary Keys
-- 3. Table inspections

SHOW DATABASES;

USE chipotle;

SHOW TABLES;

-- Structure of a MySQL Database:
-- Inside of the Database exists schema (databases)
-- These databases provide a structure for tables

-- Tables:
SELECT * FROM orders LIMIT 5;

-- So. what's in a Table?
-- Each cell of data in a table is exactly that: data
-- Each piece of datumhas an inherent type
-- that type defines how it can interact, and if it can belong in that field
-- interchangable terms in sql: colums and fields

-- Tables in sql have some very specific rules about how they are created:
-- Firstly, they must contain a primary key
-- 
-- A null in sql will display as no values — it's not a zero, because zero would be data

-- part of the data cleaning is that 'nan' in SQL isn't null, but it is in Python — Python uses both null and nan to be null

-- Primary keys have to be unique , can't be null, and there can be only one

SHOW CREATE TABLE orders;
-- int unsigned NOT NULLAUTO_INCREMENT usually will be the primary key
-- 
-- Everything we will be dealing with will come down to truth or not
-- TINYINT is a 0 or a 1
-- CHAR(x) any number 1 - 255, it's a fixed number so that any entry with fewer characters will be padded with zeros
-- VARCHAR(xx) any number of characters up to 65,535
-- TEXT
DESCRIBE orders;




