# Nädal 3 – SQL JOIN-id ja andmete puhastamine

Kolmandal nädalal õppisin UrbanStyle'i andmebaasis klientide andmeid puhastama ja erinevate SQL JOIN-päringute abil tabelite vahel seoseid looma. Harjutasin müügiandmete analüüsimist ning tulemuste kasutamist kampaania planeerimisel.

## SQL-teemad

* **Andmete puhastamine:** linnanimede kontroll ja ühtlustamine (TRIM, INITCAP, UPDATE).
* **INNER JOIN:** müükide ühendamine klientide ja toodetega.
* **LEFT JOIN:** ostudeta klientide ja müümata toodete leidmine.
* **Mitme tabeli JOIN:** klientide, toodete ja müükide ühine analüüs.
* **GROUP BY ja SUM:** müügitulu arvutamine linnade ja tootekategooriate kaupa.
* **ORDER BY ja LIMIT:** olulisemate tulemuste järjestamine.

* # Turunduskampaania andmeanalüüs (Anna päringud)

Selles repositooriumis on lahendatud neli peamist ärianalüüsi küsimust Anna turunduskampaania jaoks, kasutades erinevaid SQL-i mustreid (`INNER JOIN`, `LEFT JOIN`, `GROUP BY`, agregeerimisfunktsioone ning andmete filtreerimist).

## Analüüsi tulemused ja päringud

### 1. TOP 20 klienti (Kes ostab enim?)
* **Tehnika:** `INNER JOIN` + `ORDER BY` + `LIMIT`
* **Tulemus:** Edetabeli tipust leiame näiteks Tiina Pärna Tartust, kes on toonud kõige suurema ostumahu.

### 2. Kadunud kliendid (Kes registreerus, aga pole ostnud?)
* **Tehnika:** `LEFT JOIN` + `WHERE IS NULL` + `GROUP BY`
* **Tulemus:** Analüüs näitas, et kõige rohkem kliente on registreerunud, kuid ostu sooritamata jäänud Mustamäel / Tartus (linnade lõikes enim kadunud kliente Tartus).

### 3. Müümata / Ostetud tooted kategooriate kaupa (Mida TOP kliendid ostavad?)
* **Tehnika:** Mitme tabeli `INNER JOIN` (sales, customers, products)
* **Tulemus:** Kõige enam ostetakse kategooriatest aksessuaare, millele järgnevad jalanõud ning laste-, naiste- ja meesteriided.

### 4. Linnade ülevaade (Kust tulevad parimad kliendid?)
* **Tehnika:** `JOIN` + `GROUP BY` + `SUM` / `COUNT` / `AVG`
* **Tulemus:** 
  * **Tallinn:** Tõuseb esile suurima aktiivsusega – **1007 aktiivset klienti**.
  * **Tehingud ja käive:** Kokku tehti **3601 tellimust**, mille kogukäive ulatus **1 miljoni euroni**.
  * **Keskmine ostukorv:** Keskmise tellimuse suuruseks kujunes **279 €**.
