create database ${hiveconf:databaseName};

CREATE TABLE IF NOT EXISTS ${hiveconf:tableName}
(
year int,
temperature float,
quality int
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE

LOAD DATA INPATH ${hiveconf:inputLocation} overwrite INTO table ${hiveconf:tableName};

select year, max(temperature),min(temperature),avg(temperature) from ${hiveconf:tableName} where (quality = 1 or quality = 0) group by year;

