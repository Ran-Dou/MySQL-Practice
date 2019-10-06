use db_countries;

select * from countries_of_the_world;


select avg(GDP) from countries_of_the_world;


select * 
from countries_of_the_world
where countries_of_the_world.GDP > 9128.8770;


select * 
from countries_of_the_world
where GDP > 9128.8770;


select avg(GDP) from countries_of_the_world;

select Country, Region , GDP 
from countries_of_the_world
where countries_of_the_world.GDP >
		(select avg(GDP) from countries_of_the_world)
order by countries_of_the_world.GDP;


--  What is the richest country that has a gdp  per capita that is below 0.5  times the mean gdp per capita  of the world
select * from countries_of_the_world where GDP > 9128.8770;


select *  from countries_of_the_world;

select *  from countries_of_the_world where GDP < 333000;

select avg(GDP) from countries_of_the_world;


select 0.5*avg(GDP) from countries_of_the_world;



select *  
from countries_of_the_world
where GDP < 
		(select 0.5*avg(GDP)
        from countries_of_the_world)
ORDER BY GDP DESC;



DROP  TABLE IF EXISTS new_tbl;
SELECT * from countries_of_the_world;

	SELECT Country, 
		   Agriculture,
           Industry,
           Service,
           RANK() OVER (ORDER BY GDP) rank_increasing,
           RANK() OVER (ORDER BY GDP DESC) rank_decreasing
	FROM countries_of_the_world;


CREATE TEMPORARY TABLE new_tbl
	SELECT Country, 
		   Agriculture,
           Industry,
           Service,
           RANK() OVER (ORDER BY GDP) rank_increasing,
           RANK() OVER (ORDER BY GDP DESC) rank_decreasing
	FROM countries_of_the_world;
    
SELECT * from new_tbl;


SELECT *, 
	1*(rank_increasing<40)                         +
	2*(rank_increasing>39 and rank_increasing<80)  +
	3*(rank_increasing>79 and rank_increasing<120) +
	4*(rank_increasing>119) 
	AS rank_group 
from new_tbl;



SELECT rank_group,
       round(avg(Agriculture),3) as 'mean_agriculture',
       round(avg(Industry),3)    as 'mean_Industry' ,
       round(avg(Service),3)     as 'mean_Service' 
from(
SELECT *, 
	1*(rank_increasing<40)                         +
	2*(rank_increasing>39 and rank_increasing<80)  +
	3*(rank_increasing>79 and rank_increasing<120) +
	4*(rank_increasing>119) 
	AS rank_group 
from new_tbl) as t1
group by t1.rank_group order by rank_group;

# what is the poorest country that has a GDP per capita above the mean

USE db_countries;

SELECT * FROM countries_of_the_world;


SELECT avg(GDP) FROM countries_of_the_world;

SELECT country, GDP 
FROM countries_of_the_world
WHERE GDP>7777
;


SELECT country, GDP 
FROM countries_of_the_world
WHERE GDP>(
SELECT avg(GDP) FROM countries_of_the_world
)
ORDER BY GDP
;






# find what is the richest country that has 
# i) GDP below the avg/2


select * from countries_of_the_world;

select 0.5*avg(GDP)from countries_of_the_world;

select country, GDP
from countries_of_the_world
where GDP < 1000;


select country, GDP
from countries_of_the_world
where GDP < (select 0.5*avg(GDP)from countries_of_the_world)
ORDER BY GDP DESC;

USE db_countries;

select 0.5*avg(GDP)from countries_of_the_world;





DROP  TABLE IF EXISTS new_tbl;
CREATE TEMPORARY TABLE new_tbl
	SELECT Country, 
		   Agriculture,
           Industry,
           Service,
           RANK() OVER (ORDER BY GDP) rank_increasing,
           RANK() OVER (ORDER BY GDP DESC) rank_decreasing
	FROM countries_of_the_world;
    
    SELECT * FROM new_tbl;
    
    
    SELECT *, 
	1*(rank_increasing<40)                         +
	2*(rank_increasing>39 and rank_increasing<80)  +
	3*(rank_increasing>79 and rank_increasing<120) +
	4*(rank_increasing>119) 
	AS rank_group 
from new_tbl;




