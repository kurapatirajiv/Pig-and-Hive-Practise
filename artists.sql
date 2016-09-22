add jar /Users/hadoop/json-serde-1.3.6-SNAPSHOT-jar-with-dependencies.jar;

DROP TABLE artists;
CREATE TABLE artists (
	id string,
	last_name string,
	first_name string,
	year_of_birth int)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
STORED AS TEXTFILE;

LOAD DATA LOCAL INPATH '/Users/hadoop/artists_en.json' INTO TABLE  artists ;

select * from artists;
