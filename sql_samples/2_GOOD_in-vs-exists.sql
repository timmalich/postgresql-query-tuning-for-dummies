-- GOOD: 2s



select outerUsers.uid,
       outerUsers.givenname,
       outerUsers.surname,
       outerUsers.city,
       outerSales.selling_price,
       outerSales.payed
from sales outerSales
         join users outerUsers on outerSales.users_id = outerUsers.id
where exists(  -- this line was changed from in to exists
        select innerUsers.id
        from users innerUsers
                 join sales innerSales on innerUsers.id = innerSales.users_id
                 join products innerProducts on innerSales.products_id = innerProducts.id
        where (innerProducts.cost > 10
          and innerSales.payed < innerSales.selling_price
          and outerUsers.id = outerSales.users_id)
          and outerSales.users_id = innerSales.users_id -- and this backlink was added
    )
  and outerUsers.city = '10_city'
  limit 500
;

-- Of course this is even faster and simpler but kills the comparison showcase of in versus exists
/*
select users.uid,
       users.givenname,
       users.surname,
       users.city,
       sales.selling_price,
       sales.payed
from sales
         join users on sales.users_id = users.id
         join products on sales.products_id = products.id
where products.cost > 10
  and sales.payed < sales.selling_price
  and users.city = '10_city'
;
*/
