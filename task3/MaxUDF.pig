REGISTER 'hdfs:///tmp/input/IsGoodQuality.jar';
DEFINE checkQuality edu.rosehulman.liuz6.IsGoodQuality();
records = LOAD '$INPUT' using PigStorage('\t') AS (year:chararray, temperature:int, quality:int);
frecords = FILTER records by temperature!=9999 and checkQuality(quality);
grecords = GROUP frecords by year;
temp = FOREACH grecords GENERATE group, MAX(frecords.temperature) as MaxTemp;
STORE temp into '$OUTPUT' using PigStorage(',');
