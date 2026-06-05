
-------------------------------------------------------
-- 2. ADIM: SORGU İYİLEŞTİRME VE İZLEME (YAVAŞ SORGU)
-------------------------------------------------------
-- (Bunu çalıştırdığında Yürütme Planında %100 maliyetli "Table Scan" göreceksin)
SET STATISTICS TIME ON; 
SELECT SatisID, MusteriKodu, SatisTutari, IslemTarihi 
FROM dbo.SatisPerformansTesti 
WHERE MusteriKodu = 'CUST-150000';
SET STATISTICS TIME OFF;
GO

SELECT TOP 5 
    t.text AS 'Sorunlu_Sorgu',
    s.total_worker_time AS 'Toplam_CPU_Zamani',
    s.execution_count AS 'Calistirilma_Sayisi',
    s.last_execution_time AS 'Son_Calistirilma'
FROM sys.dm_exec_query_stats s
CROSS APPLY sys.dm_exec_sql_text(s.sql_handle) t
WHERE t.text LIKE '%SatisPerformansTesti%' AND t.text NOT LIKE '%dm_exec_query_stats%'
ORDER BY s.total_worker_time DESC;
GO