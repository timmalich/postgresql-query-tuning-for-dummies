-- GOOD 0.5s:
select *
from sales outerSales
where exists(
              select true
              from sales innerSales
                       join users innerUsers on innerSales.users_id = innerUsers.id
              where innerUsers.surname like '%5%sur%'
                and innerSales.currency = 'dollar'
    )
  -- THIS LINE HAS BEEN MOVED TO THE OUTER WHERE CLAUSE
  and outerSales.selling_price > 10 and outerSales.selling_price < 50
  ----------------------------------------------------------------------
order by outerSales.id
limit 500;
