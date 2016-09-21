REGISTER /Users/Rajiv/files/MyLoadUDF.jar

artists = LOAD '/Users/Rajiv/files/NewInput.txt' USING MyPackage.MyLoadUDF() as (lines:chararray);

STORE artists into '/Users/hadoop/Query11Results';