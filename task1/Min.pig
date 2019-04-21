records = LOAD '$INPUT' using PigStorage('\t') AS (year:chararray, temperature:int, quality:int);
temp = GROUP records by temperature;
min = FOREACH temp GENERATE group, MIN(records.temperature) as MinTemp;
STORE min into '$OUTPUT' using PigStorage(',');

