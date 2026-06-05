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