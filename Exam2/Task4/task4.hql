use exam;

select cno from examData where grade != 'D' and count(name) >= 2;