Nädal 4 

Agregaatfunktsioonid: COUNT, SUM, AVG, MIN, MAX

Mida ma tegin
Grupitöö
    ROLL Inventory Tabeli analüüs - Analüüsi tootekategooriaid, laoseisu ja müüdud vs laos suhteid. Kasuta GROUP BY, HAVING ja window functions, et leida probleemsed kategooriad.
- Inventory tabeli üleslaadimine
- Keskmine ostukorvi suurus 288€
- Tartu poe tagastused olid topelt. 
- 245 inimest tõid 60% kogukäibest, keksmine ostukorv neil 89€ võrreldes tavapärase 47€. Klienditoe protseduurid ringi, et vipid saaks kiiremini teenindatud. 
- Aksessuaarid müüsid füüsilises poes paremini, inimesed tahavad kotte ja prille käes hoida, naisteriided tegid online poes parima tulemuse. Aksessuaarireklaamid saatsid inimesed poodi ja kleitide reklaam suunas neid ostma veebipoest.
- Ökotooted müüvad 15% kõrgemate hindadega, roheline suund on kõige kasulikum kasvumootor. 


Individuaalne töö
1. Grupeeritud andmed kasutades GROUP BY lauseid
2. Filtreertud grupeeritud tulemused HAVING klausliga ja eristus WHERE klausliga
3. Struktureeritud keerulisemad päringuid CTE-de ja window function'itega

Peamised leiud:
- Kõige suurem müük on Tallinnas ja seal on ka kõige rohkem tellimus 3601 tellimust, käive üle 1mil€, keskmine tellimus 279€
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
- [Vaata meeskonnatöö esitlust siit](xxxxxxxxxxxxxxxxxxx)
- [Vaata meeskonna TOODE repot siit](https://github.com/Ivo-Murel/TOODE/tree/main)
