register 'hdfs:////tmp/input/Upper.jar';
DEFINE Upper edu.rosehulman.liuz6.Upper();
lines = LOAD '$INPUT' AS (line:chararray);
words = FOREACH lines GENERATE FLATTEN(TOKENIZE(line)) as word;
grouped = GROUP words BY Upper(word);
wordcount = FOREACH grouped GENERATE group, COUNT(words);
DUMP wordcount;
STORE wordcount into '$OUTPUT' using PigStorage(',');