USE db_countries;
-- IMPORTING DATA FROM A CSV
-- select * FROM countries_of_the_world;-- 
SHOW TABLES;
DESCRIBE continents;
DESCRIBE cities;
DESCRIBE countries;
DESCRIBE attractions;
DESCRIBE countries_of_the_world;


select * from cities;
select * from attractions;
select * from cities, attractions;
select * from cities, attractions
where cities.ID_CITY= attractions.city;

SELECT * FROM countries_of_the_world;
SELECT * FROM cities;


-- Recover the name of the continen
SELECT * FROM countries;
SELECT * FROM continents;


# Cartesian product between to Tables
SELECT * FROM countries;
SELECT * FROM countries, continents;

select * 
from countries, continents 
where countries.CONTINENT = continents.id;




-- How many countries have a larger population than than at least 3 regions?
DROP     TABLE IF EXISTS new_tbl;

SELECT *                      FROM countries_of_the_world;
SELECT count(distinct Region) FROM countries_of_the_world;

CREATE TEMPORARY TABLE new_tbl 
	SELECT 	countries_of_the_world.Country, 
			countries_of_the_world.Region, 
			countries_of_the_world.Population,
			T.Region as Region_2,
			T.Population_Region
	FROM countries_of_the_world, 
    (SELECT Region, SUM(Population) as Population_Region FROM countries_of_the_world group by Region) AS T
    ORDER BY countries_of_the_world.Country;
select * from new_tbl;

select Country , sum(Population > Population_Region) as 'is_larger then N Regions' 
from new_tbl  group by Country;





-- . What are the countries with a coast to area ratio in the top 50?  
	-- . From these countries, how many of them belong to the bottom 30 countries by GDP per  capita?  
SELECT 	A.country , A.coast_area_ratio, B.GDP
FROM    
	(SELECT Country, round(Coastline/Area,3) as coast_area_ratio     FROM countries_of_the_world     ORDER BY  coast_area_ratio  DESC LIMIT 50) AS A
	INNER JOIN
	(SELECT Country ,GDP                                             FROM countries_of_the_world    ORDER BY  GDP  LIMIT 30                   ) AS B
	ON A.Country = B.Country;

SELECT 	A.country , A.coast_area_ratio, B.GDP
FROM    
	(SELECT Country, round(Coastline/Area,3) as coast_area_ratio     FROM countries_of_the_world    ORDER BY  coast_area_ratio  DESC LIMIT 50) AS A
	LEFT JOIN
	(SELECT Country ,GDP                                             FROM countries_of_the_world    ORDER BY  GDP  LIMIT 30) AS B
	ON A.Country = B.Country;


SELECT 	A.country , A.coast_area_ratio, B.GDP
FROM    
	(SELECT Country, round(Coastline/Area,3) as coast_area_ratio     FROM countries_of_the_world     ORDER BY  coast_area_ratio  DESC LIMIT 50) AS A
	RIGHT JOIN
	(SELECT Country ,GDP                                             FROM countries_of_the_world    ORDER BY  GDP  LIMIT 30) AS B
	ON A.Country = B.Country;


--  Full OUTER join
SELECT A.country , A.coast_area_ratio, B.GDP 
FROM 
		(SELECT Country, round(Coastline/Area,3) as coast_area_ratio     FROM countries_of_the_world     ORDER BY  coast_area_ratio  DESC LIMIT 50) AS A
		LEFT JOIN 
		(SELECT Country ,GDP                                             FROM countries_of_the_world    ORDER BY  GDP  LIMIT 30) AS B
		ON A.country = B.country
	UNION ALL
SELECT A.country , A.coast_area_ratio, B.GDP 
FROM
	(SELECT Country, round(Coastline/Area,3) as coast_area_ratio     FROM countries_of_the_world     ORDER BY  coast_area_ratio  DESC LIMIT 50) AS A
	RIGHT JOIN 
	(SELECT Country ,GDP                                             FROM countries_of_the_world    ORDER BY  GDP  LIMIT 30) AS B
    ON A.country = B.country;





-- How many more times populated is every country relative to the mean level by region
DROP   TABLE IF EXISTS new_tbl;
CREATE TEMPORARY TABLE new_tbl 
	SELECT 	countries_of_the_world.country,
			countries_of_the_world.Region,
			countries_of_the_world.Population, 
			B.AVG_POP_REGION, 
			countries_of_the_world.Population/B.AVG_POP_REGION as population_over_mean_region_average
	FROM 
			countries_of_the_world
			RIGHT JOIN
			(SELECT Region, ROUND(avg(Population),3) AS AVG_POP_REGION	FROM countries_of_the_world GROUP BY Region) AS B
			on countries_of_the_world.Region = B.Region
	ORDER BY Region, country;
SELECT * from new_tbl;
SELECT country, Region,ROUND(population_over_mean_region_average,3) as population_over_mean_region_average FROM new_tbl;


