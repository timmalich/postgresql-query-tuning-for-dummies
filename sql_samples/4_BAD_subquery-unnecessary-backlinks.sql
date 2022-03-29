-- in comparison to 3_GOOD_subquery-missing-backlink-id.sql this example shows,
-- that you should only filter for referenced columns.
-- In general: you should not filter for properties of the outer query in the exists clause

-- BAD 45s:
select *
from sales outerSales
where exists(
              select true
              from sales innerSales
                       join users innerUsers on innerSales.users_id = innerUsers.id
              where innerUsers.surname like '%5%sur%'
                and innerSales.currency = 'dollar'
                -- MOVE THIS LINE TO THE OUTER WHERE CLAUSE
                and outerSales.selling_price > 10 and outerSales.selling_price < 50
                --------------------------------------------
          )
order by outerSales.id
limit 500;
