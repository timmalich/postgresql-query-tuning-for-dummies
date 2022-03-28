-- BAD:
select *
from sales
where id = 10000
   or id = 10001
   or id = 10002
   or id = 10003;

-- GOOD:
select *
from sales
where id in (10000, 10001, 10002, 100003);


---------------------- NOTE -----------------------------
-- I tried hard to reproduce an evil or, but failed so far.
-- I've seen them a couple of times in real and more complex queries. They usually appeared when we needed an `or`
-- operation from a outer query within an exists clause. In some of those cases it was even faster to split the exists
-- query at the `or` operation. However, I was not able to reproduce these with this dummy database.
--
-- I'll keep the example anyway, because the general message is: if you see a wild `or` be careful and take a closer look, it could be evil!
---------------------------------------------------------
-- BAD:
select distinct outerUsers.*
from sales outerSales
         join users outerUsers on outerSales.users_id = outerUsers.id
         join products outerProducts on outerSales.products_id = outerProducts.id
         join shops outerShops on outerShops.id = outerSales.shops_id
where exists(
              select innerUsers.id
              from users innerUsers
                       join sales innerSales on innerUsers.id = innerSales.users_id
                       join products innerProducts on innerSales.products_id = innerProducts.id
                       join shops innerShops on innerSales.shops_id = innerShops.id
              where innerProducts.cost > 1000
                 and (
                     ---------------- THIS IS THE EVIL OR -----------------------------
                     outerUsers.givenname like '%12%' or outerUsers.surname like '%12%'
                     ------------------------------------------------------------------
                     )
          )
;
