DROP FUNCTION IF EXISTS toUpper;
DROP FUNCTION IF EXISTS toStrip;

CREATE FUNCTION toUpper AS 'edu.rosehulman.liuz6.Upper' USING JAR 'hdfs:///user/root/hiveFunction.jar';
CREATE FUNCTION toStrip AS 'edu.rosehulman.liuz6.Strip' USING JAR 'hdfs:///user/root/hiveFunction.jar';

CREATE DATABASE IF NOT EXISTS ${hivevar:databaseName};
USE ${hivevar:databaseName};
CREATE TABLE IF NOT EXISTS ${hivevar:tableName1} (line string) STORED AS TEXTFILE;
LOAD DATA INPATH '${hivevar:inputLocation}' OVERWRITE INTO TABLE ${hivevar:tableName1};

CREATE TABLE IF NOT EXISTS ${hivevar:tableName2}(word string) STORED AS TEXTFILE;
insert into table ${hivevar:tableName2} select explode(split(line , "\\s")) from ${hivevar:tableName1};
select word, count(word) from ${hivevar:tableName2} group by word;

