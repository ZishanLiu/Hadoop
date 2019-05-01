CREATE DATABASE IF NOT EXISTS ${hivevar:databaseName};
USE ${hivevar:databaseName};

CREATE TABLE IF NOT EXISTS RoseDynamicEmployeesManualAdd(firstName string,lastName string,pos string,eid int) Partitioned by (dept string) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS orc;
alter table RoseDynamicEmployeesManualAdd Partition(dept = 'admin');
alter table RoseDynamicEmployeesManualAdd Partition(dept = 'csse');
alter table RoseDynamicEmployeesManualAdd Partition(dept = 'ece');
msck repair table RoseDynamicEmployeesManualAdd