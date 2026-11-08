# 📊 Nädal 7 Kokkuvõte: Python Pandas & Interaktiivne Kliendisegmenteerimine

## 🎯 Ülesanne ja Eesmärk
Üleminek SQL-põhisest andmete pärimisest Pythoni andmetöötluskeskkonda. Eesmärgiks oli laadida UrbanStyle'i müügiandmed pandas DataFrame'i, läbi viia kliendikäitumise analüüs, ehitada RFM (*Recency, Frequency, Monetary*) mudel ning visualiseerida tulemused interaktiivsete Plotly Express graafikutega, et pakkuda juhtkonnale strateegilisi sisendikampaaniaid.

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
