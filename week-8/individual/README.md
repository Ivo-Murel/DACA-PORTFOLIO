# Nädala 8 Kokkuvõte: Python Pandas ETL Pipeline'id ja RFM Analüüs

## Ülesanne ja Eesmärk
Üleminek andmete automaatsele töötlemisele ja integreeritud pipeline'ide ehitamisele Pythonis. Eesmärgiks oli ehitada täielik ETL (Extract, Transform, Load) tsükkel UrbanStyle'i müügiandmetele, ühendades API-põhise andmete toomise, kuuraportite genereerimise, RFM (Recency, Frequency, Monetary) kliendisegmentatsiooni ning andmete valideerimise ja visualiseerimise Plotly Expressiga.

---

## Mida Tegin
* **Andmete laadimine ja ekstraheerimine (`Extract`):** Rakendasin pipeline'i andmete toomise funktsiooni, mis laeb sisse tellimuste ja klientide andmed (simuleeritud andmed / API-allikad).
* **Andmete töötlemine ja ühendamine (`Transform`):** 
  * Ühendasin tellimused ja kliendid `pd.merge()` abil.
  * Grupeerisin andmed kuude kaupa (`groupby`), et luua kuuraportid tellimuste arvu ja kogukäibe leidmiseks.
  * Arvutasin RFM meetrika (`last_purchase`, `frequency`, `monetary`) ning määrasin kliendisegmendid (nt reeglipõhised segmentatsioonid nagu *Tippklient*, *Püsiklient*, *Tavaklient* või skooripõhised jaotused).
* **Andmete kvaliteedikontroll (`Validate`):** Lisasin valideerimisfunktsiooni, mis kontrollib andmete olemasolu (`len(results['rfm']) > 0`) enne failide salvestamist, vältides vigaste või tühjade raportite genereerimist.
* **Tulemuste laadimine ja visualiseerimine (`Load`):** 
  * Salvestasin töödeldud andmed automaatselt CSV-failidena (`rfm_report_*.csv`).
  * Lõin interaktiivsed Plotly Expressi graafikud (hajuvusdiagrammid RFM analüüsiks ja tulpdiagrammid kuukäibe kohta) ning salvestasin need HTML-vormingus.
  * Gemini aitas koode siluda ja vigu leida ning seletas lahti ka kitsaskohad ning juhtis tähelepanu sinna, kus juhendis oli midagi puudu või vajas täiendamist. 

---

## 💡 Mida Õppisin
* **ETL Pipeline'i arhitektuur:** Kuidas struktureerida kood modulaarseteks funktsioonideks (`extract`, `transform`, `validate`, `load`), et tagada koodi loogiline voog ja lihtsam vigade tuvastamine.
* **Vigade ennetamine ja käsitlus:** Sain aru, miks valideerimisetapp pipeline'is on kriitiline – see peatab protsessi (`[VALIDATE] PROBLEEM!`) juhul, kui lähteandmed puuduvad või on rikutud.
* **Agregeerimise nüansid:** Rakendasin õigesti `'sum'` agregatsiooni `monetary` veeru jaoks, et summeerida klientide kogukulutused korrektseteks väärtusteks.

---

## 🔍 Peamised Leiud (UrbanStyle)
* **Kogumüügi maht:** UrbanStyle'i süsteemi on edukalt laaditud kokku 10 118 tellimust, mille kogukäive ulatub 2,9 miljoni euroni.
* **Geograafiline jaotus:** 
  * **Tallinn:** 3801 tellimust (~1,09 miljonit EUR).
  * **Tartu:** 1797 tellimust (~521 603 EUR).
  * **Pärnu:** 1058 tellimust (~288 744 EUR).
  * **E-pood:** 3462 tellimust (~997 tuhat EUR).
* **Kliendisegmendid:** Lihvitud reeglid ja RFM-mudel eristavad selgelt väärtuslikumad kliendirühmad (nt suure käibe ja sagedusega *Tippkliendid* eesotsas Jüri Tammega, kelle kogukäive on 532.29 €) riskigruppidest, võimaldades suunata turunduskampaaniaid õigetele sihtrühmadele.
* **Ajaline tipptase:** Kuuraportite analüüsist selgus, et kõige kasumlikem kuu oli **märts 2024** 388,5-eurose käibega (testandmete kontekstis).
