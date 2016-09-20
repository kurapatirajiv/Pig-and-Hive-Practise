artists = LOAD '/Users/Rajiv/files/artists_en.json' USING JsonLoader('id:chararray, firstName:chararray,lastName:chararray,yearOfBirth:chararray');

movies = LOAD '/Users/Rajiv/files/movies_en.json' USING JsonLoader('id:chararray, title:chararray,year:chararray,genre:chararray,summary:chararray, country:chararray,director:tuple(id:chararray,lastName:chararray,firstName:chararray,yearOfBirth:chararray),actors:bag{(id:chararray,role:chararray)}');

movies = FOREACH movies GENERATE id, title, year, genre, country,director,actors;

usaMovies = FILTER movies by country =='USA';

q8Pass1 = FOREACH usaMovies GENERATE*, FLATTEN(actors);
q8Pass2 = FOREACH(JOIN artists by id, q8Pass1 by actors::id) GENERATE $0..$5,q8Pass1::actors::id,q8Pass1::actors::role;
q8Pass3 =FOREACH(JOIN artists by id, usaMovies by director.id) GENERATE $0..$5,usaMovies::director.id;
q8Pass4 = GROUP(UNION q8Pass2 , q8Pass3) BY ($0..$3);

STORE q8Pass4 into '/Users/hadoop/Query8Results';