-- Partial Results
-- Gives a combined list of Movies in which the actor played or directed.

select * from 
(
select a.id,a.last_name,a.first_name,a.year_of_birth,b.id,b.title from artists a 
JOIN movies b
ON (a.id = b.director.id)

UNION ALL

select a.id,a.last_name,a.first_name,a.year_of_birth,b.id,b.title from 
(select id,first_name,last_name,year_of_birth from artists) a 
JOIN
(select id,actorid from movies 
lateral view explode(actors) exploded_table as actorid where country ='USA') b
ON (a.id = b.actorid.id)

) newTable;