artists = LOAD '/Users/Rajiv/files/artists_en.json' USING JsonLoader('id:chararray, firstName:chararray,lastName:chararray,yearOfBirth:chararray');

movies = LOAD '/Users/Rajiv/files/movies_en.json' USING JsonLoader('id:chararray, title:chararray,year:chararray,genre:chararray,summary:chararray, country:chararray,director:tuple(id:chararray,lastName:chararray,firstName:chararray,yearOfBirth:chararray),actors:bag{(id:chararray,role:chararray)}');

movies = FOREACH movies GENERATE id, title, year, genre, country,director,actors;

usaMovies = FILTER movies by country =='USA';

q7Pass1 =  FOREACH usaMovies GENERATE *,FLATTEN(actors);
q7Pass2 = FOREACH (JOIN q7Pass1  by actors::id, artists by id) GENERATE q7Pass1::id,actors::id,actors::role,q7Pass1::title,q7Pass1::year,q7Pass1::genre,q7Pass1::country,q7Pass1::director;
q7Pass3 = GROUP q7Pass2 by q7Pass1::id;

STORE q7Pass3 into '/Users/hadoop/Query7Results';