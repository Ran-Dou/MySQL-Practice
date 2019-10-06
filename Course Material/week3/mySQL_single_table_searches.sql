USE db_countries;
-- IMPORTING DATA FROM A CSV
-- select * FROM countries_of_the_world;-- 
SHOW TABLES;
DESCRIBE continents;
DESCRIBE cities;
DESCRIBE countries;
DESCRIBE attractions;
DESCRIBE countries_of_the_world;


-- BASIC SELECT STATEMENTS
SELECT *                   FROM countries_of_the_world;
SELECT *                   FROM countries_of_the_world ORDER BY area;
SELECT *                   FROM countries_of_the_world WHERE area<647500 ORDER BY area DESC;
SELECT *                   FROM countries_of_the_world WHERE area<647500 ORDER BY COUNTRY;
SELECT *                   FROM continents;
SELECT continents.NAME     FROM continents;
SELECT continents.NAME  , continents.SURFACE   FROM continents;
SELECT continents.NAME  AS `Name of the Country`, continents.SURFACE AS `Size in Squared Miles`  FROM continents;
SELECT continents.NAME  AS `Name of the Country`, 1.8*continents.SURFACE AS `Size in Squared Kilometers`  FROM continents;
SELECT continents.NAME  AS `Name of the Country`, ROUND(1.8*continents.SURFACE/1000,2) AS ` This is just an example Size in Squared Kilometers`  FROM continents;
SELECT SURFACE          AS `SIZE IN MILES` FROM continents;
SELECT *   FROM cities;
SELECT *                        FROM continents;
SELECT *                        FROM cities;
SELECT *                        FROM countries;
SELECT SURFACE                  FROM countries;
SELECT surface, population      FROM countries;
SELECT *                        FROM countries ;
SELECT *                        FROM countries WHERE ID_COUNTRY=10;
SELECT NAME AS `name of the country`, surface, population FROM countries WHERE ID_COUNTRY=1;
SELECT name,surface, population  FROM countries WHERE name='Spain';
SELECT name,surface, population  FROM countries WHERE name='SPAIN';
SELECT NAME ,surface, population FROM countries WHERE name='spAIN';

SELECT name,    population FROM countries WHERE population > 50e6;
SELECT name,    population FROM countries WHERE population*0.0001 > 20;
SELECT name,    population FROM countries WHERE population*1e-3 > 20;
SELECT name,    population FROM countries WHERE population BETWEEN 10 AND 60e6;
SELECT name,    population FROM countries WHERE population BETWEEN 10 AND 60e6 ORDER BY name;
SELECT name,    population FROM countries WHERE population BETWEEN 10 AND 60e6 ORDER BY name DESC;
SELECT name,    population FROM countries WHERE population BETWEEN 0 AND 200000 ORDER BY population DESC LIMIT 10;
SELECT name,    population FROM countries WHERE population BETWEEN 0 AND 70e6 ORDER BY population DESC LIMIT 1;
SELECT name,    population FROM countries WHERE population BETWEEN 0 AND 70e6 ORDER BY population DESC LIMIT 2 OFFSET 4;
SELECT name,    population FROM countries WHERE population BETWEEN 10 AND 20 ORDER BY population;
SELECT name,    population FROM countries WHERE population BETWEEN 10 AND 20 ORDER BY population DESC;
SELECT name,    population FROM countries WHERE population BETWEEN 00 AND 20000000 ORDER BY name DESC LIMIT 10;
SELECT name,    population FROM countries WHERE population BETWEEN 00 AND 2E9      ORDER BY name    LIMIT 5;
SELECT name,    population FROM countries WHERE population BETWEEN 00 AND 20000000 ORDER BY name    LIMIT 5 OFFSET 4;
SELECT name,    population FROM countries WHERE continent  IN (2,3);
SELECT name,    population FROM countries WHERE continent = 2 AND population BETWEEN 10 AND 2000000 ORDER BY population DESC LIMIT 10; # 
SELECT DISTINCT continent  FROM countries;
SELECT COUNT(*)            FROM continents;


# AGGREGATIONS
SELECT *                       FROM countries;
SELECT continent, MAX(surface) FROM countries;
SELECT continent, MAX(surface) FROM countries WHERE    continent =1;
SELECT continent, SUM(surface) FROM countries GROUP BY continent;
SELECT continent, variance(surface) FROM countries GROUP BY continent;
SELECT continent, std(surface) FROM countries GROUP BY continent;
SELECT continent,COUNT(name)   FROM countries GROUP BY continent;
SELECT SUM(Population)         FROM countries GROUP BY continent;
SELECT continent, MIN(surface) FROM countries GROUP BY continent;
SELECT continent, MAX(surface) FROM countries WHERE    continent =1;
SELECT Region ,count(Country) AS Number_of_countries FROM countries_of_the_world GROUP BY Region;


# Basic String Manipulation     
SELECT * FROM attractions WHERE name LIKE '%square%';
SELECT * FROM attractions            WHERE name LIKE '%square%';
SELECT * FROM attractions            WHERE name LIKE 'A%';
SELECT * FROM attractions            WHERE name LIKE 'B%';
SELECT * FROM attractions            WHERE name LIKE '_%';
SELECT * FROM attractions            WHERE name LIKE '______%';
SELECT * FROM attractions            WHERE name LIKE '______';
SELECT country, GDP FROM countries_of_the_world      WHERE country LIKE 'A%';
SELECT country, avg(GDP) FROM countries_of_the_world WHERE country LIKE 'A%';
SELECT country, avg(GDP) FROM countries_of_the_world WHERE country LIKE 'China%' or country LIKE 'A%'   ;

SELECT * FROM countries_of_the_world WHERE Country REGEXP '^A';
SELECT * FROM countries_of_the_world WHERE Country REGEXP 'mar';
SELECT * FROM countries_of_the_world WHERE Country REGEXP '^mar';
SELECT * FROM countries_of_the_world WHERE Country REGEXP '^A';
SELECT * FROM countries_of_the_world WHERE Country REGEXP 'China';
SELECT * FROM countries_of_the_world WHERE Country REGEXP 'Spain';
SELECT * FROM countries_of_the_world WHERE Country REGEXP '(^A)|(China)|Spain';
SELECT * FROM countries_of_the_world WHERE Country REGEXP '^Denmark';
SELECT * FROM countries_of_the_world WHERE Country REGEXP '(^Denmark)|(^A)';
SELECT * FROM countries_of_the_world WHERE Country REGEXP '(^A)';
SELECT * FROM countries_of_the_world WHERE Country REGEXP '(^[ABC])';
SELECT * FROM countries_of_the_world WHERE Country REGEXP '^(Den)';
SELECT * FROM countries_of_the_world WHERE Country REGEXP '^[Den]';


# HAVING
SELECT   Region , round(avg(Pop_Density))
FROM     countries_of_the_world 
GROUP BY Region HAVING  avg(Pop_Density)>20;


SELECT   Region , round(avg(Pop_Density)) AS 'Average Population'
FROM     countries_of_the_world 
GROUP BY Region HAVING  MAX(Pop_Density)>avg(Pop_Density);


