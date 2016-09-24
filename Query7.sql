-- Partial result 
-- Group by function in conduction with count, does not depict individual detailed records 


select b.id, count(DISTINCT b.title,b.year,b.genre,b.country,b.director,a.first_name,a.last_name,a.year_of_birth) from 
(select id,first_name,last_name,year_of_birth from artists) a 
JOIN
(select id,title,year,genre,country,director,actorid from movies 
lateral view explode(actors) exploded_table as actorid where country ='USA') b
ON (a.id = b.actorid.id)
GROUP BY b.id;