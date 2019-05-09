use exam;

select cno as cno, COUNT(cno) as num from ${hivevar:tableName} where grade != 'D' GROUP BY cno as temp;
select * from temp where temp.num >=2;