# Week 4 – SQL agregatsioon ja andmete analüüs

## Meeskond TOODE

**Liikmed:**
- Helen
- Ivo
- Kertu

## Nädala teema

Neljandal nädalal keskendume SQL-i abil andmete grupeerimisele, agregeerimisele ja äriliste järelduste tegemisele UrbanStyle'i andmebaasis.

- [Vaata meeskonnatöö esitlust siit](https://docs.google.com/presentation/d/1NEEeLFbxaILTYv0__Oxeff_V8zb6N4MpVi6k0TyTfrk/edit?slide=id.p#slide=id.p)
- [Vaata meeskonna TOODE repot siit](https://github.com/Ivo-Murel/TOODE/tree/main)

Kasutame GROUP BY, HAVING, CTE-sid ja aknafunktsioone.

## Tööjaotus

| Liige | Roll | Vastutus |
|---|---|---|
| Helen | SALES | Müügi- ja turundusanalüüs |
| Ivo | Inventuur | Kategooriad, laoseis ja müügid |
| Kertu | Kliendid | Kliendianalüüs |

Rollid vahetuvad nädalate lõikes, et kõik meeskonnaliikmed saaksid harjutada erinevate andmevaldkondade analüüsimist.

Minu ülesandeks oli analüüsida tootekategooriaid, laoseisu ja müüdud vs laos suhteid. Kasutasin GROUP BY, HAVING ja window functions, et leida probleemsed kategooriad.

## Peamised leiud
- Kõige kõrgema keskmise hinnaga müüakse jalanõusid 214€/ühik.
- Kõige kasumlikum toode on sünteetilised sporditossud 10,7K€
- Andmekvaliteedi probleem (NULL väärtused): Igasse kategooriasse jagub tooteid ,mille puhul sertifikaadi info puudub täielikult. 
- Andmete järgi on laos 350 toodet neist 231 oleks vaja kohe juurde tellida.
- Kõikide kategooriate laoseis kokku on sadades tuhandetes ühikutes, keskmine laojääk ühe toote kohta 750-1200+tk, seejuures on osad tooted miinuses. 
- Inventory tabel on “õhku täis”, laoseisud tuhandetes pea igal tootel ja negatiivse väärtusega laojäägid on andmebaasi viga.
   - Tõenäoliselt on inventory tabelisse tehtud eraldiseisvaid andmebaasi importeid või käsitsi ülekirjutamisi ja kaks tabelit ei ole omavahel kooskõlas ja andmed on vigased. 
   - Inventory movements tabelist võib olla puudu näiteks välja liikumised (müük, mahakandmine) või inventory tabelit on valesti muudetud. Ideaalis peaks mõlemad numbrid olema samad.
- Kuna laovarud või müüginumbrid on valed, muudab see küsitavaks ka kogu ülejäänud andmete/müükide õigsuse. 

Soovitused
- Kontrollida laojääkide õigsust – laoseisu ja liikumiste logi erinevus on kokku ca 165 000 ühikut. 
- Kontrollida tootenimede õigsust (nt puust müts)
- 18 tootel on öko sertifikaadid NULL väärtusega, kui sertifikaadid puuduvad, siis asendada null FALSE-ga.

