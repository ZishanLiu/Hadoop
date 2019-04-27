DROP FUNCTION IF EXISTS Upper;
DROP FUNCTION IF EXISTS Strip;
CREATE FUNCTION Upper AS 'edu.rosehulman.liuz6.Upper' USING JAR 'hdfs:///tmp/input/hiveFunction.jar';
CREATE FUNCTION Strip AS 'edu.rosehulman.liuz6.Strip' USING JAR 'hdfs:///tmp/input/hiveFunction.jar';

create database ${hiveconf:databaseName};

CREATE TABLE docs (line STRING);
LOAD DATA INPATH 'text' OVERWRITE INTO TABLE docs;

CREATE TABLE word_counts AS
SELECT word, count(1) AS count FROM
(SELECT explode(split(line, '\\s')) AS word FROM docs) w
GROUP BY word
ORDER BY word;
