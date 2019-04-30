DROP FUNCTION IF EXISTS Upper;
DROP FUNCTION IF EXISTS Strip;
CREATE FUNCTION Upper AS 'edu.rosehulman.liuz6.Upper' USING JAR 'hdfs:///tmp/input/hiveFunction.jar';
CREATE FUNCTION Strip AS 'edu.rosehulman.liuz6.Strip' USING JAR 'hdfs:///tmp/input/hiveFunction.jar';

create database ${hivevar:databaseName};

CREATE TABLE ${hivevar:tableName1} (line STRING);
LOAD DATA INPATH '${hivevar:inputLocation}' OVERWRITE INTO TABLE ${hivevar:tableName1};

CREATE TABLE ${hivevar:tableName2}(word string)
insert into table ${hivevar:tableName2} select explode(split(word , "\\s")) from ${hivevar:tableName1};
select word, count(word) from ${hivevar:tableName2} group by word;

