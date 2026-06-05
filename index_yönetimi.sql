-------------------------------------------------------
-- 4. ADIM: İNDEKS YÖNETİMİ (OPTİMİZASYON)
-------------------------------------------------------
-- Sorunu çözmek için yavaş kolona Non-Clustered Index atıyoruz.
CREATE NONCLUSTERED INDEX IX_SatisPerformans_MusteriKodu 
ON dbo.SatisPerformansTesti(MusteriKodu);
GO