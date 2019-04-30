CREATE DATABASE IF NOT EXISTS ${hivevar:databaseName};
USE ${hivevar:databaseName};
CREATE TABLE IF NOT EXISTS RoseEmployees(firstName string,lastName string,pos string,eid int) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE;

LOAD DATA INPATH '${hivevar:allEmployeesLocation}' OVERWRITE INTO TABLE RoseEmployees;

CREATE TABLE IF NOT EXISTS RoseStaticEmployees(firstName string,lastName string,pos string,eid int) Partitioned by (dept string) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE;

LOAD DATA INPATH '${hivevar:adminEmployeesLocation}' INTO Table RoseStaticEmployees Partition(dept = 'admin');
LOAD DATA INPATH '${hivevar:csseEmployeesLocation}' INTO Table RoseStaticEmployees Partition(dept = 'csse');
LOAD DATA INPATH '${hivevar:eceEmployeesLocation}' INTO Table RoseStaticEmployees Partition(dept = 'ece');

CREATE TABLE IF NOT EXISTS RoseDynamicEmployees(firstName string,lastName string,pos string,eid int) Partitioned by (dept string) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS orc;
Set hive.exec.dynamic.partition.mode=nonstrict;
insert into table RoseDynamicEmployees partition(dept) select firstName, lastName, pos, eid, dept from RoseStaticEmployees;
insert into table RoseDynamicEmployees partition(dept) select firstName, lastName, pos, eid, dept from RoseStaticEmployees;
insert into table RoseDynamicEmployees partition(dept) select firstName, lastName, pos, eid, dept from RoseStaticEmployees;

CREATE TABLE IF NOT EXISTS RoseStaticEmployeesORC(firstName string,lastName string,pos string,eid int) Partitioned by (dept string) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS orc;
insert into table RoseStaticEmployeesORC partition(dept='admin') select firstName as a, lastName as b, pos as c, eid as d from RoseEmployees where dept='admin';
insert into table RoseStaticEmployeesORC partition(dept='csse') select firstName as a, lastName as b, pos as c, eid as d from RoseEmployees where dept='csse';
insert into table RoseStaticEmployeesORC partition(dept='ece') select firstName as a, lastName as b, pos as c, eid as d from RoseEmployees where dept='ece';

select * from RoseEmployees;
select * from RoseStaticEmployees;
select * from RoseDynamicEmployees;
select * from RoseStaticEmployeesORC;

show partitions RoseEmployees;
show partitions RoseStaticEmployees;
show partitions RoseDynamicEmployees;
show partitions RoseStaticEmployeesORC;


