CREATE DATABASE IF NOT EXISTS ${hivevar:databaseName};
USE ${hivevar:databaseName};
Create TABLE IF NOT EXISTS ${hivevar:tableName}(year int,temp int,value int) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE;
LOAD DATA INPATH '${hivevar:inputLocation}' OVERWRITE into table ${hivevar:tableName};
SELECT year, min(temp), max(temp),avg(temp) FROM ${hivevar:tableName} WHERE value=1 OR value=0 GROUP BY year;