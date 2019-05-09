register 'hdfs:///tmp/Exams/liuz6UDF.jar';
DEFINE Concatenate edu.rosehulman.liuz6.Concatenate();
DEFINE Convert edu.rosehulman.liuz6.Convert();

grades = LOAD '$gradeInput' using PigStorage(',') AS (fName:chararray, lName:chararray, courseNum:chararray, score:double);
fgrades = FILTER grades by score<=90;
courses = LOAD '$courseInput' using PigStorage(',') AS (courseNum:chararray, courseName:chararray);
joined = JOIN fgrades by courseNum, courses by courseNum;
temp = FOREACH joined GENERATE Concatenate(fgrades::fName, fgrades::lName), courses::courseNum, courses::courseName, Convert(fgrades::score);
STORE temp into '$pigOutput/$username' using PigStorage('\t');