CREATE DATABASE IF NOT EXISTS ${hivevar:databaseName}
USE ${hivevar:databaseName}
CREATE TABLE RoseEmployees(firstName string,lastName string,pos string,eid int)

LOAD DATA INPATH '${hivevar:allEmployeesLocation}' OVERWRITE INTO TABLE RoseEmployees ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE

CREATE TABLE IF NOT EXISTS RoseStaticEmployees (firstName string,lastName string,pos string,eid int) Partitioned by (dept string) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS TEXTFILE

LOAD DATA INPATH '${hivevar:adminEmployeesLocation}' INTO Table RoseStaticEmployees Partition(dept = 'admin')
LOAD DATA INPATH '${hivevar:csseEmployeesLocation}' INTO Table RoseStaticEmployees Partition(dept = 'csse')
LOAD DATA INPATH '${hivevar:eceEmployeesLocation}' INTO Table RoseStaticEmployees Partition(dept = 'ece')

CREATE TABLE IF NOT EXISTS RoseDynamicEmployees (firstName string,lastName string,pos string,eid int) Partitioned by (dept string) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS orc
insert into table RoseDynamicEmployees partition(dept='admin') select firstName, lastName, pos, eid from RoseStaticEmployees where dept='admin'
insert into table RoseDynamicEmployees partition(dept='csse') select firstName, lastName, pos, eid from RoseStaticEmployees where dept='csse'
insert into table RoseDynamicEmployees partition(dept='ece') select firstName, lastName, pos, eid from RoseStaticEmployees where dept='ece'

CREATE TABLE IF NOT EXISTS RoseStaticEmployeesORC (firstName string,lastName string,pos string,eid int) Partitioned by (dept string) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS orc
insert into table RoseStaticEmployeesORC partition(dept='admin') select firstName, lastName, pos, eid from RoseEmployees where dept='admin'
insert into table RoseStaticEmployeesORC partition(dept='csse') select firstName, lastName, pos, eid from RoseEmployees where dept='csse'
insert into table RoseStaticEmployeesORC partition(dept='ece') select firstName, lastName, pos, eid from RoseEmployees where dept='ece'

select * from RoseEmployees
select * from RoseStaticEmployees
select * from RoseDynamicEmployees
select * from RoseStaticEmployeesORC

show partitions RoseEmployees
show partitions RoseStaticEmployees
show partitions RoseDynamicEmployees
show partitions RoseStaticEmployeesORC


