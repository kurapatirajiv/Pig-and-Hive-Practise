artists = LOAD '/Users/Rajiv/files/artists_en.json' USING JsonLoader('id:chararray, firstName:chararray,lastName:chararray,yearOfBirth:chararray');

movies = LOAD '/Users/Rajiv/files/movies_en.json' USING JsonLoader('id:chararray, title:chararray,year:chararray,genre:chararray,summary:chararray, country:chararray,director:tuple(id:chararray,lastName:chararray,firstName:chararray,yearOfBirth:chararray),actors:bag{(id:chararray,role:chararray)}');

movies = FOREACH movies GENERATE id, title, year, genre, country,director,actors;

usaMovies = FILTER movies by country =='USA';

q4Pass1 = FOREACH usaMovies GENERATE director,title;
q4Pass2 = FOREACH(GROUP q4Pass1 BY director) GENERATE group,q4Pass1.title;

STORE q4Pass2 into '/Users/hadoop/Query4Results';