# UrbanStyle CEO Dashboard – Raport ja ülevaade

## Juhi kokkuvõte (Executive Summary)

Käesolev ülevaade annab kokkuvõtte `UrbanStyle` tegevjuhi (CEO) töölaua visuaalsest ehitusest ja rakendatud interaktiivsetest elementidest. Dashboard koondab peamised müüginäitajad, hooajalised trendid, toodete tulemuslikkuse ning müügikanalite jaotusandmed ühte ühtse disainiga vaatesse, võimaldades teha kiireid juhtimisotsuseid.

---

## Dashboardi visuaalide ja elemendide ülevaade

1. **KPI kaardid:** Lisatud ja vormindatud kolm peamist mõõdikut: **KOGUKÄIVE** (`2.91M`), **KESKMINE OSTUSUMMA** (`287.53 €`) ja **UNIKAALSEID MÜÜKE** (`10 118`). Numbrivormingutes eemaldati ülearused lühendid ja ühtlustati roheline värvitoon.
2. **Joondiagramm (Müügitrend):** Kujundatud müügitrendi graafik aastateks 2023–2024 koos andmesiltidega, lisatud sinine eesmärgi viitejoon (`Eesmärk: €120K`) ning annotatsioon rekordkuu kohta (`Parim kuu läbi aegade`).
3. **Tulpadega diagramm (TOP 10 toodet):** Seadistatud müügitulu järgi parimate toodete tulpdiagramm ning lisatud tekstiline annotatsioon ("Hero toode").
4. **Sõõrdiagramm (Müügitulu kategooriate kaupa):** Loodud kategooriate osakaalu sõõrdiagramm (`High Value`, `Standard`, `Low Value`), kohandades sektorite värve ja sildistust.
5. **Sektordiagramm (Müügi osakaal kanalite lõikes):** Kujundatud müügikohtade jaotuse sektordiagramm (Tallinn, Online, Tartu, Pärnu) koos protsendiliste näitajatega.
6. **Müügikoha slicer (Filter):** Lisatud lehe ülaleserva interaktiivne `MÜÜGIKOHT` rippmenüü-slicer andmete kiireks filtreerimiseks.

---

## Visuaalide tehnilised seaded ja rollid

| Visuaali tüüp | Mõõdik / Väljad | Kujunduse kohandused / Tehniline teostus |
| :--- | :--- | :--- |
| **KPI Card (Kaart)** | `Sum of total_price`, `Average Order Value`, `Count of sale_id` | Seadistatud `Display units: None`, fondi suurus ja täpne HEX-roheline värvitoon. |
| **Line Chart (Joondiagramm)** | `Müügitulu`, `Kuupäev` (2023-2024) | Lisatud `Data labels`, sinine `Y-axis constant line` ja kohandatud annotatsioonid. |
| **Bar / Column Chart** | `TOP 10 toodet`, `Müügitulu` | Standardiseeritud värvipalett, tekstikastiga annotatsioon "Hero toode" analüüsiks. |
| **Donut Chart (Sõõrdiagramm)** | `Müügitulu kategooria lõikes` | Muudetud sektorite (`Slices`) värvikoodid ja keskel asuv koondnäitaja. |
| **Pie Chart (Sektordiagramm)** | `Müügi osakaal kanalite lõikes` | Jaotatud osakaalud protsentides linna ja e-poe lõikes. |
| **Slicer (Filter)** | `store_location` / `Müügikoht` | Vormindatud ühtse "clean look" stiiliga rippmenüü (Dropdown) päisesse. |
**Mobiilivaade:** Kohandada sama töölaud Power BI mobiilivaate (*Mobile Layout*) jaoks, et juhtkond saaks andmeid jälgida ka nutiseadmetes.

---
## Peamised leiud

* **Kogukäive ja kasumlikkus:** Ettevõtte kogukäive on tugeval tasemel (`2.91M €`), kuid müügimahtude kasvust hoolimata on oluline teostada põhjalik kulude audit, et tuvastada võimalikud ebatõhusused ja ärikahjumid.
* **Hooajalisus ja tipud:** Müügitrendid näitavad selget hooajalisust – oktoober 2024 saavutas läbi aegade parima tulemuse (`171K €`), kusjuures suvekuudel ja tipperioodidel on müügile suurim mõju.
* **Top tooted ja "Hero" toode:** Enim müüdud tooteks on *Õuhune sünteetiline sporditussud*, mis moodustab märkimisväärse osa kogukäibest (`28%`).
* **Müügikanalite jaotus:** Müügitulu jaguneb mitme olulise kanali vahel, kusjuures Tallinna füüsiline pood ja e-poe müük (`Online`) moodustavad kumbki tugeva osakaalu kogu käibest (`37.54%` ja `34.61%`).
* **Andmete kvaliteet:** Varastes andmetes esineb puudujääke ja ebakõlasid (näiteks puuduvad täielikud mitme aasta ajaloolised andmed ja osadel kirjetel lojaalsusandmed), mis nõuavad jätkuvat andmete puhastamist.

---
## Soovitused edasiseks arenduseks

1. **Andmete dünaamilisus:** Tagada, et viitejooned (*Reference lines*) ja eesmärgid muutuksid automaatselt vastavalt valitud müügikoha filtrile.
2. **Kujunduse konsistentsus:** Säilitada kõigil lehtedel ühtne värvipalett (rohelised KPI-d, sinised tulpdiagrammid ja standardsed fondisuurused).
