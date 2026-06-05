# DETAYLI PROJE RAPORU: Veritabanı Performans Optimizasyonu ve İzleme

**Ders:** Ağ Tabanlı Paralel Dağıtım Sistemleri  
**Proje No:** 1  
**Veritabanı Ortamı:** Microsoft SQL Server (SSMS)  

---

## 1. Projenin Amacı ve Kapsamı
[cite_start]Bu çalışmanın temel amacı, büyük ölçekli ve yüksek veri yoğunluğuna sahip veritabanlarında meydana gelebilecek performans darboğazlarını (bottleneck) proaktif yöntemlerle tespit etmek ve gidermektir[cite: 24, 25]. [cite_start]Proje kapsamında; sorgu optimizasyonu, indeks yönetimi, veritabanı izleme araçlarının kullanımı (DMV) ve farklı veri yöneticisi rolleri için erişim yönetim planlaması yapılmıştır[cite: 26, 29, 30, 31, 32].

## 2. Test Ortamının Hazırlanması (Yük Simülasyonu)
Performans analizinin gerçekçi sonuçlar verebilmesi için sistemde `SatisPerformansTesti` adında bir tablo oluşturulmuş ve içerisine çapraz birleştirme (Cross Join) yöntemiyle **1.000.000 (Bir Milyon)** adet sentetik satış ve müşteri verisi eklenmiştir. Bu devasa veri havuzu, optimizasyon öncesi ve sonrası oluşan maliyet farklarını gözlemlemek için temel (baseline) oluşturmuştur.

## 3. Uygulanan Optimizasyon ve İzleme Adımları

### Adım 1: Veri Yöneticisi Rolleri ve Erişim Yönetimi
[cite_start]Sistem performansını izleme işlemleri, veritabanı güvenliği (Least Privilege - En Az Yetki Prensibi) göz önüne alınarak yapılandırılmıştır[cite: 32].
* **Yapılan İşlem:** Sisteme `PerformansUzmani_Rolu` adında yeni bir yetki grubu tanımlanmıştır.
* **Detay:** Bu role `INSERT`, `UPDATE` veya `DELETE` gibi veri manipülasyon yetkileri verilmemiş; yalnızca sistemin sağlığını denetleyebilmesi için `VIEW DATABASE STATE` (DMV okuma) ve `SHOWPLAN` (Yürütme Planı görme) yetkileri tanımlanmıştır.

### Adım 2: Darboğazın (Bottleneck) Tespiti ve Yürütme Planı Analizi
Sistemde belirli bir müşteri koduna (`CUST-150000`) ait satışları getiren bir `SELECT` sorgusu çalıştırılmıştır.
* [cite_start]**Bulgular:** `STATISTICS TIME ON` komutu ve "Gerçek Yürütme Planı (Actual Execution Plan)" kullanılarak yapılan analizde, sorgunun veriyi bulabilmek için 1 milyon satırın tamamını baştan aşağı okuduğu görülmüştür[cite: 29].
* **Sorun:** Bu işleme **Table Scan (Tablo Tarama)** adı verilmektedir. İşlemin disk okuma maliyeti %100 olarak ölçülmüş ve veritabanı motorunu gereksiz yere meşgul ettiği tespit edilmiştir.

### Adım 3: Dynamic Management Views (DMV) ile Sistemin İzlenmesi
[cite_start]Anlık sorgular dışında, sistemin arka planında çalışan ve işlemciyi (CPU) en çok yoran gizli sorguları tespit etmek için SQL Server'ın Dinamik Yönetim Görünümleri kullanılmıştır[cite: 29].
* **Yapılan İşlem:** `sys.dm_exec_query_stats` ve `sys.dm_exec_sql_text` sistem tablolarına çapraz sorgu (CROSS APPLY) atılmıştır.
* [cite_start]**Sonuç:** Bu analiz sonucunda, sistem hafızasında (plan cache) en çok CPU zamanı tüketen (`total_worker_time`) sorunlu sorgular tespit edilip listelenmiş ve hedefe yönelik iyileştirme kararı alınmıştır[cite: 31].

### Adım 4: İndeks Yönetimi (Index Management)
[cite_start]DMV ve Yürütme Planı analizlerinden elde edilen veriler ışığında, okuma maliyetlerini düşürmek için yapısal bir değişikliğe gidilmiştir[cite: 30].
* **Yapılan İşlem:** Arama filtrelerinde (`WHERE` koşulunda) sıkça kullanılan `MusteriKodu` kolonu üzerine `IX_SatisPerformans_MusteriKodu` adında bir **Non-Clustered Index (Kümelenmemiş Dizin)** oluşturulmuştur.

### Adım 5: İyileştirilmiş Sorgunun Testi ve Kanıtlanması
[cite_start]İndeksleme işlemi tamamlandıktan sonra, Adım 2'deki sorunlu sorgu tekrar çalıştırılmış ve Yürütme Planı yeniden incelenmiştir[cite: 31].
* **Sonuç:** SQL Server'ın artık tüm tabloyu okumadığı, oluşturulan dizin ağacını kullanarak veriye doğrudan eriştiği görülmüştür.
* **Kazanım:** İşlem türü "Table Scan"den, **"Index Seek" (Dizin Arama)** türüne dönüşmüş, CPU ve disk okuma maliyetleri %99 oranında düşürülerek sorgu süresi milisaniyeler seviyesine indirilmiştir.

---

## 4. Sonuç
Bu projeyle, kurumsal çaplı bir veritabanında oluşabilecek performans sorunlarının körleme yöntemlerle değil; [cite_start]DMV araçları ve Yürütme Planı okumalarıyla (analitik olarak) nasıl tespit edileceği uygulamalı olarak gösterilmiştir[cite: 29]. [cite_start]Gerçekleştirilen indeksleme işlemiyle sistem kaynakları optimize edilmiş ve bu süreç profesyonel rol bazlı erişim standartlarına oturtulmuştur[cite: 30, 32].