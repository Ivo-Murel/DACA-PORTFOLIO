# 5. nädal | UrbanStyle – Power BI visualiseerimine

### 📌 Projekti ülevaade
Viiendal nädalal keskendusime SQL-iga analüüsitud andmete visuaalsele esitamisele Power BI Desktop keskkonnas. Koostasime interaktiivsed juhtimislauad (*dashboards*) UrbanStyle meeskonna erinevatele osapooltele (CEO, turundus, operatsioonid).

---

### 1. Minu ülesanne – Roll A: CEO Dashboard (Kõrgtaseme müügitrendid)

* **Domeen ja eesmärk:**  
  Analüüsida ettevõtte käekäiku kõrgtasemel, et juhtkond näeks ühe pilguga, kas UrbanStyle kasvab või kahaneb.

* **Peamised leiud ja järeldused:**  
  * **Müügi kukkumine:** 2024. aasta oli parim müügiaasta (1,47M €), kuid 2025. aastal langes käive 200k € peale (märts-november müüki ei toimunud). 2026. aastal oli käive vaid ~4000 € (-99,7% vs 2024). Ettevõtte tegevus on sisuliselt seiskunud.
  * **Soovitus juhtkonnale:** Planeerida turunduskampaaniad ja tegevuse taaskäivitamine teadaolevatele kõrghooaja perioodidele (Q2 ja Q4).

---
## 👥 Meeskond TOODE ja tööjaotus

| Liige | Roll | Valdkond | Töövahendid |
| :--- | :--- | :--- | :--- |
| **Ivo** | Roll A – CEO Dashboard | Kõrgtaseme KPI-d, müügitulu ja kasvu trendid | Power BI, SQL, PostgreSQL |
| **Kertu** | Roll B – Marketing Dashboard | Turunduskanalid, kliendihange ja AOV / Kohort | Power BI, SQL, PostgreSQL |
| **Helen** | Roll C – Operations Dashboard | Müügikohad, laoseisud ja kategooriad | Power BI, SQL, PostgreSQL |

## 💡 Meeskonna ühised kokkuvõtlikud soovitused

* **Andmekvaliteet korda:** Täiendada andmebaasi reegleid, et tehingutelt ei puuduks `store_location` ning korrastada `inventory` tabeli negatiivsed jäägid.
* **Kliendi hoidmine (*Retention*):** Suunata fookus uute klientide ostmiselt olemasolevate VIP-klientide (ostud > 5000 €) hoidmisele ja korduvostudele.
* **Varude juhtimine:** Optimeerida meeste riiete ja jalanõude laovarusid vastavalt piirkondlikule nõudlusele.
## Meeskond TOODE 

[Grupitöö esitlus](https://docs.google.com/presentation/d/1bg1lFpKq04LwAn1vqwGZc_S45lVt2TCMeZ8oVTS-EaU/edit)



---

