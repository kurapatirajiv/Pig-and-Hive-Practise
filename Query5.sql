select id,new_table.id as Movie_ID ,new_table.role as Movie_role from movies LATERAL VIEW explode(actors) exploded_table as new_table where country='USA';