--* NOTE: The `evil in` in this example only applies for: where foo in (select ...).
--* `in` with a dedicated list (where foo in (1,2,3,4...)) is actually a pretty nice guy

-- BAD: With IN 47s
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
    where innerProducts.cost > 10
      and innerSales.payed < innerSales.selling_price
      and outerUsers.id = outerSales.users_id
)
  and outerUsers.city = '10_city'
;
