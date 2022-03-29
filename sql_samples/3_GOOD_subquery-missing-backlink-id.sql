



-- GOOD 0.9s
select *
from sales outerSales
         join products outerProducts on outerSales.products_id = outerProducts.id
         join users outerUsers on outerSales.users_id = outerUsers.id
where outerUsers.uid_upper = '53757_5UID'
  and exists(
        select true
        from sales innerSales
                 join users innerUsers on innerSales.users_id = innerUsers.id
        where outerSales.payed = innerSales.payed -- outerSales is connected with innerSales, but not over the id
          --- THIS IS THE IMPORTANT LINE! Add a backlink to the indexed id column
          and outerUsers.id = innerUsers.id
          ------------------------------------
          -- a backlink with sales table would work as well (or can sometimes even be better), but it's unnecessary here
          and outerSales.id = innerSales.id
    )
order by outerSales.id
limit 500
;


-- Of course this is even faster and simpler but kills the comparison showcase of the backlink
/*
select *
from sales outerSales
         join products outerProducts on outerSales.products_id = outerProducts.id
         join users outerUsers on outerSales.users_id = outerUsers.id
where outerUsers.uid_upper = '53757_5UID'
order by outerSales.id;
*/
