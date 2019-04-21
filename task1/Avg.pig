records = LOAD '$INPUT' using PigStorage('\t') AS (year:chararray, temperature:int, quality:int);
temp = GROUP frecords by temperature;
avg = FOREACH temp GENERATE group, AVG(frecords.temperature) as AvgTemp;
STORE avg into '$OUTPUT' using PigStorage(',');
