USE DersDB;
GO

-------------------------------------------------------
-- 1. ADIM: İZLEME ROLLERİ (VERİ YÖNETİCİSİ ROLLERİ)
-------------------------------------------------------
-- PDF İsteri: "Farklı roller için erişim yönetimi"
-- Sadece performans izleyebilen, ama verileri değiştiremeyen özel bir rol oluşturuyoruz.
CREATE ROLE PerformansUzmani_Rolu;
GRANT VIEW DATABASE STATE TO PerformansUzmani_Rolu; -- DMV'leri okuma yetkisi
GRANT SHOWPLAN TO PerformansUzmani_Rolu;            -- Execution Plan görme yetkisi
GO