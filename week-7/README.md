# Nädal 7 – UrbanStyle'i kliendiandmete analüüs ja RFM-kliendisegmenteerimine
## Meeskond TOODE

**Liikmed:** Ivo, Kertu ja Helen

## Meeskonna töö
- [Vaata meeskonnatöö esitlust siit](https://docs.google.com/presentation/d/1vbaf-APMytQiKg2gAz_WpOAedij0oYG_KPxh-iSFeSM/edit?slide=id.h1f0825d16c0641e4_0_13#slide=id.h1f0825d16c0641e4_0_13)
- [Vaata meeskonna TOODE repot siit](https://github.com/Ivo-Murel/TOODE/tree/main)


## Nädala eesmärk

analüüsida UrbanStyle'i müügi- ja kliendiandmeid Python Pandase abil, koostada RFM-kliendisegmenteerimine ning esitada juhtkonnale andmetel põhinevad järeldused ja soovitused.

Analüüsi abil soovime välja selgitada ettevõtte väärtuslikumad kliendid, tuvastada riskikliendid ning leida võimalusi kliendilojaalsuse suurendamiseks.

## Rollijaotus

| **Liige** | **Roll** | **Vastutus** |
|---|---|---|
| Ivo | A+b – Data Loading + Cleaning | Andmete laadimine, ühendamine ja puhastamine |
| Helen | C – RFM Analysis | RFM-näitajate arvutamine ja kliendisegmenteerimine |
| Kertu | D – Visualization | Visualiseerimine ja ärilised soovitused |

Meeskonnas on töö jaotatud kolmeks: Ivo vastutab andmete ettevalmistamise, Helen RFM-analüüsi ning Kertu visualiseerimise ja äriliste soovituste eest.
Ühise töö tulemusena valmib terviklik andmeanalüüs, mis aitab toetada UrbanStyle'i kliendisuhete ja turundustegevuste arendamist. Iga meeskonnaliige dokumenteerib oma panuse ka individuaalses GitHubi portfoolios. 

## Kasutatud töövahendid

- Python
- Pandas
- Plotly Express
- Google Colab / Jupyter Notebook
- PostgreSQL ja Supabase
- GitHub
- ChatGPT (analüüsi ja dokumentatsiooni abivahend)

## Planeeritud töö

- UrbanStyle'i müügi- ja kliendiandmete laadimine.
- Andmete ühendamine ja kvaliteedikontroll.
- Puuduvate väärtuste ja duplikaatide kontrollimine.
- Recency, Frequency ja Monetary näitajate arvutamine.
- RFM-skooride määramine skaalal 1–5.
- Klientide jagamine RFM-segmentidesse.
- Plotly Expressi abil diagrammide koostamine.
- Tulemuste tõlgendamine ja äriliste soovituste esitamine.

## RFM-analüüs põhineb kolmel näitajal:

- **Recency (R)** – mitu päeva on möödunud kliendi viimasest ostust.
- **Frequency (F)** – mitu ostu klient on teinud.
- **Monetary (M)** – kui palju klient on kokku kulutanud.

RFM-skooride põhjal jagatakse kliendid segmentidesse.

| **RFM-skoor** | **Segment** |
|---|---|
| 13–15 | VIP Champions |
| 10–12 | Loyal |
| 7–9 | Potential |
| 4–6 | At Risk |
| 3 | Lost |

## Oodatavad tulemused ja järeldused

Grupitöö käigus soovime välja selgitada:

- VIP-klientide arvu ja nende kogukulutused.
- Lojaalsete klientide osakaalu.
- Riskiklientide arvu ja ostukäitumise.
- Klientide jaotuse erinevate RFM-segmentide vahel.
- Võimalused kliendisuhete ja turundustegevuste parandamiseks.

Tulemuste põhjal koostame soovitused UrbanStyle'i tootejuhile Marko Saarele.
- VIP Champions -411 klienti: Meie kõige väärtuslikum tuumik (kõrge ostusagedus, hiljutisus ja kogukulutus). Nad annavad ebaproportsionaalselt suure osa kogukäibest ning moodustavad stabiilse baasi püsiva müügitulu hoidmisel.
- At Risk High Value - 281 klienti: Kliendid, kellel on ajalooliselt kõrge ostusagedus ja Monetary-väärtus, kuid kelle viimasest ostust on möödunud kriitiline aeg (Recency skoor madal). Nad vajavad kohest sekkumist, et ennetada nende liikumist lõplikult passiivsesse faasi.
- Kasvu- ja potentsiaalsed segmendid - 604 klienti: Sisaldab rühmi Loyal Active, New / Promising ja Potential. Nende ostumuster näitab valmisolekut liikuda kõrgemasse väärtustasemesse sobivate tootesoovituste ja stiimulite toel.

## Minu isikliku töö tulemused. 

- **Andmete laadimine ja uurimine:** Laadisin müügi- ja kliendiandmed (CSV) pandas'esse ning uurisin struktuuri ja tüüpe (`head()`, `info()`, `describe()`, `shape`).
- **Töötlemine ja filtreerimine:**
 - **RFM Mudeli ehitamine:** 
  1. Arvutasin viimase ostu aja (*Recency*), ostusageduse (*Frequency*) ja kogukulutuse (*Monetary*).
  2. Jagasin andmed skoori-gruppidesse `pd.qcut()` abil (kasutades loendurites `.rank(method='first')`).
  3. Määrasin reeglitega kliendisegmendid (*VIP Champions*, *Loyal Customers*, *Potential Loyalists*, *At Risk*).
- **Interaktiivne visualiseerimine:** Lõin Plotly Expressiga dünaamilisi graafikuid (`px.bar`, `px.line`, `px.scatter`, `px.pie`) segmentide jaotuse ja kuutrendide kuvamiseks.

---
 - Kasutasin Gemini AI abi koodide tõlgendamisel, puhastamisel ning tulemuste selgitamisel
 - Supabase, kontroll ja võrdlus Pythoni tulemustega. 


## Peamised Leiud (UrbanStyle)

- **Tallinn domineerib müügimahult:** Enamik tellimusi (5 704 rida, ~1,63M €) pärineb Tallinna kauplusest, samal ajal kui Tartu näitab kõrgeimat keskmist ostukorvi (~289 €).
- **Käibe jaotus toodetena:** Suurima käibemahu annavad jalanõude ja meeste riiete kategooriad.
- **RFM Kliendisegmendid:**
  - **VIP Champions (466 klient):** Genereerivad valdava osa (kuni 60–70%) ettevõtte kogutulust.
  - **At Risk segment:** Vajab kohest tagasivõitmise kampaaniat (personaalsed soodustused), et vältida klientide lahkumist enne nende lõplikku kaotamist.
  - Osad koodid vajasid muutmist, sest juhendis oli puudusi. 



