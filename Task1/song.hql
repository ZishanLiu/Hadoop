CREATE DATABASE IF NOT EXISTS ${hivevar:db};
CREATE TABLE IF NOT EXISTS ${hivevar:tb} (year STRING, temperature INT, quality INT) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE ;
LOAD DATA INPATH '${hivevar:path}' OVERWRITE INTO TABLE ${hivevar:tb}; 
SELECT year,MAX(temperature) as max, MIN(temperature) as min, AVG(temperature) as AVG FROM ${hivevar:tb} WHERE quality in (0,1) GROUP BY year;