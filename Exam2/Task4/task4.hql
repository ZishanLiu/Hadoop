use exam;

select * from (select cno as cno, COUNT(cno) as num from ${hivevar:tableName} where grade != 'D' GROUP BY cno) A where A.num >=2;