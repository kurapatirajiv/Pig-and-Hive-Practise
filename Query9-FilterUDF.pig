REGISTER /Users/Rajiv/files/ValidateNames.jar

artists = LOAD '/Users/Rajiv/files/artists_en.json' USING JsonLoader('id:chararray, firstName:chararray,lastName:chararray,yearOfBirth:chararray');

movies = LOAD '/Users/Rajiv/files/movies_en.json' USING JsonLoader('id:chararray, title:chararray,year:chararray,genre:chararray,summary:chararray, country:chararray,director:tuple(id:chararray,lastName:chararray,firstName:chararray,yearOfBirth:chararray),actors:bag{(id:chararray,role:chararray)}');

q9Pass1 = FILTER movies by MyPackage.ValidateNames(director.firstName,director.lastName);
q9Pass2 = FOREACH q9Pass1 GENERATE title,director;

STORE q9Pass2 into '/Users/hadoop/Query9Results';