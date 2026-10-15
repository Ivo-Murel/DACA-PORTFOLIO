DACA 3. nädala grupitöö

Meeskond Toode
Ivo Murel, Helen Starodubtseva, Kertu Läänemägi

## Tööjaotus

| Liige | Vastutus |
| :--- | :--- |
| Ivo Murel | customers – kliendiandmed |
| Helen Starodubtseva | products ja inventory – tooted ja inventuur |
| Kertu Läänemägi | sales – müügiandmed |

## Töö eesmärk

UrbanStyle'i andmebaasi tabelite ühendamine SQL JOIN-päringutega, et analüüsida klientide ostukäitumist, toodete müüki ja laoseisu.

Minu ülesandeks oli customers ja sales tabeli ühendamine ning kliendianalüüs kasutades INNER JOIN/LEFT JOIN/NULL käsklusi.

### Peamised leiud:
* Andmebaasis on 3150 klienti.
* 599 klienti (19 %) pole kunagi ostnud ja on mitteaktiivsed, lisaks nendest 236 kliendil puudub loyalty_tier, selle asemel on NULL.
* Suurim klientide kadu (73%) tuleb kolmest linnast, kokku 434 klienti:
  * Tallinnas 231 (39%)
  * Tartus 133 (22%)
  * Pärnus 70 klienti (12%)
  * Ülejäänud linnad (27%)
* Kliendid on registreerunud erinevatel kuupäevadel.
* Viimati registreerus uus klient 2025 a. veebruaris.
* Kõige rohkem kliente kadus perioodil 2024 november, kuni 2025 veebruar, olenevalt kuust 44-53 klienti. Millest sellised numbrid? Kas andmebaasi ajaline piirang ei näita tulemusi või ei ole üle aasta aja ühtegi uut klienti juurde saadud.

TOP 20 klienti - erinevatest linnadest, nendest omakorda 10 suurimat klienti on ostnud üle 20K€ väärtuses.

## Soovitused Annale:
* Turundus suunata kolme suuremasse linna.
* Juhul kui on saadaval „turunduse pakett“ mille tasu hõlmab ka ülejäänud 27% mitteaktiivsetest klientidest, aga kulu on näiteks 10% kõrgem, siis tasub ka seda varianti kaaluda.
* Sihitud email või SMS mitteaktiivsetele klientidele.
* Klientidel kellel puudub loyalty_tier märge, koheselt aktiveerida “Silver” staatus (tähtajaliselt/tähtajatult) ja saata ka vastavad pakkumised eesmärgiga saada kliendilt esimene ost.
* Selgitada välja kas uute klientide registreerimisega on mingi viga?
