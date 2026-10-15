select * from customers

-- Kustuta duplikaadid sales tabelist (sama loogika mis W2 sales_test peal)
DELETE FROM sales
WHERE id NOT IN (
    SELECT MIN(id)
    FROM sales
    GROUP BY sale_id
);

-- Paranda tuleviku kuupäevad
UPDATE sales
SET sale_date = CURRENT_DATE
WHERE sale_date > CURRENT_DATE;

-- Ühtlusta klientide linnanimed (muidu GROUP BY city näitab 50+ varianti 12 asemel)
UPDATE customers
SET city = INITCAP(TRIM(city))
WHERE city IS NOT NULL;

-- Kontrolli tulemusi
SELECT COUNT(*) AS sales_ridu FROM sales;           -- Oodatav: ~10 118
SELECT COUNT(DISTINCT city) AS linnu FROM customers; -- Oodatav: 12

--kui palju on kliente
select count (*) customer_id 
from customers
-- tulemus 3150

--Kui soovid korrektset ja arusaadavat koodi kokkuvõtte tegemiseks, on õigem kirjutada:
select count(*) as total_customers
from customers;
--Tulemus 3150

-- Või kui soovid kontrollida, mitmel kliendil on täidetud unikaalne ID (või et poleks tühju ridu):
select count(customer_id) as total_customers
from customers;
--Tulemus süsteemis on kokku 3150 kirjet, millest igalühel on ID olemas

--unikaalsete klientide arv
select count(distinct concat(first_name, ' ', last_name)) as unique_names_count
from customers;
--Tulemus 2386 unikaalset klienti, Kuna ridade koguarv (3150) on suurem kui unikaalsete nimede arv (2386), näitab see loogiline vastuolu andmetes dubleerimist. tabelis on sama nimega inimesi, kes esinevad mitmel erineval real (näiteks mitu kontot, testandmed või sisestusvead)

--Osa 1: INNER JOIN — Kokkulangevate Andmete Ühendamine

-- NB! NB! NB! NB! NB! NB! NB! NB! NB! NB! NB! NB! NB! NB! NB! NB! NB! NB! NB! NB! NB! NB! NB! NB! NB! NB! NB! NB! NB! NB! NB! NB! NB! NB!
--INNER JOIN ühendab kaks tabelit ja näitab AINULT neid ridu, kus ühendav veerg (key) sobib mõlemas tabelis.
SELECT
    c.first_name,   -- C.-tabeli lühend/alias (customers)- first_name CUSTOMERS tabelist. 
    c.last_name,
    c.city,
    s.sale_id,
    s.sale_date,    -- S. - sale_date SALES tabelist
    s.total_price
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
ORDER BY s.total_price DESC
LIMIT 30;
--Tulemus, kood näitab AINULT neid ridu millele on mõlemas tabelis mingi vaste olemas

---- ILMA aliaseta (pikk ja raskesti loetav):
SELECT customers.first_name, sales.total_price
FROM sales
INNER JOIN customers ON sales.customer_id = customers.customer_id
limit 5;

-- ALIASEGA (lühike ja selge):
SELECT c.first_name, s.total_price
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
limit 5;

-- INNER JOIN: kliendid koos nende müükidega
SELECT
    c.first_name,
    c.last_name,
    c.city,
    s.sale_id,
    s.sale_date,
    s.total_price
FROM sales s -- see käsklus määratleb edaspidiseks selle, et sales tabeli asemel kasutan S tähte 
INNER JOIN customers c ON s.customer_id = c.customer_id --siin samuti C määratleb selle, et edaspidi kasutan customer tabeli asemel C tähte
ORDER BY s.total_price DESC
LIMIT 20;
--Tulemus - Tabel 20 reaga, kus iga real on kliendi nimi, linn, müügi kuupäev ja summa.

-- INNER JOIN: kliendid koos nende müükidega, sama asi mis eelmine, aga ilma limitita, et ei vaata ainult 20 klienti. 
SELECT
    c.first_name,
    c.last_name,
    c.city,
    s.sale_id,
    s.sale_date,
    s.total_price
FROM sales s -- see käsklus määratleb edaspidiseks selle, et sales tabeli asemel kasutan S tähte 
INNER JOIN customers c ON s.customer_id = c.customer_id --siin samuti C määratleb selle, et edaspidi kasutan customer tabeli asemel C tähte
ORDER BY s.total_price DESC
-- Limit eemdaldamisega tuleb 9130 rida. 

select * from sales, products

-- Kirjuta ise päring, mis ühendab sales ja products tabelid, et näha tootenimesid koos müüdud kogustega. ●	
-- Ühenda sales ja products tabelid (ON s.product_id = p.product_id)
-- Näita: toote nimi, kategooria, müüdud kogus (quantity), ühikuhind (unit_price)
-- Sorteeri koguse järgi kahanevalt
-- Piira 15 reaga
select 
    p.product_name,
    p.category,
    s.quantity,
    s.unit_price
from sales s
inner join products p ON s.product_id = p.product_id    --See ühendab sales ja products tabelid toote ID (product_id) alusel, et kuvada iga müügi juures õiged toote andmed.
order by s.quantity desc    --	ORDER BY DESC näitab esmalt enim müüdud toodet
limit 15;
--tuli välja küll
-- tabelisse tuleb 15 toodet, igaüks on 5tk neist müünud. 

-- sama asi mis eelmine ja see oli vastuse all, õige oleks
SELECT
    p.product_name AS toode,       -- AS käsklus muudab veeru nime eestikeelseks
    p.category AS kategooria,
    s.quantity AS kogus,
    s.unit_price AS ühikuhind
FROM sales s
INNER JOIN products p ON s.product_id = p.product_id     --See ühendab sales ja products tabelid toote ID (product_id) alusel, et kuvada iga müügi juures õiged toote andmed.
ORDER BY s.quantity DESC         --	ORDER BY DESC näitab esmalt enim müüdud toodet
LIMIT 15;
-- tulemus, veeru nimed muudetakse samuti eestikeelseks

--Milline on kalleim toode
SELECT 
    product_name,
    category,
    retail_price
FROM products
ORDER BY retail_price DESC
LIMIT 1
--tulemuseks annab Õhuline sünteetiline sporditossud 434,08€
--teine kood
select 
    p.product_name,
    p.category,
    s.unit_price
from sales s
inner join products p on s.product_id = p.product_id
order by s.unit_price desc
limit 1;
--Tulemuseks annab Klassikaline seemisnahkne jooksutossud, hinnaga 512,37€
-- Tõenäoliselt on sales tabelis salvestatud hind (või allahindlused/ajaloolised hinnamuutused) teistsugused kui toote praegune baashind (retail_price) toodete kataloogis. See on andmebaasides täiesti normaalne, et kataloogihind ja tegelik müügihind võivad erineda.

--	Milliste toodete tellimustes on kõrgeim ühikuhind?
SELECT 
    s.sale_id,
    s.invoice_id,
    p.product_name,
    s.unit_price,
    s.quantity,
    s.total_price
FROM sales s
INNER JOIN products p ON s.product_id = p.product_id
ORDER BY s.unit_price DESC
LIMIT 10;
--Tulemus Klassikaline seemisnahkne jooksutossud on kõige kallimad 512.37€

--Osa 2: LEFT JOIN — Kõigi Andmete Säilitamine
------------------------------------------------------------------------
------------------------------------------------------------------------
select * from customers, sales
limit 1
--LEFT JOIN süntaks
SELECT
    veerg1,
    veerg2
FROM vasak_tabel
LEFT JOIN parem_tabel ON vasak_tabel.key = parem_tabel.key;

SELECT
    first_name, 
    last_name
    FROM customers
LEFT JOIN sales ON customers.customer_id = sales.customer_id;

--kõik kliendid, ka need kes pole ostnud
SELECT
    c.first_name,
    c.last_name,
    c.city,
    s.sale_id,
    s.total_price
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id
ORDER BY s.total_price DESC NULLS LAST
-- Tulemus 9729 klienti

--kõik kliendid, kes ei ole midagi ostnud, sale_id on null
SELECT
    c.first_name,
    c.last_name,
    c.city,
    s.sale_id,
    s.total_price
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id
Where sale_id is null
ORDER BY s.total_price DESC NULLS LAST
-- Tulemus 599 klienti

-- Kliendid, kes pole KUNAGI ostnud, sama kood, aga materjalidest, minu koodis oli order by samuti sees, seda pole vaja. 
SELECT
    c.first_name,
    c.last_name,
    c.email,
    c.city,
    c.registration_date
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id
WHERE s.sale_id IS NULL;
--Tulemus 599

--leia kliendid, kes pole kunagi ostnud:
-- Kadunud kliendid: LEFT JOIN + WHERE IS NULL
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS nimi,
    c.email,
    c.city,
    c.registration_date
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id
WHERE s.sale_id IS NULL
ORDER BY c.registration_date DESC;
--Tulemus 599 klienti, osadel email on puudu, väärtus on NULL

--	Millisest linnast on enim kadunud kliente?
SELECT 
    c.city,
    COUNT(c.customer_id) AS inactive_count
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id
WHERE s.sale_id IS NULL
GROUP BY c.city
ORDER BY inactive_count DESC;
--Tulemus Tallinn 231

--●	Millal registreerus kõige vanem kadunud klient? 
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.city,
    c.registration_date
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id
WHERE s.sale_id IS NULL
ORDER BY c.registration_date ASC
LIMIT 1;
--Tulemus Erkki Ilves, Tartu 2020-01-02, customer_id 2571

-- Võrdluseks: INNER JOIN (ainult aktiivsed kliendid)
SELECT COUNT(DISTINCT c.customer_id) AS aktiivseid_kliente
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id;
--Tulemus 2551 klienti

--Kui palju on mitteaktiivseid kliente
SELECT 
    COUNT(c.customer_id) AS inactive_customers_count
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id
WHERE s.sale_id IS NULL;
--Tulemus 599 mitteaktiivset klienti

--Anna küsib: "Millised tooted on meie kataloogis, aga neid pole kunagi müüdud? Need võtavad laoruumi ja seovad raha!" Kirjuta ise päring, mis leiab müümata tooted.
SELECT 
    p.product_name,
    p.category,
    p.retail_price
FROM products p
LEFT JOIN sales s ON p.product_id = s.product_id
WHERE s.sale_id IS NULL;
--tulemus 12 toodet

--kadunud klientide analüüs (5 min)
-- Ülesanne: Anna tahab teada rohkem kadunud klientide kohta. Kirjuta päring, mis grupeerib kadunud kliendid linnade kaupa ja näitab, mitu kadunud klienti on igas linnas.
SELECT 
    c.city,
    COUNT(c.customer_id) AS inactive_count
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id
WHERE s.sale_id IS NULL
GROUP BY c.city
ORDER BY inactive_count DESC;

----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
--Osa 3: RIGHT JOIN ja Mitme Tabeli Ühendamine
--RIGHT JOIN ja mitme tabeli JOIN 
-- LEFT JOIN (kõik kliendid):
SELECT c.first_name, s.sale_id
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id;

-- RIGHT JOIN (sama tulemus, aga tabelid vastupidi):
SELECT c.first_name, s.sale_id
FROM sales s
RIGHT JOIN customers c ON s.customer_id = c.customer_id;
--Praktikas kasutatakse RIGHT JOIN-i harva. Enamik analüütikuid kirjutab LEFT JOIN-i ja paigutab tabelid õiges järjekorras. Aga sa pead teadma, et RIGHT JOIN eksisteerib — mõnikord on ta vajalik."
--Millal RIGHT JOIN on kasulik:
--Kui sa liitusid keeruka päringuga ja pead lisama andmeid paremalt poolt
--Päringute loogika pööramisel (harv)

--Mitme tabeli ühendamine (3+ tabelit)
SELECT
    c.first_name || ' ' || c.last_name AS klient,
    c.city,
    s.sale_date,
    s.total_price,
    p.product_name,
    p.category,
    s.quantity,
    s.unit_price
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
INNER JOIN products p ON s.product_id = p.product_id
ORDER BY s.total_price DESC
LIMIT 20;
--Samm 1: sales ←JOIN→ customers
--         (lisab kliendi nime ja linna)
--Samm 2: tulemus ←JOIN→ products
  --       (lisab toote nime ja kategooria)
--Lõpptulemus: klient + müük + toode + kogus

--Hea tava: Alusta "keskelt" (põhitabel) ja lisa teisi tabeleid loogilises järjestuses.
-- Selge struktuur — igale JOIN-ile oma rida:
select * FROM sales s                                            -- Põhitabel
INNER JOIN customers c ON s.customer_id = c.customer_id -- + klient
INNER JOIN products p ON s.product_id = p.product_id    -- + tooteinfo
--See võtab aluseks sales tabeli ja liidab sellele INNER JOIN-iga külge nii customers kui ka products tabeli andmed.

-- 3 tabeli JOIN: kes ostis mida?
SELECT
    c.first_name || ' ' || c.last_name AS klient,
    c.city AS linn,
    s.sale_date AS müügi_kuupäev,
    p.product_name AS toode,
    p.category AS kategooria,
    s.quantity AS kogus,
    s.unit_price AS ühikuhind,
    s.total_price AS rea_summa
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
INNER JOIN products p ON s.product_id = p.product_id
ORDER BY rea_summa DESC
LIMIT 20;
--Tulemus kliendi nimi, asukoht, kuupäev ja mida nad ostsid, kogused samuti, tükihind ja mis oli tellimuse summa kokku, kahanevas järjekorrast. TOP kliendid Madis Roots, Laura Tammik ja Kati Teder. 

--Anna tahab teada: "Millised tootekategooriad müüvad igas linnas kõige rohkem?" Kirjuta ise päring, mis ühendab 3+ tabelit ja grupeerib tulemused.
--Minu tehtud
select
c.city,
p.category,
count(s.sale_id),
sum(s.total_price) 
from sales s
inner join customers c on s.customer_id = c.customer_id
inner join products p on s.product_id = p.product_id
group by c.city, p.category
order by sum(s.total_price) desc
--sama kood ülesande vastusest
SELECT
    c.city AS linn,                 --siin siis vahe selles, et nimetab ümber ka veerud
    p.category AS kategooria,       --siin siis vahe selles, et nimetab ümber ka veerud
    COUNT(s.sale_id) AS müüke,      --siin siis vahe selles, et nimetab ümber ka veerud
    SUM(s.total_price) AS kogumuuk
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
INNER JOIN products p ON s.product_id = p.product_id
GROUP BY c.city, p.category
ORDER BY kogumuuk DESC;
--Tulemus TLN jalanõud 774 paari on enimüüdud käibe ja kategooria poolest, teiseks TLN meeste riided 792 paari, käive väiksem. 

select * from inventory

--------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------

--TOP 20 klienti koos tootekategooriatega
--Ühenda sales, customers ja products. Grupeeri kliendi ja kategooria kaupa. Näita: klient, linn, kategooria, kogumüük.
-- Sinu päring (vihje: kasuta 4 tabelit):
SELECT 
    c.first_name || ' ' || c.last_name AS klient,
    c.city AS linn,
    p.category AS kategooria,
    SUM(s.total_price) AS kogumüük
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
INNER JOIN products p ON s.product_id = p.product_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.city, p.category
ORDER BY kogumüük DESC
LIMIT 20
--Tulemus, algselt kasutasin küll 4 tabelit, aga inventory oma ei olnudki vaja, seega tulemus sama, mis ka alumisel tabelil 

--lahendus õppematerjalidest, aga siin on ikkagi tehtud ainult 3 tabeli järgi, seega ülesande püstitus oli eksitav
SELECT
    c.first_name || ' ' || c.last_name AS klient,
    c.city AS linn,
    p.category AS kategooria,
    SUM(s.total_price) AS kogumuuk
FROM sales s
INNER JOIN customers c ON s.customer_id = c.customer_id
INNER JOIN products p ON s.product_id = p.product_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.city, p.category
ORDER BY kogumuuk DESC
LIMIT 20;


--Päring 2: Kadunud kliendid linnade kaupa
-- Kasuta LEFT JOIN mustrit, et leida kadunud kliendid, ja grupeeri linnade kaupa.
SELECT 
    c.city,
    COUNT(c.customer_id) AS lost_customers
FROM customers c
LEFT JOIN sales s ON c.customer_id = s.customer_id
WHERE s.sale_id IS NULL
GROUP BY c.city
ORDER BY lost_customers DESC;

--Päring 3: Müümata tooted kategooriate kaupa
--Leia tooted, mida pole kunagi müüdud, ja grupeeri kategooria kaupa.
SELECT 
    p.category,
    COUNT(p.product_id) AS unsold_products_count
FROM products p
LEFT JOIN sales s ON p.product_id = s.product_id
WHERE s.sale_id IS NULL
GROUP BY p.category
ORDER BY unsold_products_count DESC;

--lahendus õppematerjalidest
SELECT
    p.category AS kategooria,
    COUNT(*) AS müümata_tooteid,
    ROUND(AVG(p.retail_price), 2) AS keskmine_hind
FROM products p
LEFT JOIN sales s ON p.product_id = s.product_id
WHERE s.sale_id IS NULL
GROUP BY p.category
ORDER BY müümata_tooteid DESC;


--Päring 4 Linnade ülevaade — Kust tulevad parimad kliendid? → JOIN + GROUP BY
SELECT 
    c.city,
    COUNT(DISTINCT c.customer_id) AS active_customers,
    COUNT(s.sale_id) AS total_orders,
    SUM(s.total_price) AS total_revenue,
    ROUND(AVG(s.total_price), 2) AS avg_order_value
FROM customers c
INNER JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.city
ORDER BY total_revenue DESC;
