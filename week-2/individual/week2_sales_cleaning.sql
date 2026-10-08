-- Loon müügiandmetest test tabeli
create table sales_test AS
select * from sales;

-- Loen kokku test_tabeli ridade arvu 
select count (*) from sales_test
--Tulemus 15234 rida

-- Vajadusel kasutan olemasoleva test_tabeli kustutamiseks, et seejärel luua uus.
Drop table sales_test;

ALTER TABLE sales_test ADD COLUMN IF NOT EXISTS id SERIAL;

--kontrolli ridade arvu
select count (*) as ridade_arv from sales_test;

select * from sales_test limit 10

select * from sales_test order by id desc limit 10;
select * from sales_test order by sale_date desc limit 10;

select * from sales_test order by sale_id desc limit 10;

-- kui selle raporti panen käima siis kustutab ära NB! kui valin SELECTIST alates, siis näen, mida täpselt kustutama hakkab, ehk siis delete jätan välja, siis saan kontrollida enne kustutamist, mis kustutatakse ära. 
delete select *
from sales_test
where sale_id >= 10100;

-- HARJUTUS
-- Samm 1: Leia duplikaadid 
SELECT invoice_id, COUNT(*) AS koopiate_arv
FROM sales_test
GROUP BY invoice_id
HAVING COUNT(*) > 1
ORDER BY koopiate_arv DESC
LIMIT 10;
--Tulemus - tuleb 10 rida, ja näitab mitu invoice_id koopiat on, seal on koopiate arv 5 või 6. näiteks 6 real on sama invoice_id.

-- Samm 2: Mitu rida on duplikaadid?
SELECT COUNT(*) AS duplikaat_read
FROM sales_test
WHERE id NOT IN (
    SELECT MIN(id)
    FROM sales_test
    GROUP BY invoice_id
);

-- 4256 INV-202312-00423 - see on minimaalne ID väärtus, seda rida ei tohiks ära kustutada. 
select * from sales_test
where invoice_id = 'INV-202312-00423'

-- Samm 3: Enne on vaja üles kirjutada vanad andmed!
SELECT COUNT(*) AS enne FROM sales_test;

--15234 rida kokku enne puhastamist
-- duplikaatridu 5116
-- Lõpuks peaks alles jääma 15234-5116 = 10118

-- Samm 4: Kustuta duplikaadid
DELETE 
FROM sales_test
WHERE id NOT IN (
    SELECT MIN(id)
    FROM sales_test
    GROUP BY invoice_id
);

-- Samm 5: Pärast — kontrolli - vastuseks peab tulema 10118 - kõik OK
SELECT COUNT(*) AS pärast FROM sales_test;

-- Samm 6: Kas duplikaate on veel?
SELECT invoice_id, COUNT(*)
FROM sales_test
GROUP BY invoice_id
HAVING COUNT(*) > 1;
-- Tulemus: 0 rida! Success no rows returned - kõik toimis. 

--siin nüüd siis kututan ära sales tabelist sama info
DELETE 
FROM sales
WHERE id NOT IN (
    SELECT MIN(id)
    FROM sales
    GROUP BY invoice_id
);

--kontrolli - vastuseks peab tulema 10118
SELECT COUNT(*) AS pärast FROM sales;
