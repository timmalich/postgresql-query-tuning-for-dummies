---------------------- NOTE -----------------------------
--
---------------------------------------------------------
-- BAD: With
select *
from sales
where id = 10000
   or id = 10001
   or id = 10002
   or id = 10003;

select *
from sales
where id in (10000, 10001, 10002, 100003);

select outerUsers.uid,
       outerUsers.givenname,
       outerUsers.surname,
       outerUsers.city,
       outerSales.selling_price,
       outerSales.payed
from sales outerSales
         join users outerUsers on outerSales.users_id = outerUsers.id
where users_id in (
    select innerUsers.id
    from users innerUsers
             join sales innerSales on innerUsers.id = innerSales.users_id
             join products innerProducts on innerSales.products_id = innerProducts.id
    where innerProducts.cost > 1000
      and innerSales.payed < innerSales.selling_price
      and outerUsers.id = outerSales.users_id
)
  and outerUsers.city = '10_city'
;

select distinct outerUsers.uid,
                outerUsers.givenname,
                outerUsers.surname,
                outerUsers.city,
                outerSales.selling_price,
                outerSales.payed,
                outerProducts.name,
                outerShops.country_code
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
                 or innerShops.country_code = 'DE'
          )
;

select outerUsers.uid,
                outerUsers.givenname,
                outerUsers.surname,
                outerUsers.city,
                outerSales.selling_price,
                outerSales.payed,
                outerProducts.name,
                outerShops.country_code
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
              where (innerProducts.cost > 1000
                  or innerShops.country_code = 'DE'
                        )
                and outerSales.id = innerSales.id -- it's this back link that makes it currently bad, not the OR
          )
and outerSales.payed < 100;
;

select outerUsers.uid,
       outerUsers.givenname,
       outerUsers.surname,
       outerUsers.city,
       outerSales.selling_price,
       outerSales.payed,
       outerProducts.name,
       outerShops.country_code
from sales outerSales
         join users outerUsers on outerSales.users_id = outerUsers.id
         join products outerProducts on outerSales.products_id = outerProducts.id
         join shops outerShops on outerShops.id = outerSales.shops_id
where (exists(
    select innerUsers.id
        from users innerUsers
                 join sales innerSales on innerUsers.id = innerSales.users_id
                 join products innerProducts on innerSales.products_id = innerProducts.id
        where innerProducts.cost > 1000
    )
  or
    exists(
            select innerUsers.id
            from users innerUsers
                     join sales innerSales on innerUsers.id = innerSales.users_id
                     join shops innerShops on innerSales.shops_id = innerShops.id
            where innerShops.country_code = 'DE'
        ))
  and outerUsers.uid = '23382_2uid';
;
