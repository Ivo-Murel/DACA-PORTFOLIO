> **ALAÜLESANDE KAART** | Nädal: 5 | Meeskond: TOODE | Roll: A

# Grupitöö esitlus

## ROLL: CEO Dashboard (Kristi — kõrgtaseme KPI-d)

**ÜLESANNE:** Kristi tahab näha ühe pilguga, kas UrbanStyle kasvab või sureb. Loo CEO dashboard kõrgtaseme müügitulu, klientide arvu ja kasvutrendiga.

* **SISEND:** `sales`, `customers` (Supabase või CSV)
* **VÄLJUND:** 2 diagrammi + äritõlgendus
================================================================================

## Meeskonna töö
- [Vaata meeskonnatöö esitlust siit](https://docs.google.com/presentation/d/1bg1lFpKq04LwAn1vqwGZc_S45lVt2TCMeZ8oVTS-EaU/edit?slide=id.p#slide=id.p)
- [Vaata meeskonna TOODE repot siit](https://github.com/Ivo-Murel/TOODE/tree/main)


## 📌 Projekti ülevaade
Viiendal nädalal lõime Power BI Desktopis interaktiivsed juhtimislauad (*dashboards*), et esitada visuaalselt SQL-iga analüüsitud UrbanStyle äriandmeid. Kasutasime brändivärve (`#009B8D` teal) ja *Data-ink ratio* põhimõtteid.

---

## 👥 Meeskonna tööjaotus

* **Ivo (CEO Dashboard):** Kõrgtaseme KPI-d, müügitulu ja kasvu trendid.
* **Kertu (Marketing Dashboard):** Turunduskanalid, kliendihange, AOV ja kohordianalüüs.
* **Helen (Operations Dashboard):** Müügikohad, laoseisud ja tootekategooriad.

---

## 🔍 Peamised leiud

* **CEO (Ivo):** 2024. aasta tippkäive oli 1,47M €, kuid tegevus vajus kokku (2026 käive vaid ~4k € ehk -99,7%). Müügihüpped toimuvad Q2 ja Q4.
* **Turundus (Kertu):** Liigne fookus uutel klientidel; madal kliendipidavus (*retention*) ja korduvostude määr. Väärtuslikum ostjasegment on turunduskanalitega seostamata.
* **Operatsioonid (Helen):** Tallinn teeb suurima tuvastatud käibe (1,09M €), kuid ~1,01M € tehingutel puudub asukoht (`NULL`). Kogu laoseis on 376k ühikut (suurim osakaal kesklaos ja meeste riietel).

---

## 💡 Olulisemad soovitused

1. **Andmekvaliteet:** Muuta tehingute asukoht (`store_location`) kohustuslikuks ja korrastada laoseisud.
2. **Kliendihoid:** Suunata ressursid uute klientide püüdmiselt püsiklientide lojaalsusprogrammi.
3. **Süstematiseerimine:** Ajastada kampaaniad kõrghooaegadele ja optimeerida laovarud vastavalt nõudlusele.
