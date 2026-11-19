# 📊 Nädal 7 Kokkuvõte: Python Pandas

## 🎯 Ülesanne ja Eesmärk
Üleminek SQL-põhisest andmete pärimisest Pythoni andmetöötluskeskkonda. Eesmärgiks oli laadida UrbanStyle'i müügiandmed pandas DataFrame'i, läbi viia kliendikäitumise analüüs, ehitada RFM (*Recency, Frequency, Monetary*) mudel ning visualiseerida tulemused interaktiivsete Plotly Express graafikutega, et pakkuda juhtkonnale strateegilisi sisendikampaaniaid.

---
ISIKLIK TÖÖ
---
## 🛠️ Mida Tegin

- **Andmete laadimine ja uurimine:** Laadisin müügi- ja kliendiandmed (CSV) pandas'esse ning uurisin struktuuri ja tüüpe (`head()`, `info()`, `describe()`, `shape`).
- **Töötlemine ja filtreerimine:**
 - **RFM Mudeli ehitamine:** 
  1. Arvutasin viimase ostu aja (*Recency*), ostusageduse (*Frequency*) ja kogukulutuse (*Monetary*).
  2. Jagasin andmed skoori-gruppidesse `pd.qcut()` abil (kasutades loendurites `.rank(method='first')`).
  3. Määrasin reeglitega kliendisegmendid (*VIP Champions*, *Loyal Customers*, *Potential Loyalists*, *At Risk*).
- **Interaktiivne visualiseerimine:** Lõin Plotly Expressiga dünaamilisi graafikuid (`px.bar`, `px.line`, `px.scatter`, `px.pie`) segmentide jaotuse ja kuutrendide kuvamiseks.

---
 - Kasutasin Gemini AI abi koodide tõlgendamisel, puhastamisel ning tulemuste selgitamisel
 - Supabase, kontroll ja võrdlus Pythoni tulemuste vastu. 

---

## 💡 Mida Õppisin

- **SQL vs Pandas:** SQL sobib andmete kiireks pärimiseks andmebaasist, kuid pandas on oluliselt paindlikum mälupõhiseks mitmeetapiliseks analüüsiks, kohandatud funktsioonide rakendamiseks (`apply()`) ja visualiseerimiseks ühes töövoos.
- **Koodi loogika nüansid:**
  - Mitme tingimusega filtreerimisel tuleb kasutada tehetes märke `&` ja `|` ning sulgusid, mitte sõnu `and`/`or`.
  - Recency skoor käib tagurpidi (`labels=[5,4,3,2,1]`), sest väiksem päevade arv viimasest ostust tähistab paremat tulemust.
  - Sagedaste võrdsete väärtuste puhul (nt ostude arv) kaitseb `.rank(method='first')` funktsiooni `pd.qcut()` veateadete eest.

---

## 🔍 Peamised Leiud (UrbanStyle)

- **Tallinn domineerib müügimahult:** Enamik tellimusi (5 704 rida, ~1,63M €) pärineb Tallinna kauplusest, samal ajal kui Tartu näitab kõrgeimat keskmist ostukorvi (~289 €).
- **Käibe jaotus toodetena:** Suurima käibemahu annavad jalanõude ja meeste riiete kategooriad.
- **RFM Kliendisegmendid:**
  - **VIP Champions (466 klient):** Genereerivad valdava osa (kuni 60–70%) ettevõtte kogutulust.
  - **At Risk segment:** Vajab kohest tagasivõitmise kampaaniat (personaalsed soodustused), et vältida klientide lahkumist enne nende lõplikku kaotamist.
  - Osad koodid vajasid muutmist, sest juhendis oli puudusi.
---
GRUPITÖÖ
---
## Meeskond TOODE

**Liikmed:** Ivo, Kertu ja Helen

## Meeskonna töö
- [Vaata selle nädala meeskonnatöö esitlust siit](https://docs.google.com/presentation/d/1uZ4M79CZbJbHnxTO83OWkw0dK4sQwf2zO5v7F9jSuVU/edit?slide=id.p#slide=id.p)

## Rollijaotus

| **Liige** | **Roll** | **Vastutus** |
| :--- | :--- | :--- |
| Ivo | A+B – API Query + Data Processing | Andmete pärimine Supabase API-st (`data_fetcher.py`) ja andmete töötlemine (`transform.py`) |
| Kertu | C – Visualization + Saving | Andmete visualiseerimine ja eksportimine (`visualize_export.py`) |
| Helen | D – Automation Script | Kogu pipeline'i automatiseerimine ja orkestreerimine (`pipeline.py`) |

---

## Nädala eesmärk
Pythoni automatiseerimine. Minu selle nädala eesmärgiks olid rollid **A** ja **B**:
* Luua Pythoni funktsioonid, mis pärivad UrbanStyle.ltd andmed Supabase API-st (müügi-, kliendi- ja tooteandmed).
* Kirjutada transformeerimisfunktsioonid: puhastada andmed, arvutada nädalased koondnäitajad ja KPI-d ning liita andmestikud.

**Sisend:** Supabase Python client (`supabase-py`), `.env` fail API tunnustega ning DataFrame'id (müügi-, kliendi-, tooteandmed).  
**Väljund:** `data_fetcher.py` (3 funktsiooni, mis tagastavad DataFrame'e) ja `transform.py` (4 funktsiooni andmete töötlemiseks). Loodud ja testitud: Supabase API-st laetud andmed on edukalt pagineeritud, puhastatud (8,950 rida) ning seadistatud tiimi ühise pipeline'i integreerimiseks.

---

## Roll A: API Query (`data_fetcher.py`)

**Tehtud töö (Baas + Edasijõudnute tase):**
- **Turvaline ühendus:** API võtmed (`SUPABASE_URL`, `SUPABASE_KEY`) laetakse `.env` failist `python-dotenv` abil.
- **Andmepärimise funktsioonid:** Loodud `fetch_sales(start_date, end_date)` (koos kuupäevafiltritega), `fetch_customers()` ja `fetch_products()`.
- **Pagination (üle 1000 rea piirangu):** Lisatud vahemikupõhine (`.range()`) tsükkel, mis laeb andmed 1000-realiste lehtede kaupa, et kätte saada kogu andmebaasi sisu.
- **Veakäsitlus ja töökindlus:** Kõik päringud on ümbritsetud `try/except` blokkidega ning varustatud *exponential backoff* korduskatsete loogikaga (ootab 2, 4, 8 sek) võrgutõrgete korral.

**Peamised leiud (Toorandmete maht):**
- **Müügiandmed (`sales`):** 10 118 rida, 12 veergu (baaspäring tagastas vaikimisi vaid 1000 rida).
- **Kliendiandmed (`customers`):** 3 150 rida, 9 veergu.
- **Tooteandmed (`products`):** 362 rida, 9 veergu.
- *Märkus Roll B-le:* Andmed on toorkujul (sisaldavad veel duplikaate ja NULL-väärtusi), puhastamine ja filtreerimine toimub järgmises etapis (`transform.py`).

---

## Roll B: Data Processing (`transform.py`)

**Tehtud töö ja funktsioonid:**
1. **`clean_data_advanced(df)` (Edasijõudnute tase):**
   * Eemaldab duplikaadid (lähtudes `invoice_id`-st).
   * Eemaldab puuduvate väärtustega (NULL) read kriitilistest veergudest (`customer_id`, `sale_date`, `total_price`).
   * Valideerib andmetüübid ja väärtuste vahemikud (eemaldab negatiivsed ja ebamõistlikud hinnad).
   * Teisendab kuupäevad õigesse `datetime` formaati.
   * Sisaldab sisseehitatud logimist (`logging`), mis raporteerib igat transformatsiooni sammu.
2. **`merge_datasets(df_sales, df_customers)`:**
   * Liidab müügi- ja kliendiandmed omavahel `customer_id` alusel (`left join`), säilitades kõik tehingud.
3. **`calculate_weekly_aggregates(df)`:**
   * Grupeerib andmed nädalate kaupa (`resample('W')`) ning arvutab välja nädalase kogutulu, tellimuste arvu ja keskmise tellimuse väärtuse.
4. **`calculate_kpis(df)`:**
   * Tagastab sõnastiku peamiste äri-KPI-dega: kogutulu, unikaalsete klientide arv ja keskmine tellimuse väärtus.

**Peamised tulemused ja KPI-d:**
- **Algne ridade arv:** 10 118 rida
- **Puhastatud ridade arv (lõplik shape):** 8 950 rida
- **Kogutulu (Total Revenue):** 270 620,89 € (1000-realises baasvalimis)
- **Unikaalsed kliendid (Unique Customers):** 661 (baasvalimis) / 2 540 (kogu puhastatud andmestikus)
- **Keskmine tellimuse väärtus (Average Order Value):** 298,37 €

*Tulemusi sai võrreldud ka eelmise nädala failidega ja need klappisid täielikult.*

---

## Kuidas AI mind aitas
> AI aitas struktureerida Pandas `method chaining` ja `resample` loogikat ning optimeerida andmevalideerimise ja logimise (*logging*) funktsioone, et tagada koodi tootmisvalmidus (*production-grade*).


