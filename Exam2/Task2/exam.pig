register 'hdfs:////tmp/Exams/liuz6UDF.jar';
DEFINE Concatenate edu.rosehulman.liuz6.Concatenate();
DEFINE Convert edu.rosehulman.liuz6.Convert();

gradeRecord = LOAD '$gradeInput' using PigStorage(',') AS (fName:chararray,lName:chararray,course:chararray,score:chararray);
courseRecord = LOAD '$courseInput' using PigStorage(',') AS (courseNumber:chararray,courseName:chararray);
fGrade = FILTER gradeRecord by score <= 90 and Convert(score);

result =  JOIN fGrade by course, courseRecord by courseNumber;
DUMP result;
STORE result into '$pigOutput/$username' using PigStorage('\t');