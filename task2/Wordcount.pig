register 'hdfs:///tmp/input/WordCount.jar';
DEFINE Upper edu.rosehulman.liuz6.Upper();
lines = LOAD '$INPUT' AS (line:chararray);
words = FOREACH lines GENERATE FLATTEN(TOKENIZE(line)) as word;
grouped = GROUP words BY Upper(word);
wordcount = FOREACH grouped GENERATE group, COUNT(words);
DUMP wordcount;
STORE min into '$OUTPUT' using PigStorage(',');