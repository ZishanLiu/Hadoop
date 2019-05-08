USE ${hivevar:databaseName};

LOAD DATA INPATH 'pigOutput/liuz6' INTO Table ${hivevar:tempTableName} Partition(userName = 'liuz6');

Set hive.exec.dynamic.partition.mode=nonstrict;
insert into table ${hivevar:tableName} partition(userName) select name, cno, cname, grade, userName from ${hivevar:tempTableName};

