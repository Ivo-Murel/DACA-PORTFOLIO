Nädal 4 

Agregaatfunktsioonid: COUNT, SUM, AVG, MIN, MAX

Mida mina tegin selle nädala jooksul:

Grupitöö:
- Minu roll - Inventory tabeli analüüs, lisaks products products + sales tabelid 
- Analüüsisin tootekategooriaid, laoseisu ja müüdud vs laos suhteid.
- Kasutasin GROUP BY, HAVING ja window functions, et leida probleemsed kategooriad.

Peamised leiud
- Kõige kõrgema keskmise hinnaga müüakse jalanõusid
- Kõige kasumlikum toode on sünteetilised sporditossud 
- Kõikide kategooriate laoseis kokku on sadades tuhandetes ühikutes, kokku ca 165 000 ühikut
- Inventory tabel on “õhku täis”, andmebaasi/importimise viga.
- Kuna laovarud või müüginumbrid on valed, muudab see küsitavaks ka kogu ülejäänud andmete/müükide õigsuse. 


Individuaalne töö:
1. Grupeeritud andmed kasutades GROUP BY lauseid
2. Filtreertud grupeeritud tulemused HAVING klausliga ja eristus WHERE klausliga
3. Struktureeritud keerulisemad päringuid CTE-de ja window function'itega
4. Inventory tabeli üleslaadimine
5. Müügid kuude lõikes, puuduvad müügid, Top kliendid, parimad tooted.
6. Tartu kaupluste tagastused on läinud topelt.
7. Paljudel toodetel on laojäägid tuhandetes, mis viitab andmebaasi veale või topelt sisestustele.
8. Laojäägid ei vasta laoliikumistele.
9. Tooted millel eco certified oli NULL väärtusega, asendasin selle Falsega

Peamised leiud:
- Kõige suurem müük on Tallinnas ja seal on ka kõige rohkem tellimus 3601 tellimust, käive üle 1 mil€, keskmine tellimus 279€
- Perioodil märts 2025- november 2025 ei toimunud ühtegi müüki, mingi error tõenäoliselt. Esimene müük toimus 2023 jaanuar ja sellest perioodist alates müük toimus 33 kuul ja 9 kuul ei toiminud, ehk siis 2023-2024 on jätkuvalt ok ja probleem on samas 2025 a 9 kuu perioodis.
- Käive on pidevas languses alates 2023-2024 tippudest. 
- TOP klient on Tiina Pärn, kelle ostude kogukäive on 27K0€
- Suurima käibega toode on "Õhuline sünteetiline sporditossud" 27 347€, sama toode on ka parima marginaliga 10,5K€

## Failid
Individual
- `week4.sql` -- minu SQL päringud
- `week4_screenshot.png` -- tulemuste pilt
- 'readme.md

## Meeskonna töö
- [Vaata meeskonnatöö esitlust siit](https://docs.google.com/presentation/d/1NEEeLFbxaILTYv0__Oxeff_V8zb6N4MpVi6k0TyTfrk/edit?slide=id.p#slide=id.p)
- [Vaata meeskonna TOODE repot siit](https://github.com/Ivo-Murel/TOODE/tree/main)
