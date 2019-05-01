CREATE DATABASE IF NOT EXISTS ${hivevar:databaseName};
USE ${hivevar:databaseName};
Create TABLE IF NOT EXISTS ${hivevar:tableName}(year int,temp int,value int) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE;
LOAD DATA INPATH '${hivevar:inputLocation}' OVERWRITE into table ${hivevar:tableName};
SELECT year, min(temp) as Mintemp, max(temp) as Maxtemp,avg(temp) as Avgtemp FROM ${hivevar:tableName} WHERE value=1 OR value=0 GROUP BY year;