DROP FUNCTION IF EXISTS toUpper;
DROP FUNCTION IF EXISTS toStrip;

CREATE FUNCTION toUpper AS 'edu.rosehulman.liuz6.Upper' USING JAR 'hdfs:///user/root/hiveFunction.jar';
CREATE FUNCTION toStrip AS 'edu.rosehulman.liuz6.Strip' USING JAR 'hdfs:///user/root/hiveFunction.jar';

CREATE DATABASE IF NOT EXISTS ${hivevar:databaseName};
USE ${hivevar:databaseName};
CREATE TABLE IF NOT EXISTS ${hivevar:tableName}(line string) STORED AS TEXTFILE;
LOAD DATA INPATH '${hivevar:inputLocation}' OVERWRITE INTO TABLE ${hivevar:tableName};

select explode(split((toUpper(word))) , "\\s"), count(word) from ${hivevar:tableName};

