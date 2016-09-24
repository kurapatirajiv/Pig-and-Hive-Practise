--  Reference http://www.hadooptpoint.com/how-to-write-hive-udf-example-in-java/

add jar /Users/Rajiv/files/HiveFilterUDF.jar;
-- Creating a temporary function, so that we could use its alias name in the current session
CREATE TEMPORARY FUNCTION validateNames as 'myUDF.FilterUDF';

-- A boolean evaluate function did the magic
select director.last_name,director.first_name from movies 
where 
validateNames(director.last_name,director.first_name);


