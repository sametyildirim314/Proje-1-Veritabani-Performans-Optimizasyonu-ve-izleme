USE DersDB;
GO

-------------------------------------------------------
-- DEVASA TEST TABLOSUNU OLUŞTURMA VE VERİ BASMA
-------------------------------------------------------
CREATE TABLE dbo.SatisPerformansTesti (
    SatisID INT IDENTITY(1,1) PRIMARY KEY CLUSTERED,
    MusteriKodu NVARCHAR(50),
    SatisTutari DECIMAL(18,2),
    IslemTarihi DATETIME
);
GO

-- Sistem tablolarını çaprazlayarak saniyeler içinde 1 milyon satır üretiyoruz
;WITH CTE AS (
    SELECT TOP 1000 a.object_id 
    FROM sys.all_columns a CROSS JOIN sys.all_columns b
)
INSERT INTO dbo.SatisPerformansTesti (MusteriKodu, SatisTutari, IslemTarihi)
SELECT TOP 1000000
    'CUST-' + CAST(ABS(CHECKSUM(NEWID())) % 500000 AS NVARCHAR(50)), 
    (ABS(CHECKSUM(NEWID())) % 10000) + 10.50, 
    GETDATE() - (ABS(CHECKSUM(NEWID())) % 1000) 
FROM CTE c1 CROSS JOIN CTE c2;
GO

-- Kayıt sayısını kontrol edelim
SELECT COUNT(*) AS ToplamKayitSayisi FROM dbo.SatisPerformansTesti;
GO