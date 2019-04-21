records = LOAD '$INPUT' using PigStorage('\t') AS (year:chararray, temperature:int, quality:int);
temp = GROUP frecords by temperature;
min = FOREACH temp GENERATE group, MIN(frecords.temperature) as MinTemp;
STORE min into '$OUTPUT' using PigStorage(',');

