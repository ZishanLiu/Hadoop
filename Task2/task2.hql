DROP FUNCTION IF EXISTS Upper;
DROP FUNCTION IF EXISTS Strip;
CREATE FUNCTION Upper AS 'edu.rosehulman.liuz6.Upper' USING JAR 'hdfs:///tmp/input/hiveFunction.jar';
CREATE FUNCTION Strip AS 'edu.rosehulman.liuz6.Strip' USING JAR 'hdfs:///tmp/input/hiveFunction.jar';

create database liuz6;

CREATE TABLE docs (line STRING);
LOAD DATA INPATH 'testFile.txt' OVERWRITE INTO TABLE docs;

CREATE TABLE words(word string)
insert into table words select explode(split(word , "\\s")) from docs;
select word, count(word) from words group by word;

