--  Reference http://www.hadooptpoint.com/how-to-write-hive-udf-example-in-java/

add jar /Users/Rajiv/files/HiveFilterUDF.jar;
-- Creating a temporary function, so that we could use its alias name in the current session
CREATE TEMPORARY FUNCTION validateNames as 'myUDF.FilterUDF';

-- A boolean evaluate function did the magic
select title,director.id,director.last_name,director.first_name,director.year_of_birth 
where 
validateNames(director.last_name,director.first_name);


