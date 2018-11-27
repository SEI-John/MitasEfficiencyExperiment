set @qDate = '2018-07-30';

drop temporary table if exists experiment;
drop temporary table if exists summary;
create temporary table experiment
select * from (
	select * from CONTACT 
	where CON_TS between 
	date_sub(@qDate, interval 1 week) and @qDate
) as t2
where (CON_CODE = 21 and CON_FREQ = 150.720) and MITASRX_ID = 18002;

create temporary table summary
SELECT 
	t1.CON_ID,
    t1.CON_TS,
    t1.CON_POWER,
    TIMESTAMPDIFF(SECOND,
        prevCON_TS,
        CON_TS) as diff
FROM
    (SELECT 
        CON_ID,
            CON_TS,
            CON_POWER,
            @prevCON_TS AS prevCON_TS,
            @prevCON_TS:=CON_TS
    FROM
        experiment
    ORDER BY CON_ID) t1;
    
SELECT 
    *
FROM
    summary
    where diff > 5;

drop temporary table experiment;
drop temporary table summary;