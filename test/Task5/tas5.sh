sqoop export --connect jdbc:mysql://$1/sqooptest --username hive -m 1 --table examData --export-dir /tmp/sqoop/exam/username=liuz6 --input-fields-terminated-by '\t' --input-null-string 'NULL String' --input-null-non-string '\\N' -P