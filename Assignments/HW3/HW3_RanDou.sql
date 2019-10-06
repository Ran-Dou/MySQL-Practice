USE HW3;

select count(*) from countries_of_the_world;

SHOW tables;
DESCRIBE countries_of_the_world;

SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY','')); 

-- 1. What countries have a total GDP above the mean?
SELECT Country, GDP
FROM countries_of_the_world
HAVING GDP > (SELECT AVG(GDP) FROM countries_of_the_world);

-- 2. How many countries are above the mean on each region?
SELECT Count(country)
FROM countries_of_the_world AS t1
LEFT JOIN (SELECT Region, AVG(GDP*Population) AS AvgGDP
			FROM countries_of_the_world
			GROUP BY Region) AS t2
ON t1.Region=t2.Region
WHERE GDP*Population > AvgGDP;

-- 3. How many regions have more than 65% of their countries with a GDP per capita above 6000?
SELECT t1.Region, num_above6000/num_total AS percentage
FROM (SELECT Region, COUNT(Country) AS num_total
	FROM countries_of_the_world
	GROUP BY Region) AS t1
LEFT JOIN (SELECT Region, COUNT(Country) AS num_above6000
	FROM countries_of_the_world
    WHERE GDP>6000
	GROUP BY Region) AS t2
ON t1.Region=t2.Region
WHERE num_above6000/num_total > 0.65;

-- 4. List all the countries with a GDP that is 40% below the mean or less.
SELECT Country, GDP*Population AS TotalGDP
FROM countries_of_the_world
HAVING TotalGDP < 0.6*(SELECT AVG(GDP*Population) FROM countries_of_the_world);

-- 5. List all the countries with a GDP per capita that is between 40% and 60% the mean GDP per capita
SELECT Country, GDP
FROM countries_of_the_world
WHERE (GDP > 0.4*(SELECT AVG(GDP) FROM countries_of_the_world)
		AND GDP< 0.6*(SELECT AVG(GDP) FROM countries_of_the_world));

-- 6. Which letter is the most popular first letter among all the countries? (i.e. what is the letter that starts the largest number of countries?)
SELECT FirstLetter, COUNT(*)
FROM (SELECT SUBSTRING(Country, 1, 1) AS FirstLetter
	FROM countries_of_the_world) AS Firstletter_table
GROUP BY FirstLetter
ORDER BY COUNT(*) DESC
LIMIT 1;

-- 7. What are the countries with a coast to area ratio in the top 50?
SELECT Country
FROM countries_of_the_world
ORDER BY Coastline/Area DESC
LIMIT 50;
-- a. From these countries, how many of them belong to the bottom 30 countries by GDP per capita?
SELECT Count(*)
FROM (SELECT Country
	FROM countries_of_the_world
	ORDER BY Coastline/Area DESC
	LIMIT 50) AS t1
INNER JOIN (SELECT Country
		FROM countries_of_the_world
		ORDER BY GDP
		LIMIT 30) AS t2
ON t1.Country=t2.Country;
-- b. From these countries, how many of them belong to the top 30 countries by GDP per capita?
SELECT Count(*)
FROM (SELECT Country
	FROM countries_of_the_world
	ORDER BY Coastline/Area DESC
	LIMIT 50) AS t1
INNER JOIN (SELECT Country
		FROM countries_of_the_world
		ORDER BY GDP DESC
		LIMIT 30) AS t2
ON t1.Country=t2.Country;

-- 8.Is the average Agriculture, Industry, Service distribution of the top 20 richest countries different than the one of the lowest 20?
SELECT 'top 20' AS GDPGroup, AVG(Agriculture), AVG(Industry), AVG(Service)
FROM (SELECT * FROM countries_of_the_world
	ORDER BY (GDP*Population) DESC
    LIMIT 20) AS top20
UNION
SELECT 'bottom 20' AS GDPGroup, AVG(Agriculture), AVG(Industry), AVG(Service)
FROM (SELECT * FROM countries_of_the_world
	ORDER BY (GDP*Population)
    LIMIT 20) AS bottom20;

-- 9. How much higher is the average literacy level in the 20% percentile of the richest countries relative to the poorest 20% countries?

WITH rank_table AS (SELECT *, RANK() OVER (ORDER BY GDP*Population) AS rank_asc
					FROM countries_of_the_world)
SELECT (SELECT AVG(Literacy)
		FROM rank_table
		WHERE rank_asc > 0.8*(SELECT COUNT(*)
								FROM countries_of_the_world))-
		(SELECT AVG(Literacy)
		FROM rank_table
		WHERE rank_asc < 02*(SELECT COUNT(*)
							FROM countries_of_the_world)) AS Difference;

-- 10. From all the countries with a coast ratio at least 50% lower than the mean, which % of them stay in Africa?
SELECT (SELECT COUNT(*)
	FROM countries_of_the_world
	WHERE Coastline/Area < 0.5*(SELECT AVG(Coastline/Area)
								FROM countries_of_the_world)
			AND Region REGEXP 'AFRICA') /
		(SELECT COUNT(*)
		FROM countries_of_the_world
		WHERE Coastline/Area < 0.5*(SELECT AVG(Coastline/Area)
									FROM countries_of_the_world)) AS Percentage;
-- a. How many of them start with the letter C?
SELECT COUNT(*)
FROM countries_of_the_world
WHERE Coastline/Area < 0.5*(SELECT AVG(Coastline/Area)
							FROM countries_of_the_world)
	AND Region REGEXP 'AFRICA'
    AND Country REGEXP '^C';
