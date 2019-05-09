register 'hdfs:///tmp/Exams/liuz6UDF.jar';
DEFINE Concatenate edu.rosehulman.liuz6.Concatenate();
DEFINE Convert edu.rosehulman.liuz6.Convert();

gradeRecord = LOAD '$gradeInput' using PigStorage(',') AS (fName:chararray,lName:chararray,course:chararray,score:int);
courseRecord = LOAD '$courseInput' using PigStorage(',') AS (courseNumber:chararray,courseName:chararray);
fGrade = FILTER gradeRecord by score <= 90;

temp =  JOIN fGrade by course, courseRecord by courseNumber;

result = FOREACH temp GENERATE Concatenate(fGrade::fName, fGrade::lName), courseRecord::courseNumber, courseRecord::courseName, Convert(fGrade::score);

DUMP result;
STORE result into '$pigOutput/$username' using PigStorage('\t');