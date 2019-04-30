DROP FUNCTION IF EXISTS toUpper;
DROP FUNCTION IF EXISTS toStrip;

CREATE FUNCTION toUpper AS 'edu.rosehulman.liuz6.Upper' USING JAR 'hdfs:///user/root/hiveFunction.jar';
CREATE FUNCTION toStrip AS 'edu.rosehulman.liuz6.Strip' USING JAR 'hdfs:///user/root/hiveFunction.jar';

CREATE DATABASE IF NOT EXISTS ${hivevar:databaseName};
USE ${hivevar:databaseName};
CREATE TABLE IF NOT EXISTS ${hivevar:tableName}(word string) STORED AS TEXTFILE;
insert overwrite table ${hivevar:tableName} select explode(split(line,'\s')) word from '${hivevar:inputLocation}';

SELECT word,count(1) FROM ${hivevar:tableName} GROUP BY word ORDER BY word;

