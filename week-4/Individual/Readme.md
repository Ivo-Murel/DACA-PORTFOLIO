NÄDAL 4  - SQL Agregatsioon

Mida õppisin 
1. Grupeerin andmeid äriloogika järgi, kasutades GROUP BY lauseid
2. Filtreerisin grupeeritud tulemusi HAVING klausliga ja eristasin seda WHERE-st
3. Struktureerisin keerulisi päringuid CTE-de ja window function'itega

Tulemused
-- 1. Müügitrendid — Kuidas käive kuude lõikes muutub?
-- Tulemus: Müük algab 2023. aasta jaanuaris käibega 79 735.03 €. Suurimad tõusud olid 2023. aasta juunis (+30 221.25 €, käive 125 537.50 €) ja detsembris (+30 008.07 €, käive 129 104.59 €). Suurim kukkumine toimus 2024. aasta jaanuaris (-43 485.94 €), mis viitab selgele hooajalisusele pärast aastalõpu müügibuum.

-- 2. TOP toodete analüüs — Mis müüb kõige paremini?
-- Tulemus: Suurima käibega toode on "Õhuline sünteetiline sporditossud" (27 347.04 €, müüdi 63 tk). Tükimüügilt on edukaim "Boheemlaslik puuvillane tuulejope" (71 tk, käive 21 309.96 €). Esiviisiku toodete kogukäive on ühtlaselt kõrge, vahemikus 21,3k kuni 27,3k eurot.

-- 3. Geograafiline ülevaade — Millistes linnades on parimad tulemused?
-- Tulemus: Müügi absoluutne liider on Tallinn, ületades 1 miljoni euro piiri (1 006 252.88 € ja 3 601 tellimust). Teisel kohal on Tartu (523 286.64 €) ja kolmandal Pärnu (374 005.86 €). Esikolmik moodustab valdava enamuse kogukäibest, samal ajal kui tabeli lõpus olevad linnad nagu Paide teevad umbes 53k eurot käivet.

-- 4. Kliendianalüüs — Kes on meie VIP kliendid?
-- Tulemus: Meie TOP klient on Tiina Pärn, kelle ostude kogukäive on muljetandvad 27 668.02 €. Esimesed kliendid ületavad 20 000 euro piiri (näiteks Priit Rand 26 286.10 € ja Kevin Org 23 467.13 €), mis näitab, et VIP-segment panustab ettevõtte tuludesse väga tugevalt.

-- 5. Varude audit — Kus on erinevused?
-- Tulemus: Kõige suurema läbimüügiga toode tükkide arvestuses on "Moodne seemisnahkne oxfordid" (83 tk, ostuhind 149.36 € ja müügihind 221.42 €). Tihedalt järgnevad "Minimalistlik villane pühapäevakleit" (81 tk) ja "Luksuslik softshell komplekt" (80 tk). Andmebaasis on kokku 362 toodet, mis annab hea ülevaate toodete liikumiskiirusest ja marginaalidest.

Top 5 linnad ja trendid
| koht | linn | tellimusi | kogukaive | keskmine_tellimus | osakaal_pct | viimase_kuu_kaive | varasemate_kuude_keskmine | kuu_muutus_eur |
|---|---|---|---|---|---|---|---|---|
| 1 | Tallinn | 2062 | 571649.39 | 277.23 | 37.94 | 43855.03 | 34034.50 | 9820.53 |
| 2 | Tartu | 1011 | 292500.31 | 289.32 | 19.41 | 19154.95 | 17595.27 | 1559.68 |
| 3 | Pärnu | 755 | 226008.72 | 299.35 | 15.00 | 18590.48 | 13009.85 | 5580.63 |
| 4 | Narva | 233 | 67458.67 | 289.52 | 4.48 | 3561.89 | 4822.15 | -1260.26 |
| 5 | Viljandi | 215 | 60339.62 | 280.65 | 4.00 | 5124.26 | 3818.63 | 1305.63 |

SUURIMAD KATEGOORIAD
| kategooria | müüdud_kokku_tk | kogukäive | keskmine_hind | toodete_arv |
| :--- | :---: | :---: | :---: | :---: |
| jalanõusid | 3737 | 774035 | 213.26 | 71 |
| meeste_riided | 4121 | 749799 | 188.61 | 81 |
| naiste_riided | 3604 | 686464 | 195.55 | 68 |
| aksessuaarid | 3231 | 393036 | 122.88 | 62 |
| laste_riided | 3686 | 305844 | 84.70 | 68 |

TOP 15 KLIENDID
| customer_id | nimi | tellimuste_arv | kogukäive |
| :--- | :--- | :---: | :---: |
| 3618 | Tiina Pärn | 73 | 27668 |
| 3350 | Priit Rand | 76 | 26286 |
| 2997 | Kevin Org | 78 | 23467 |
| 2889 | Laura Tammik | 74 | 23386 |
| 3648 | Erkki Ilves | 72 | 22942 |
| 3605 | Anu Kuusik | 77 | 21626 |
| 4206 | Kersti Lill | 71 | 21137 |
| 2221 | Riina Lill | 67 | 20972 |
| 2154 | Annika Saar | 66 | 20727 |
| 3722 | Ago Kull | 64 | 20125 |

TOP 15 TOOTED MARGINALI JÄRGI
| product_id | product_name | cost_price | retail_price | kokku_myydud | kogumarginaal |
| :--- | :--- | :---: | :---: | :---: | :---: |
| 1031 | Õhuline sünteetiline sporditossud | 266.31 | 434.08 | 63 | 10570 |
| 1108 | Trendikas goretex oxfordid | 223.83 | 371.05 | 65 | 9569 |
| 1223 | Praktiline kangast kõrge kontsaga kingad | 192.81 | 319.98 | 68 | 8648 |
| 1293 | Boheemlaslik linane pullover | 217.33 | 351.33 | 64 | 8576 |
| 1198 | Õhuline sünteetiline kõrge kontsaga kingad | 186.77 | 291.72 | 79 | 8291 |
| 1143 | Õhuline linane jakk | 182.53 | 307.83 | 63 | 7894 |
| 1210 | Vintage tweed kampsun | 225.61 | 374.54 | 52 | 7744 |
| 1160 | Moodne villane nahk sandaalid | 226.48 | 368.67 | 54 | 7678 |
| 1049 | Boheemlaslik puuvillane tuulejope | 200.72 | 308.84 | 71 | 7677 |
| 1006 | Praktiline džersii seelik | 208.86 | 319.42 | 69 | 7629 |
| 1009 | Praktiline merino villane parka | 206.74 | 332.55 | 59 | 7423 |
| 1060 | Luksuslik puuvillane linane särk | 153.00 | 253.26 | 73 | 7319 |
| 1069 | Klassikaline seemisnahkne jooksutossud | 242.90 | 402.62 | 45 | 7187 |
| 1303 | Mugav merino villane tuulejope | 197.42 | 312.41 | 62 | 7129 |
| 1346 | Mugav merino villane cargo püksid | 157.35 | 258.91 | 70 | 7109 |
