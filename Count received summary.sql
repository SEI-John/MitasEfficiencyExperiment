set @qDate = '2018-07-30';
SELECT 
    *
FROM
    (SELECT 
        MITASRX_ID,
            CON_FREQ,
            CON_CODE,
            AVG(CON_POWER) AS avg_pwr,
            STDDEV(CON_POWER) AS avg_pwr_dev,
            COUNT(*) AS count
    FROM
        CONTACT
    WHERE
        CON_TS BETWEEN DATE_SUB(@qDate, INTERVAL 14 DAY) AND @qDate
            AND CON_POWER > - 110
    GROUP BY MITASRX_ID , CON_FREQ , CON_CODE) AS t1
WHERE
    (CON_CODE = 20 AND CON_FREQ = 150.500)
        OR (CON_CODE = 21 AND CON_FREQ = 150.720);