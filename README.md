# Proje 1: Veritabanı Performans Optimizasyonu ve İzleme

Bu proje, **Ağ Tabanlı Paralel Dağıtım Sistemleri** dersi kapsamında, büyük ölçekli veritabanlarında performans darboğazlarını (bottleneck) tespit etmek ve optimize etmek amacıyla geliştirilmiştir. Çalışmada körleme tahminler yerine **Dynamic Management Views (DMV)** ve **Execution Plan** analizleri kullanılarak tamamen veriye dayalı bir mühendislik yaklaşımı sergilenmiştir.

🎥 **[Proje Sunum ve Uygulama Videosunu İzlemek İçin Tıklayın](https://youtu.be/LxYC3TQmDdQ)**

## 🎯 Proje Hedefleri
- **En Az Yetki Prensibi (Least Privilege):** İzleme işlemleri için özel roller tanımlamak.
- **Yük Testi Simülasyonu:** Veritabanına 1.000.000 (Bir Milyon) satırlık sentetik veri basarak performans sınırlarını test etmek.
- **Sistem İzleme:** DMV (Dinamik Yönetim Görünümleri) araçlarıyla işlemciyi (CPU) en çok yoran sorguları tespit etmek.
- **Sorgu İyileştirme:** "Table Scan" (Tüm tabloyu tarama) sorununun, doğru indeksleme stratejileriyle "Index Seek" (Doğrudan indekse gitme) işlemine dönüştürülmesi.

## 📂 Proje Yapısı

```text
├── Rapor/
│   └── Proje_Raporu.md                   # Tespit edilen sorunların ve çözümlerin detaylı analizi
├── SQL_Scriptleri/
│   ├── 01_Test_Verisi_Olusturma.sql      # 1 Milyon satırlık test tablosunu üreten script
│   ├── 02_Performans_ve_Optimizasyon.sql # Rol atama, DMV analizi ve Index oluşturma scripti
├── Ekran_Goruntuleri/                    # Execution Plan maliyetlerindeki değişimin kanıtları
└── README.md                             # Kurulum ve bilgilendirme