records = LOAD '$INPUT' using PigStorage('\t') AS (year:chararray, temperature:int, quality:int);
temp = GROUP records by temperature;
max = FOREACH temp GENERATE group, MAX(records.temperature) as MaxTemp;
STORE max into '$OUTPUT' using PigStorage(',');
