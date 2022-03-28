-- BAD 8s:
select *
from sales outerSales
         join products outerProducts on outerSales.products_id = outerProducts.id
         join users outerUsers on outerSales.users_id = outerUsers.id
where outerUsers.uid_upper = '53757_5UID'
  and exists(
        select true
        from sales innerSales
                 join users innerUsers on innerSales.users_id = innerUsers.id
        where outerSales.payed = innerSales.payed
          --- THIS IS THE IMPORTANT LINE. UNCOMMENT TO MAKE THE QUERY FAST
          -- and outerUsers.id = innerUsers.id
          --------------------------------------
    )
order by outerSales.id
;

-- GOOD 0.7s
select *
from sales outerSales
         join products outerProducts on outerSales.products_id = outerProducts.id
         join users outerUsers on outerSales.users_id = outerUsers.id
where outerUsers.uid_upper = '53757_5UID'
  and exists(
        select true
        from sales innerSales
                 join users innerUsers on innerSales.users_id = innerUsers.id
        where outerSales.payed = innerSales.payed
          --- THIS IS THE IMPORTANT LINE!
          and outerUsers.id = innerUsers.id
          ------------------------------------
    )
order by outerSales.id;


-- Of course this is even faster and simpler but kills the comparison showcase of the backlink
select *
from sales outerSales
         join products outerProducts on outerSales.products_id = outerProducts.id
         join users outerUsers on outerSales.users_id = outerUsers.id
where outerUsers.uid_upper = '53757_5UID'
order by outerSales.id;
