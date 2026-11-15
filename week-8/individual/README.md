# Nädala 8 Kokkuvõte: Python Pandas ETL Pipeline'id ja RFM Analüüs

## Ülesanne ja eesmärk
Üleminek andmete automaatsele töötlemisele ja integreeritud pipeline'ide ehitamisele Pythonis. Eesmärgiks oli ehitada täielik ETL (Extract, Transform, Load) tsükkel UrbanStyle'i müügiandmetele, ühendades API-põhise andmete toomise, kuuraportite genereerimise, RFM (Recency, Frequency, Monetary) kliendisegmentatsiooni ning andmete valideerimise ja visualiseerimise Plotly Expressiga.

---

## Mida tegin
* **Andmete laadimine ja ekstraheerimine (`Extract`):** Rakendasin pipeline'i andmete toomise funktsiooni, mis laeb sisse tellimuste ja klientide andmed (simuleeritud andmed / API-allikad).
* **Andmete töötlemine ja ühendamine (`Transform`):** 
  * Ühendasin tellimused ja kliendid `pd.merge()` abil.
  * Grupeerisin andmed kuude kaupa (`groupby`), et luua kuuraportid tellimuste arvu ja kogukäibe leidmiseks.
  * Arvutasin RFM meetrika (`last_purchase`, `frequency`, `monetary`) ning määrasin kliendisegmendid (nt reeglipõhised segmentatsioonid ja skooripõhised jaotused).
* **Andmete kvaliteedikontroll (`Validate`):** Lisasin valideerimisfunktsiooni, mis kontrollib andmete olemasolu (`len(results['rfm']) > 0`) enne failide salvestamist, vältides vigaste või tühjade raportite genereerimist.
* **Tulemuste laadimine ja visualiseerimine (`Load`):** 
  * Salvestasin töödeldud andmed automaatselt CSV-failidena ja interaktiivsete Plotly Expressi graafikutena (HTML-vormingus).

---

## Mida õppisin
* **ETL Pipeline'i arhitektuur:** Kuidas struktureerida kood modulaarseteks funktsioonideks (`extract`, `transform`, `validate`, `load`), et tagada koodi loogiline voog ja lihtsam vigade tuvastamine.
* **Vigade ennetamine ja käsitlus:** Sain aru, miks valideerimisetapp pipeline'is on kriitiline – see peatab protsessi (`[VALIDATE] PROBLEEM!`) juhul, kui lähteandmed puuduvad või on rikutud.
* **Agregeerimise nüansid:** Rakendasin õigesti `'sum'` agregatsiooni `monetary` veeru jaoks, et summeerida klientide kogukulutused korrektseteks väärtusteks.

---

## Peamised Leiud (UrbanStyle)
* **Kogumüügi maht:** UrbanStyle'i süsteemi on edukalt laaditud kokku 10 118 tellimust, mille kogukäive ulatub 2,9 miljoni euroni.
* **Geograafiline jaotus:** 
  * **Tallinn:** 3801 tellimust (~1,09 miljonit EUR).
  * **Tartu:** 1797 tellimust (~521 603 EUR).
  * **Pärnu:** 1058 tellimust (~288 744 EUR).
  * **E-pood:** 3462 tellimust (~997 tuhat EUR).
* **Pipeline'i testanalüüsi tulemused:**
  * **Segmendid:** Reeglipõhises mudelis oli defineeritud 4 segmenti (*Tippklient*, *Püsiklient*, *Ohus*, *Tavaklient*), kuid konkreetsete testandmetega tuvastati reaalselt **3 segmenti** (kuna "Ohus" segmenti antud andmetega ei esinenud).
  * **Kõige väärtuslikum klient:** **Jüri** (kogukäive 532.29 €).
* **Kliendisegmendid ja mahud (RFM analüüs):** Lihvitud RFM-mudel ja skooripõhised jaotused liigutasid kliendid selgetesse kategooriatesse:
  * **Harjutus tippkliendid:** 632 klienti
  * **Harjutus kasvupotentsiaal:** 824 klienti
  * **Harjutus riskikliendid:** 270 klienti
* **Kuuraportite analüüsist selgus, et kõige kasumlikem kuu oli **märts 2024** 388,5-eurose käibega (testandmete kontekstis).
