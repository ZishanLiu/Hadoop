use exam;

select cno as cno, COUNT(cno) as num from ${hiveconf:tableName} where grade != 'D' GROUP BY cno as temp;
select * from temp where temp.num >=2;