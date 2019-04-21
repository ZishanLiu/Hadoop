records = LOAD '$INPUT' using PigStorage('\t') AS (year:chararray, temperature:int, quality:int);
temp = GROUP frecords by temperature;
max = FOREACH temp GENERATE group, MAX(frecords.temperature) as MaxTemp;
STORE max into '$OUTPUT' using PigStorage(',');
