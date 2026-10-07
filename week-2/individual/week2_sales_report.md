# 2. Nädala müügiandmete puhastamise raport

## Juhi kokkuvõte (Executive Summary)
Käesolev raport annab ülevaate `sales` tabeli andmekvaliteedi auditist ja läbi viidud puhastustoimingutest. Andmete analüüsil ilmnes mitmeid kriitilisi vigu, mis moonutaksid ettevõtte müügiaruandeid, kui neid ei korrigeeritaks. Kokku tuvastati süsteemist **6 908 probleemi** (kaasa arvatud tuhanded korduvad duplikaatridad ja loogikavead).

## Andmekvaliteedi probleemide ülevaade
1. **Duplikaadid:** Leiti 5 116 liigset rida, mis on seotud 4013 unikaalse arvenumbriga (`invoice_id`). Need paisutavad kunstlikult müügimahte.
2. **Puuduvad kliendid:** 1 487 real puudub `customer_id`, mis takistab kliendipõhiseid analüüse, kuigi kuupäevad ja summad on olemas.
3. **Loogikavead:** 305 tehingul on kogus ja ühiku hind positiivsed, kuid kogusumma on negatiivne.

---

## Enne / Pärast Andmete Puhastamise Tabel

| Andmekvaliteedi näitaja | Enne puhastamist | Pärast puhastamist | Muudatus / Selgitus |
| :--- | :---: | :---: | :--- |
| **Ridade koguarv** | 15 234 | 10 118 | Eemaldatud 5 116 duplikaatset rida |
| **Duplikaatsed arved** | 4 013 (5 116 rida) | 0 | Kõik korduvad read eemaldatud, säilitatud `MIN(id)` |
| **Puuduvad kliendid (`NULL customer_id`)** | 1 487 | 1 487 | Jäetud alles, vajab logidest tagaselja taastamist |
| **Negatiivse kogusummaga tehingud** | 305 | 305 | Tuvastatud loogikaviga, vajab täpsustust |

---

## Soovitused juhtkonnale (Toomas Kask)
1. Duplikaadid: Paisutavad kunstlikult müügimahte ja summasid, need on vaja enne analüüsi ja raporti genereerimist eemaldada.
2. Negatiivsed kogusummad - tõenäoliselt süsteemi viga ja on vaja aru saada, millest need tekivad? 
3. Puuduvad customer_id (e-poe müük): Müükide kuupäevad ja summad on küll olemas, kuid tühjad väljad takistavad kliendipõhiseid analüüse (näiteks KES on parimad kliendid või kui palju klient on kokku ostnud). Toomas peaks uurima, kas neid andmeid on võimalik tagantjärele logidest või teistest tabelitest taastada.
4. E-poe store location on NULL, selguse ja arusaaavuse mõttes võiks “location” tähis samuti olla ONLINE, sarnaselt nagu see on “channel-il”.  
