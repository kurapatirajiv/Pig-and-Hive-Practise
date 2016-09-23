select b.id,b.actorid.id,a.first_name,a.last_name,a.year_of_birth from 
(select id,first_name,last_name,year_of_birth from artists) a 
JOIN
(select id,actorid from movies 
lateral view explode(actors) exploded_table as actorid where country ='USA') b
ON (a.id = b.actorid.id);