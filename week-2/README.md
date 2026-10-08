# Nädal 2: SQL andmete puhastamine

## Mida ma tegin
- ROLL	Müügiandmete puhastaja (Sales Data Cleaner)
- Puhastamisraport (duplikaadid leitud, NULL-id leitud, formaadivead, soovitused) + SQL skript
- Duplikaadid on loetud GROUP BY + HAVING abil: SQL- skript annab tulemuseks
    - 4013 unikaalset duplikaatset arvet (invoice_id) - arved, mis esinevad süsteemis rohkem kui korra ja millel on vähemalt üks koopia. 
    - 5116 duplikaatset rida (korduvad read)
- Kuupäevadega ja hindadega probleeme ei ole, need on olemas ja formaadid on samad
- 305 müügitehingut on miinusmärgiga - toodetel on müügihind ja müüdud kogus olemas, aga kogusumma on negatiivne samas väärtuses, tasuta tooted ei saa olla - need oleks arvel null hinnaga. 
- E-poe müükidel ei ole customer_id küljes - kokku 1487 rida
- Sales tabelist loodud koopia sales_test



## Peamised õppetunnid
- Õppisime DELETE + WHERE, UPDATE + SET, COALESCE, CASE WHEN, TRIM/INITCAP
- MITTE KUNAGI ei käivita DELETE ilma WHERE klauslita. Ilma Where-ta kustutab SQL kõik read tabelist ja tagasiteed ei ole
- Esimesena on vaja teha LIVE tabelist koopia ja katsetan koopia faili peal muudatusi, kontrollin muudatusi ja dokumenteerin tegevused ja alles siis, kui olen kindel, et testabel töötab, kordan sama asja LIVE tabeli peal ja viin andmebaasi muudatused sisse.
- Analüütik ei alusta kunagi pimedalt arvutamist, vaid kontrollib alati esmalt andmete kvaliteeti (otsib puuduvaid väärtusi näiteks NULL või duplikaadid, negatiivsed hinnad/kogused, kirjavead, formaatide korrektsus), et vigu hiljem aruandest otsima ei peaks.

## Failid
Individual
- `week2_sales_cleaning.sql` -- minu SQL päringud
- `week2_results_screenshot.png` -- tulemuste pilt
- 'week2_sales_report.md

## Meeskonna töö
- [Vaata meeskonnatöö esitlust siit](https://docs.google.com/presentation/d/17zH0yna0C4xXgK4qMWkMrlxvIhGTtx_2h1xMmsGTgLI/edit?slide=id.h5149412c77256a12_1_46#slide=id.h5149412c77256a12_1_46)
- [Vaata meeskonnatööd siit](https://github.com/Ivo-Murel/TOODE/tree/main)
