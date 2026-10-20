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
