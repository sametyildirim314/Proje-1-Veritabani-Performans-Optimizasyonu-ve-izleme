-------------------------------------------------------
-- 5. ADIM: İYİLEŞTİRİLMİŞ SORGUNUN TEST EDİLMESİ
-------------------------------------------------------
-- (Aynı sorguyu çalıştırdığında Yürütme Planında artık maliyetsiz "Index Seek" göreceksin)
SET STATISTICS TIME ON;
SELECT SatisID, MusteriKodu, SatisTutari, IslemTarihi 
FROM dbo.SatisPerformansTesti 
WHERE MusteriKodu = 'CUST-150000';
SET STATISTICS TIME OFF;
GO