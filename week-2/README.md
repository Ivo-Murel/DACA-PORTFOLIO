# Nädal 2: SQL andmete puhastamine

## Mida ma tegin
- ROLL	Müügiandmete puhastaja (Sales Data Cleaner)
- Puhastamisraport (duplikaadid leitud, NULL-id leitud, formaadivead, soovitused) + SQL skript
-   xxxx
-   xxxx
-   xxxx


## Peamised õppetunnid
- Õppisime DELETE + WHERE, UPDATE + SET, COALESCE, CASE WHEN, TRIM/INITCAP
- MITTE KUNAGI ei käivita DELETE ilma WHERE klauslita. Ilma Where-ta kustutab SQL kõik read tabelist ja tagasiteed ei ole
- Esimesena on vaja teha LIVE tabelist koopia ja katsetan koopia faili peal muudatusi, kontrollin muudatusi ja dokumenteerin tegevused ja alles siis, kui olen kindel, et testabel töötab, kordan sama asja LIVE tabeli peal ja viin andmebaasi muudatused sisse.
- Analüütik ei alusta kunagi pimedalt arvutamist, vaid kontrollib alati esmalt andmete kvaliteeti (otsib puuduvaid väärtusi näiteks NULL või duplikaadid, negatiivsed hinnad/kogused, kirjavead, formaatide korrektsus), et vigu hiljem aruandest otsima ei peaks.

## Failid
Individual
- `week2_exploration.sql` -- minu SQL päringud
- `week2_results_screenshot.png` -- tulemuste pilt
Team
- `week2_data_landscape.md' -- viide meeskonnatöö kaustale ja esitlus    ?????????

## Meeskonna töö
- [Vaata meeskonnatööd siit](xxxxxxxxxxxxx)
