--* WARNING: ONLY USE THIS IN CASE THE `outer clause` should affect the inner result set.
--*    There are real world scenarios which are requiring that the inner select should not be affected by the outer restrictions

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
limit 500
;
