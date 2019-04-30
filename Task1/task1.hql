create database IF NOT EXISTS ${hivevar:databaseName};

CREATE TABLE IF NOT EXISTS ${hivevar:tableName}
(
year int,
temperature float,
quality int
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE

LOAD DATA INPATH ${hivevar:inputLocation} overwrite INTO table ${hivevar:tableName};

select year, max(temperature),min(temperature),avg(temperature) from ${hivevar:tableName} where (quality = 1 or quality = 0) group by year;

