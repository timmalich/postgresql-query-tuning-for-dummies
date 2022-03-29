-------------------------------------------------------------------------------
------------------------- solution --------------------------------------------
-------------------------------------------------------------------------------
select sales.id,
       users_id,
       products_id,
       shops_id,
       selling_price,
       payed,
       currency,
       selling_date,
       last_payment,
       uid_upper,
       nickname,
       givenname,
       surname,
       email,
       mobile,
       allo_startdate,
       allo_enddate,
       state,
       city,
       street,
       postalcode,
       company,
       departmentnumber,
       description,
       initialpassword,
       roomnumber,
       sourceprocess
from sales
         join users u on sales.users_id = u.id
where sales.selling_date < now()                       -- simple parameter restriction on main table, this usually cannot be bad
  and sales.last_payment < (now() + interval '3' year) -- simple parameter restriction on main table, this usually cannot be bad
  and sales.payed > 100                                -- simple parameter restriction on main table, this usually cannot be bad
  and ( -- a rather complex looking clause, let's check what happens when we omit it
            u.allo_enddate > now() or (
                u.company in (
                '3741_comp'
                    '3743_comp'
                    '3749_comp'
                    '3755_comp'
                    '3760_comp'
                    '3761_comp'
                    '3770_comp'
                    '3772_comp'
                    '3772_comp'
                    '3786_comp'
                    '3786_comp'
                    '3789_comp'
                    '3789_comp'
                    '3793_comp'
                    '3793_comp'
                )
            and exists(select true from shops where country_code in ('DE', 'CN', 'US'))
        )
    ) -- still slow, this seems to be fine
  -- two rather strange looking exists clauses, let's check what happens when we omit both
  and exists(select true
             from products p
                      join sales s on p.id = s.products_id
             where s.products_id = p.id
               and p.cost > 1000
               and p.name not in ('evil_product', 'useless_product', 'foo_product')
    )
  and not exists(select true
                 from products p
                          join sales s on p.id = s.products_id
                 where s.products_id = p.id
                   and p.cost < 1000
                   and p.name in ('good_product', 'super_product', 'awesome_product')
    ) -- still slow, or even slower, let's keep them and go ahead
  -- what about this in? let's find out:
  and sales.users_id in (select iu.id
                         from users iu
                                  join sales s2 on iu.id = s2.users_id
                                  join products p2 on s2.products_id = p2.id
                         where p2.cost < 100
)
 -- still slow or even slower, let's keep it and go ahead
  and sales.users_id in ( -- if that's not the part that is producing error I am going to regret my life choices
    select innerUsers.id
    from users innerUsers
             join sales innerSales on innerUsers.id = innerSales.users_id
             join products innerProducts on innerSales.products_id = innerProducts.id
    where innerProducts.cost > 10
      and innerSales.payed < innerSales.selling_price
      and u.id = sales.users_id
) -- yeah that's seems to be pretty bad, let's try to rewrite it as exists
  and u.city = '68157_city'
;









/** copy and past backup of the critical query part in the "solution". just in case the brain get's a segfault during presentation.
 -- still slow or even slower, let's keep it and go ahead
  and exists ( -- if that's not the part that is producing error I am going to regret my life choices
    select innerUsers.id
    from users innerUsers
             join sales innerSales on innerUsers.id = innerSales.users_id
             join products innerProducts on innerSales.products_id = innerProducts.id
    where (innerProducts.cost > 10
        and innerSales.payed < innerSales.selling_price
        and u.id = sales.users_id
              ) and sales.users_id = innerUsers.id
) -- yeah that's seems to be pretty bad, let's try to rewrite it as exists
 */
