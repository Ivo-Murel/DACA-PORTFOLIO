--Ilma GROUP BY-ta näitab SQL iga rida eraldi. UrbanStyle'il on 10 118 müügitellimust — Kristi ei taha näha 10 118 rida. Ta tahab näha 12 rida (üks iga kuu kohta).
select * from sales

--Ilma GROUP BY-ta:
-- 10 118 rida (iga tellimus eraldi)
SELECT sale_date, total_price
FROM sales;
--GROUP BY-ga:
-- 12 rida (iga kuu summa)
SELECT
    DATE_TRUNC('month', sale_date) AS kuu,
    SUM(total_price) AS kogukäive
FROM sales
WHERE sale_date >= '2024-01-01'
GROUP BY DATE_TRUNC('month', sale_date)   --võtab kuupäeva (näiteks 2024-05-14) ja "lõikab" ehk ümardab selle kuu algusesse (ehk 2024-05-01). Grupeerimine kuude kaupa: Ilma selleta rühmitaks andmeid iga täpse kuupäeva (päev-päevalt) järgi. Funktsioon DATE_TRUNC tõstab kõik sama kuu kuupäevad ühise nimetaja (YYYY-MM-01) alla, et saaksid arvutada igakuist kogukäivet.
ORDER BY kuu;

-- sama asi mis eelmine, aga müügid on järjestatud suuremast väiksemani alates 2024
SELECT
    DATE_TRUNC('month', sale_date) AS kuu,
    SUM(total_price) AS kogukäive
FROM sales
WHERE sale_date >= '2024-01-01'
GROUP BY DATE_TRUNC('month', sale_date)
ORDER BY kogukäive DESC;
-- tulemus 21 rida, alates 2024 jaanuars, käive alates suuremast väiksemani. 30 kuu jooksul on müük olnud ainult 21 kuul, seepärast ka selline number. suurim müük dets 2024 170K€

--müügid alates 2023a algusest
SELECT
    DATE_TRUNC('month', sale_date) AS kuu,
    SUM(total_price) AS kogukäive
FROM sales
WHERE sale_date >= '2023-01-01'
GROUP BY DATE_TRUNC('month', sale_date)
ORDER BY kuu asc;
--müügid alates 2023a algusest, 33 kuud. 


--kuidas kontrollida, mis kuudel müüki ei olnud, alates 2024 a. 
WITH koik_kuud AS (
    -- Genereerime järjest kõik kuud vahemikus jan 2024 kuni juuni 2026
    SELECT generate_series(
        '2024-01-01'::date,
        '2026-06-01'::date,
        '1 month'::interval
    )::date AS kuu
),
kuude_myyk AS (
    -- Groupime olemasolevad müügid kuude kaupa
    SELECT
        DATE_TRUNC('month', sale_date)::date AS kuu,
        SUM(total_price) AS kogukaive,
        COUNT(*) AS tehingute_arv
    FROM sales
    WHERE sale_date >= '2024-01-01'
    GROUP BY DATE_TRUNC('month', sale_date)::date
)
SELECT 
    k.kuu,
    COALESCE(m.kogukaive, 0) AS kogukaive,
    COALESCE(m.tehingute_arv, 0) AS tehingute_arv
FROM koik_kuud k
LEFT JOIN kuude_myyk m ON k.kuu = m.kuu
WHERE m.kogukaive IS NULL -- Kuvab AINULT need kuud, kus müüki ei toimunud
ORDER BY k.kuu;
-- perioodil märts 2025- november 2025 ei toimunud ühtegi müüki, mingi error tõenäoliselt. 

--millal oli kõige esimene müügitehing
SELECT 
    MIN(sale_date) AS esimene_tehing,
    MAX(sale_date) AS viimane_tehing
FROM sales;
-- tulemus 2023 jaanuar

--kuidas kontrollida, mis kuudel müüki ei olnud, alates 2023 a. sama mis eelmine kood, aga kuupäevad teised
WITH koik_kuud AS (
    -- Genereerime järjest kõik kuud vahemikus jan 2023 kuni juuni 2026
    SELECT generate_series(
        '2023-01-01'::date,
        '2026-06-01'::date,
        '1 month'::interval
    )::date AS kuu
),
kuude_myyk AS (
    -- Grupeerime olemasolevad müügid kuude kaupa alates 2023. jaanuarist
    SELECT
        DATE_TRUNC('month', sale_date)::date AS kuu,
        SUM(total_price) AS kogukaive,
        COUNT(*) AS tehingute_arv
    FROM sales
    WHERE sale_date >= '2023-01-01'
    GROUP BY DATE_TRUNC('month', sale_date)::date
)
SELECT 
    k.kuu,
    COALESCE(m.kogukaive, 0) AS kogukaive,
    COALESCE(m.tehingute_arv, 0) AS tehingute_arv
FROM koik_kuud k
LEFT JOIN kuude_myyk m ON k.kuu = m.kuu
WHERE m.kogukaive IS NULL -- Kuvab AINULT need kuud, kus müüki ei toimunud
ORDER BY k.kuu;
--tulemus sama, 9 kuul ei olnud müüke. 

-- müügid alates 2023 jaanuarist, käive alates suuremast väiksemani
SELECT
    DATE_TRUNC('month', sale_date) AS kuu,
    SUM(total_price) AS kogukäive
FROM sales
WHERE sale_date >= '2023-01-01'
GROUP BY DATE_TRUNC('month', sale_date)
ORDER BY kogukäive DESC;
-- tulemus 33 rida, alates 2023 jaanuar, käive alates suuremast väiksemani. jätkuvalt 2024 detsember kõige suurema müügiga 170K€


--Oluline erinevus: COUNT(*) vs COUNT(veerg):
-- COUNT(*) = 10118 (kõik read)
-- COUNT(notes) = 8500 (ainult need, kus notes EI OLE NULL) -- nt, näidisveerg
-- COUNT(DISTINCT customer_id) = 2551 (unikaalseid kliente)
--GROUP BY reegel
-- REEGEL: Kõik SELECT-is olevad veerud, mis EI OLE agregaatfunktsioonis, PEAVAD olema GROUP BY-s.

-- VALE! product_name pole GROUP BY-s ega agregeeritud
SELECT category, product_name, COUNT(*)
FROM products
GROUP BY category;  -- Viga: product_name puudub!

-- ÕIGE:
SELECT category, product_name, COUNT(*)
FROM products
GROUP BY category, product_name
--tulemus 350 rida, toodete count on 1-2x, See tähendab, et products tabelis on iga tootenimi kirjas peamiselt 1 kord (unikaalne toode) või mõnel üksikul juhul 2 korda (näiteks kui sama tootenime esineb topelt või erinevates kategooriates/variantides).

-- mitmel tootel on count 2
SELECT category, product_name, COUNT(*)
FROM products
GROUP BY category, product_name
having count(*) = 2
--tulemus 12 tootel on count 2, see tähendab, et 12 duplikaatset toodet on products tabelis. 

---- Müük kuude kaupa 2024. aastal
SELECT
    TO_CHAR(sale_date, 'YYYY-MM') AS kuu,
    COUNT(*) AS tellimusi,
    SUM(total_price) AS käive,
    ROUND(AVG(total_price), 2) AS keskmine_tellimus
FROM sales
WHERE sale_date >= '2024-01-01'
GROUP BY TO_CHAR(sale_date, 'YYYY-MM')
ORDER BY kuu;
--Tulemus 21 rida, ehk siis 21 kuul on toimunud müük

---- Müük kuude kaupa 2024. aastal, sama mis eelmine aga järjestus on teine. 
SELECT
    TO_CHAR(sale_date, 'YYYY-MM') AS kuu,
    COUNT(*) AS tellimusi,
    SUM(total_price) AS käive,
    ROUND(AVG(total_price), 2) AS keskmine_tellimus
FROM sales
WHERE sale_date >= '2024-01-01'
GROUP BY TO_CHAR(sale_date, 'YYYY-MM')
ORDER BY käive desc;
--Tulemus 21 rida, ehk siis 21 kuul on toimunud müük, 2024 detsember on kõige kasumlikum 170K€

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
--Ülesanne: Kirjuta ise päring, mis näitab müüki linnade kaupa.
--Vihjed:
--	Ühenda customers ja sales tabelid (JOIN ... ON customer_id)
-- Grupeeri city veeru järgi
-- Näita: linn, tellimuste arv, kogukäive, keskmine tellimus
-- Sorteeri kogukäive järgi kahanevalt
select 
c.city,         --siin ei ole vaja valida customer_id, sest seda pole ülesande püstituses küsitud, customer_id on ainult nö sild kahe tabeli vahel
sum(s.total_price),
count(*),
avg(s.total_price)
from customers c
left join sales s on c.customer_id = s.customer_id
group by c.city   
order by sum(s.total_price) desc
--Tulemus Minu variant (LEFT JOIN + COUNT(*)) oli samuti loogiline ja analüütiliselt õige lähenemine, mis näitas kõiki kliente, kaasa arvatud neid, kes pole midagi ostnud (tühjad read).
-- kõige rohkem tellimusi oli tallinnast 3832, kogusummas üle 1mil€, keskmise tellimuse suurus 279€. Tartu 1897 telli ja 296€, kogukäive 523K€

--sama asi mis eelmine lihtsalt ilusamate veerunimedega
select 
c.city as linn,         --siin ei ole vaja valida customer_id, sest seda pole ülesande püstituses küsitud, customer_id on ainult nö sild kahe tabeli vahel
sum(s.total_price) as kogukäive,
count(*) as tellimuste_arv,
round (avg(s.total_price), 2) as keskmine_tellimus
from customers c
left join sales s on c.customer_id = s.customer_id
group by c.city   
order by kogukäive desc
--Tulemus Minu variant (LEFT JOIN + COUNT(*)) oli samuti loogiline ja analüütiliselt õige lähenemine, mis näitas kõiki kliente, kaasa arvatud neid, kes pole midagi ostnud (tühjad read).
-- kõige rohkem tellimusi oli tallinnast 3832, kogusummas üle 1mil€, keskmise tellimuse suurus 279€. Tartu 1897 telli ja 296€, kogukäive 523K€

--sama minu päring, kus tuli sama vastus nagu õpikus. 
SELECT 
    c.city AS linn,
    COUNT(s.sale_id) AS tellimuste_arv,
    round (SUM(s.total_price),0) AS kogukäive,
    round (AVG(s.total_price),2) AS keskmine_tellimus
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.city
ORDER BY kogukäive DESC;
--Kõige rohkem tellimusi Tallinnas 3601, käive üle 1mil€, kesk tellimus 279€, Tartu tellimuste arv 1764, käive 523K€ ja keskmine tellimuse suurus 296€

--õpikust vastus, ja see on tegelikult õigem, sest ei arvesta sisse kliente kes pole tellinud.  
SELECT
    c.city AS linn,
    COUNT(s.sale_id) AS tellimuste_arv,
    SUM(s.total_price) AS kogukaive,
    ROUND(AVG(s.total_price), 2) AS keskmine_tellimus
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.city
ORDER BY kogukaive DESC;
--Tulemus Õpiku variant (JOIN + COUNT(sale_id)) vastab kitsamale stsenaariumile: see loendab ainult reaalseid sooritatud tehinguid ja jätab ostuta kliendid üldse arvestusest välja.
--Kõige rohkem tellimusi Tallinnas 3601, käive üle 1mil€, kesk tellimus 279€, Tartu tellimuste arv 1764, käive 523K€ ja keskmine tellimuse suurus 296€

select * from products, sales, customers limit 1

--	Müük nädalapäevade kaupa (millal ostetakse enim?)
SELECT 
    TO_CHAR(s.sale_date, 'Day') AS nädalapaev,
    COUNT(s.sale_id) AS tellimuste_arv,
    ROUND(SUM(s.total_price), 2) AS kogukäive
FROM sales s
GROUP BY TO_CHAR(s.sale_date, 'Day'), EXTRACT(DOW FROM s.sale_date)
ORDER BY kogukäive DESC;
--pühapäeviti ostetakse kõige rohkem 1444 tellimust, kogukäive 437K€

-- Toodete arv kategooriate kaupa
SELECT 
    category,
    COUNT(product_id) AS toodete_arv
FROM products
GROUP BY category;
--Tulemus jalanõud 73, lasteriided 70, aksessuaarid 67, naisteriided 70, meeste riided 82
    
--Samm 2: WHERE — ridade filtreerimine
--WHERE filtreerib üksikuid ridu ENNE grupeerimist:
-- WHERE: ainult 2024. aasta tellimused
SELECT 
    DATE_TRUNC('month', sale_date) AS kuu,
    SUM(total_price) AS käive
FROM sales
WHERE sale_date >= '2024-01-01' AND sale_date < '2025-01-01'
GROUP BY DATE_TRUNC('month', sale_date)
ORDER BY kuu;
--Tulemus suurim kuu 170K€ 2024 detsember ja väikseim kuu 85k€ jaanuar. 

--3: HAVING — gruppide filtreerimine
-- HAVING filtreerib gruppe PÄRAST grupeerimist. HAVING-us saab kasutada agregaatfunktsioone:
-- HAVING: ainult linnad, kus tellimusi > 10
SELECT
    c.city AS linn,
    COUNT(s.sale_id) AS tellimusi,
    SUM(s.total_price) AS kogukäive
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
WHERE s.sale_date >= '2024-01-01'     -- WHERE: filtreer read
GROUP BY c.city
HAVING COUNT(s.sale_id) > 10          -- HAVING: filtreer gruppe
ORDER BY kogukäive DESC;
--Tulemus 12 linna, kus kohast on tehtud vähemalt 10 tellimust 2024 aasta jooksul, Tallinnas näitab 2062 tellimust 2024 aastal. 

--: Otsustuspuu
--Küsimus	Kasuta
--Filtreerin üksikute ridade väärtuste järgi?	WHERE
--Filtreerin grupeeritud tulemuste (summa, keskmine jne) järgi?	HAVING
--Filtreerin kuupäeva, staatuse või muu rea-taseme väärtuse järgi?	WHERE
--Filtreerin "ainult kliendid, kes on ostnud üle 500€"?	HAVING (sest "ostnud üle 500€" on SUM)

--leia kliendid, kes on ostnud üle 500€:
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS nimi,
    COUNT(s.sale_id) AS tellimuste_arv,
    SUM(s.total_price) AS kogukäive
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(s.total_price) > 500
ORDER BY kogukäive desc
--Tulemus 1722 klienti on ostnud vähemalt üle 500€ eest kokku.Suurimad kliendid käibe järgi Tiina Pärn, Priit Rand, Kevin Org

--Ülesanne: Liis Koppel helistas, sest Tartu poe varudes on erinevused. Kirjuta päring, mis leiab tooted, kus kategoorias on müüdud üle [vali ise piir] ühiku.
SELECT
    p.category AS kategooria,
    SUM(s.quantity) AS müüdud_kokku,
    ROUND(AVG(p.retail_price), 2) AS keskmine_hind,
    COUNT(DISTINCT p.product_id) AS toodete_arv
FROM products p
JOIN sales s ON p.product_id = s.product_id
GROUP BY p.category
HAVING SUM(s.quantity) > 100
ORDER BY müüdud_kokku DESC;
--Miks HAVING ja mitte WHERE:
--Me tahame filtreerida GRUPPE (kategooriaid), mitte üksikuid ridu
--SUM(s.quantity) > 50 on agregaatfunktsioon — seda SAAB kasutada ainult HAVING-us
-- WHERE-s SUM() kasutamine annaks vea!

--kui palju on üldse tooteid kokku müüdud tükiliselt
SELECT 
    SUM(s.quantity) AS muudud_tooted_kokku_tk
FROM products p
JOIN sales s ON p.product_id = s.product_id;
--kokku müüdud kõiki tooteid kokku 18379 tükki alates 2023 kuni 2026 august

--milline kategooria teeb kõige rohkem käivet
SELECT 
    p.category AS kategooria,
      SUM(s.quantity) AS müüdud_kokku_tk,
    TO_CHAR(ROUND(SUM(s.total_price), 0), 'FM999 G999 G999') AS kogukäive,
    ROUND(AVG(p.retail_price), 2) AS keskmine_hind,
    COUNT(DISTINCT p.product_id) AS toodete_arv
FROM products p
JOIN sales s ON p.product_id = s.product_id
GROUP BY p.category
ORDER BY SUM(s.total_price) DESC;
--jalanõud on kõige suurem kategooria

--Harjutus 3B: Kliendianalüüs CTE-ga
--CTE-põhine päring, mis segmenteerib kliendid VIP / Aktiivne / Tavaline tasemetesse.
WITH kliendi_kokkuvote AS (
    SELECT
        c.customer_id,
        c.first_name || ' ' || c.last_name AS nimi,
        c.city,
        COUNT(s.sale_id) AS tellimuste_arv,
        SUM(s.total_price) AS kogukaive
    FROM customers c
    JOIN sales s ON c.customer_id = s.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name, c.city
),
segmendid AS (
    SELECT
        nimi, city, tellimuste_arv, kogukaive,
        CASE
            WHEN kogukaive > 1000 THEN 'VIP'
            WHEN kogukaive > 500 THEN 'Aktiivne'
            ELSE 'Tavaline'
        END AS segment
    FROM kliendi_kokkuvote
)
SELECT segment, COUNT(*) AS kliente, ROUND(AVG(kogukaive), 2) AS keskmine_kaive
FROM segmendid
GROUP BY segment
ORDER BY keskmine_kaive DESC;

--Harjutus 3C: Rakendus — Window Function (15 min)
--Ülesanne: Kasuta ROW_NUMBER() funktsiooni, et leida iga kategooria TOP 3 toodet müüdud koguse järgi.
WITH toote_müük AS (
    SELECT
        p.category,
        p.product_name,
        SUM(s.quantity) AS müüdud_kogus,
        ROW_NUMBER() OVER (
            PARTITION BY p.category
            ORDER BY SUM(s.quantity) DESC
        ) AS koht
    FROM products p
    JOIN sales s ON p.product_id = s.product_id
    GROUP BY p.category, p.product_name
)
SELECT category, product_name, müüdud_kogus, koht
FROM toote_müük
WHERE koht <= 3
ORDER BY category, koht;
--Tulemus 15 rida

---- 1. Müügitrendid — Kuidas käive kuude lõikes muutub?
WITH kuumüük AS (
SELECT
DATE_TRUNC('month', sale_date) AS kuu,
SUM(total_price) AS kuukaive
FROM sales
GROUP BY DATE_TRUNC('month', sale_date)
)
SELECT
kuu,
kuukaive,
LAG(kuukaive) OVER (ORDER BY kuu) AS eelmine_kuu_kaive,
kuukaive - LAG(kuukaive) OVER (ORDER BY kuu) AS muutus
FROM kuumüük
ORDER BY kuu;

-- Tulemus: Müük algab 2023. aasta jaanuaris käibega 79 735.03 €. Suurimad tõusud olid 2023. aasta juunis (+30 221.25 €, käive 125 537.50 €) ja detsembris (+30 008.07 €, käive 129 104.59 €). Suurim kukkumine toimus 2024. aasta jaanuaris (-43 485.94 €), mis viitab selgele hooajalisusele pärast aastalõpu müügibuum.

-- 2. TOP toodete analüüs — Mis müüb kõige paremini?
SELECT
p.product_name,
SUM(s.quantity) AS myydud_kokku,
SUM(s.total_price) AS kogukaive
FROM products p
JOIN sales s ON p.product_id = s.product_id
GROUP BY p.product_name
ORDER BY kogukaive DESC
LIMIT 5;
-- Tulemus: Suurima käibega toode on "Õhuline sünteetiline sporditossud" (27 347.04 €, müüdi 63 tk). Tükimüügilt on edukaim "Boheemlaslik puuvillane tuulejope" (71 tk, käive 21 309.96 €). Esiviisiku toodete kogukäive on ühtlaselt kõrge, vahemikus 21,3k kuni 27,3k eurot.

-- 3. Geograafiline ülevaade — Millistes linnades on parimad tulemused?

SELECT
c.city AS linn,
COUNT(s.sale_id) AS tellimusi,
SUM(s.total_price) AS kogukaive
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.city
HAVING COUNT(s.sale_id) > 10
ORDER BY kogukaive DESC;
-- Tulemus: Müügi absoluutne liider on Tallinn, ületades 1 miljoni euro piiri (1 006 252.88 € ja 3 601 tellimust). Teisel kohal on Tartu (523 286.64 €) ja kolmandal Pärnu (374 005.86 €). Esikolmik moodustab valdava enamuse kogukäibest, samal ajal kui tabeli lõpus olevad linnad nagu Paide teevad umbes 53k eurot käivet.


-- 4. Kliendianalüüs — Kes on meie VIP kliendid?
WITH kliendi_kogused AS (
SELECT
c.customer_id,
c.first_name,
c.last_name,
round (SUM(s.total_price), 0) AS kogukaive
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT
first_name,
last_name,
kogukaive,
CASE
WHEN kogukaive > 1000 THEN 'VIP'
ELSE 'Tavaklient'
END AS kliendi_staatus
FROM kliendi_kogused
ORDER BY kogukaive DESC
limit 15
-- Tulemus: Meie TOP klient on Tiina Pärn, kelle ostude kogukäive on muljetandvad 27 668.02 €. Esimesed kliendid ületavad 20 000 euro piiri (näiteks Priit Rand 26 286.10 € ja Kevin Org 23 467.13 €), mis näitab, et VIP-segment panustab ettevõtte tuludesse väga tugevalt


-- 5. Varude audit — Kus on erinevused?
WITH toote_müük AS (
SELECT
product_id,
SUM(quantity) AS kokku_myydud
FROM sales
GROUP BY product_id
)
SELECT
p.product_id,
p.product_name,
p.cost_price,
p.retail_price,
COALESCE(tm.kokku_myydud, 0) AS kokku_myydud
FROM products p
LEFT JOIN toote_müük tm ON p.product_id = tm.product_id
ORDER BY kokku_myydud DESC;
-- Tulemus: Kõige suurema läbimüügiga toode tükkide arvestuses on "Moodne seemisnahkne oxfordid" (83 tk, ostuhind 149.36 € ja müügihind 221.42 €). Tihedalt järgnevad "Minimalistlik villane pühapäevakleit" (81 tk) ja "Luksuslik softshell komplekt" (80 tk). Andmebaasis on kokku 362 toodet, mis annab hea ülevaate toodete liikumiskiirusest ja marginaalidest.

--Top 15 Toodete marginaalid
WITH toote_myyk AS (
    SELECT 
        product_id,
        SUM(quantity) AS kokku_myydud
    FROM sales
    GROUP BY product_id
)
SELECT 
    p.product_id,
    p.product_name,
    p.cost_price,
    p.retail_price,
    COALESCE(tm.kokku_myydud, 0) AS kokku_myydud,
    ROUND(COALESCE(tm.kokku_myydud, 0) * (p.retail_price - p.cost_price), 2) AS kogumarginaal
FROM products p
LEFT JOIN toote_myyk tm ON p.product_id = tm.product_id
ORDER BY kogumarginaal DESC limit 15
--Tulemus õhuline sünsteetiline tossud, seejärel goretex oxfordid ja kolmandaks kõrge kontsaga kingad

--Kirjuta üks CTE-põhine päring, mis annab Kristile ülevaate TOP 5 linnast koos igakuise trendiga.
WITH linna_myyk AS (
    -- CTE 1: iga linna kogumüük ja kuupõhiste andmete ettevalmistus
    SELECT 
        c.city AS linn,
        COUNT(DISTINCT s.sale_id) AS tellimusi,
        SUM(s.total_price) AS kogukaive,
        ROUND(AVG(s.total_price), 2) AS keskmine_tellimus,
        -- Viimase kuu (2024 mai) käive
        SUM(CASE WHEN DATE_TRUNC('month', s.sale_date) = '2024-05-01' THEN s.total_price ELSE 0 END) AS viimase_kuu_kaive,
        -- Varasemate kuude (2024 jan - apr, kokku 4 kuud) käive
        SUM(CASE WHEN DATE_TRUNC('month', s.sale_date) < '2024-05-01' THEN s.total_price ELSE 0 END) AS varasemate_kuude_kaive
    FROM customers c
    JOIN sales s ON c.customer_id = s.customer_id
    WHERE s.sale_date >= '2024-01-01'
    GROUP BY c.city
    HAVING COUNT(DISTINCT s.sale_id) > 5
),
linna_jarjestus AS (
    -- CTE 2: edetabeli koht, osakaal kogukäibest ja kuude keskmise võrdlus
    SELECT 
        linn,
        tellimusi,
        kogukaive,
        keskmine_tellimus,
        ROW_NUMBER() OVER (ORDER BY kogukaive DESC) AS koht,
        -- Linna osakaal KOGU käibest (protsentides)
        ROUND((kogukaive / SUM(kogukaive) OVER ()) * 100, 2) AS osakaal_pct,
        -- Viimase kuu käive
        ROUND(viimase_kuu_kaive, 2) AS viimase_kuu_kaive,
        -- Varasemate kuude keskmine (jagatud 4 kuuga: jaanuar–aprill)
        ROUND(varasemate_kuude_kaive / 4.0, 2) AS varasemate_kuude_keskmine
    FROM linna_myyk
)
SELECT 
    koht,
    linn,
    tellimusi,
    kogukaive,
    keskmine_tellimus,
    osakaal_pct,
    viimase_kuu_kaive,
    varasemate_kuude_keskmine,
    ROUND(viimase_kuu_kaive - (varasemate_kuude_keskmine), 2) AS kuu_muutus_eur
FROM linna_jarjestus
WHERE koht <= 5
ORDER BY koht;
