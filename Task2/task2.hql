ADD JAR 'hdfs:///user/root/hiveFunction.jar';
DROP FUNCTION IF EXISTS toUpper;
DROP FUNCTION IF EXISTS strip;

CREATE FUNCTION toUpper AS 'edu.rosehulman.liuz6.Upper' USING JAR 'hdfs:///user/root/hiveFunction.jar';
CREATE FUNCTION strip AS 'edu.rosehulman.liuz6.Strip' USING JAR 'hdfs:///user/root/hiveFunction.jar';

CREATE DATABASE IF NOT EXISTS ${hivevar:databaseName};
USE ${hivevar:databaseName};
CREATE TABLE ${hivevar:tableName1} (line string);
LOAD DATA INPATH '${hivevar:inputLocation}' OVERWRITE INTO TABLE ${hivevar:tableName1};

CREATE TABLE ${hivevar:tableName2}(word string)
insert into table ${hivevar:tableName2} select explode(split(strip(toUpper(word)) , "\\s")) from ${hivevar:tableName1};
select word, count(word) from ${hivevar:tableName2} group by word;

