records = LOAD '$INPUT' using PigStorage('\t') AS (year:chararray, temperature:int, quality:int);
temp = GROUP records by temperature;
avg = FOREACH temp GENERATE group, AVG(records.temperature) as AvgTemp;
STORE avg into '$OUTPUT' using PigStorage(',');
