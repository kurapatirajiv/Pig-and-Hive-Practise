-- Added json-serde-1.3.6-SNAPSHOT-jar-with-dependencies.jar to .hiverc file 

DROP TABLE movies;
CREATE TABLE movies (
	id string,
	title string,
	year string,
	genre string,
	summary string,
	country string,
	actors array<struct<id:string,role:string>>,
	director struct<first_name:string,id:string,last_name:string,year_of_birth:string>
)

ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
STORED AS TEXTFILE;

LOAD DATA LOCAL INPATH '/Users/Rajiv/files/movies_en.json' INTO TABLE  movies ;

select * from movies;
