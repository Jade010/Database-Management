-- This is a project I created while working on my Break Into Tech Data Analyst Certificate using SQLite.
-- I created a database called Games where I made a single table and populated it. Once this table was populated I queried the table to answer some questions about the data.

-- Creating Database
CREATE DATABASE Games;

-- Creating a table
CREATE TABLE game_store (id INTEGER PRIMARY KEY, game_name TEXT, rating INTEGER, condition Text, price INTEGER);

-- Populating the table
INSERT INTO game_store VALUES (1, "LoZ: Ocarina of Time", 5, "Pre-Owned", 38);
INSERT INTO game_store VALUES (2, "LoZ: Majora's Mask", 5, "Digital", 50);
INSERT INTO game_store VALUES (3, "LoZ: Twilight Princess", 4.5, "Pre-Owned", 58);
INSERT INTO game_store VALUES (4, "LoZ: Triforce Heroes", 3.5, "Pre-Owned", 27);
INSERT INTO game_store VALUES (5, "Pokemon Diamond", 4.5, "Pre-Owned", 30);
INSERT INTO game_store VALUES (6, "Pokemon Sword", 3, "New", 38);
INSERT INTO game_store VALUES (7, "Pokemon HeartGold", 4.5, "Pre-Owned", 40);
INSERT INTO game_store VALUES (8, "Pokemon Black 2", 5, "Pre-Owned", 70);
INSERT INTO game_store VALUES (9, "Pokemon Violet", 2, "Digital", 60);
INSERT INTO game_store VALUES (10, "Super Mario 64", 4, "Digital", 25);
INSERT INTO game_store VALUES (11, "Pokemon Y", 5, "New", 43);
INSERT INTO game_store VALUES (12, "Pokemon Mystery Dungeon: Explorers of Time", 4, "Pre-Owned", 26);
INSERT INTO game_store VALUES (13, "LoZ: Skyward Sword", 5, "New", 60);
INSERT INTO game_store VALUES (14, "LoZ: Spirit Tracks", 3, "Pre-Owned", 20);
INSERT INTO game_store VALUES (15, "LoZ: Breath of the Wild", 4.5, "Digital", 64);

-- Querying the table

-- Q1. displays the database ordered by price
SELECT * FROM game_store 
ORDER BY price desc;

-- Q2. what is the avg price of items that are Digital?
SELECT AVG(price) "avg digital price"
FROM game_store 
WHERE condition = 'Digital';

-- Q3. what are the highest rated games and their price?
SELECT game_name, price
FROM game_store 
WHERE rating = 5 
ORDER BY price desc;
