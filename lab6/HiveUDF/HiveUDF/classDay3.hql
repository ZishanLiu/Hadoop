//User Defined Functions
DROP FUNCTION IF EXISTS lowerUDF;
DROP FUNCTION IF EXISTS lengthUDF;
CREATE FUNCTION lowerUDF AS 'edu.rosehulman.mohan.ToLower' USING JAR 'hdfs:///tmp/input/hiveFunction.jar';
CREATE FUNCTION lengthUDF AS 'edu.rosehulman.mohan.GetLength' USING JAR 'hdfs:///tmp/input/hiveFunction.jar';
Select lengthUDF(cno), lowerUDF(cno) from courses;
