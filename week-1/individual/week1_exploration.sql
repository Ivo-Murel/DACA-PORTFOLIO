SELECT sale_id, sale_date, total_price
FROM sales
order by sale_date desc
LIMIT 20;

select category, subcategory
from products
where subcategory = 'kampsunid'

-- UrbanStyle näide: müügid üle 500 euro
SELECT sale_id, total_price
FROM sales
WHERE total_price > 500     -- kui on vastupidi märk category>, siis müügid alla 500€
ORDER BY total_price asc;

-- UrbanStyle näide: müügid üle 200 euro ja tellimus tehtud 2024
SELECT sale_id, total_price, sale_date
FROM sales
WHERE total_price > 200
  AND sale_date >= '2024-01-01'
  AND sale_date < '2025-01-01'
and channel = 'online'

-- Müügid vahemikus 100-500 eurot ja väiksemast suuremani
SELECT sale_id, total_price
FROM sales
WHERE total_price BETWEEN 100 AND 500
order by total_price asc;

-- Müügid Tallinna VÕI Tartu kauplustest
SELECT sale_id, total_price, channel
FROM sales
WHERE store_location IN ('Tallinn', 'Tartu');

-- Kliendid, kelle nimi algab "K"-ga
SELECT customer_id, first_name, last_name
FROM customers
WHERE first_name LIKE 'K%';

-- Suured müügid Tallinnast
SELECT sale_id, total_price, channel
FROM sales
WHERE total_price > 500 AND store_location = 'Tallinn';

-- Müügid, mis on kas väga suured VÕI väga väikesed
SELECT sale_id, total_price
FROM sales
WHERE total_price > 500 OR total_price < 10;

-- Selge järjekord sulgudega
SELECT sale_id, total_price, channel
FROM sales
WHERE (store_location = 'Tallinn' OR store_location = 'Tartu')
  AND total_price > 100;

-- Suured tellimused
SELECT sale_id, customer_id, total_price
FROM sales
WHERE total_price > 500
ORDER BY total_price DESC
LIMIT 10;

-- Kindla perioodi müügid
SELECT sale_id, sale_date, total_price
FROM sales
WHERE sale_date BETWEEN '2024-01-01' AND '2024-03-31'
ORDER BY sale_date;

-- Null väärtuste otsimine
SELECT sale_id, customer_id, total_price
FROM sales
WHERE customer_id IS NULL;

-- Mitu rida on tabelis kokku?
SELECT COUNT(*) AS ridade_arv
FROM sales;

-- Mitu rida omab customer_id väärtust (mitte NULL)?
SELECT COUNT(customer_id) AS klientidega_tellimused
FROM sales;

-- Mitu customer_id on NULL?
SELECT
    COUNT(*) AS kokku,
    COUNT(customer_id) AS klientidega,
    COUNT(*) - COUNT(customer_id) AS puuduvaid
FROM sales;

-- Samm B: Mitu unikaalset sale_id on?
SELECT COUNT(DISTINCT sale_id) FROM sales;     -- eelmisest tulemusest lahutan selle tulemuse ja saan unikaalsete duplikaatide arvu 5116

-- Tabeli üldpilt, ridu kokku, klientidega tellimusi, puuduvaid kliente ja unikaalseid kliente 
SELECT
    COUNT(*) AS ridade_arv,
    COUNT(customer_id) AS klientidega,
    COUNT(*) - COUNT(customer_id) AS puudub_klient,
    COUNT(DISTINCT customer_id) AS unikaalseid_kliente
FROM sales;

-- SELECT COUNT(*) AS kokku FROM sales;
SELECT COUNT(*) AS kokku FROM sales;

-- Leia unikaalsete sale_id-de arv:
SELECT COUNT(DISTINCT sale_id) AS unikaalseid FROM sales;

-- Kontrolli ka customers tabelit — kas seal on duplikaatseid e-maile?
SELECT
    COUNT(*) AS kokku,
    COUNT(DISTINCT email) AS unikaalseid_emaile,
    COUNT(*) - COUNT(DISTINCT email) AS duplikaatseid
FROM customers;

-- : Toomas tahab ka products tabeli kohta ülevaadet. Kirjuta ise päring, mis näitab: Toodete koguarv ●	Unikaalsete kategooriate arv ●	Puuduvate hindade arv
SELECT COUNT(*) AS toodete_koguarv
FROM products;     --362 toodet
SELECT COUNT(DISTINCT category) AS unikaalseid
from products  -- 5 kategooriat

-- puuduvad hinnad eelmise ülesande kohta. vastus on 0 
SELECT COUNT(*) AS puuduvaid_hindu
FROM products
WHERE retail_price IS NULL;




