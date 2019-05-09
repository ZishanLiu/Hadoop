use exam;

select * from (select cno as cno, COUNT(cno) as num from examData where grade != 'D' GROUP BY cno) temp where temp.num >=2;