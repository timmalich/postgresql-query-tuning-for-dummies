--* this one is very surprising and I couldn't beliefe it until
--*     I tested it a couple of times on real queries: upper is faster than ilike?!
--*
--* WARNING THIS IS NOT TRUE IF THE COLUMN HAS A gin_trgm_ops INDEX,
--* IN FACT THE OPPOSITE IS THE CASE. FURTHERMORE IT HIGHLY DEPENDS ON THE DATABASE
--* Side note:
--*** The gin_trgm_ops is simply amazing!
--*** If you have text based search queries (e.g.: ... like '%A%B%'):
--*** START USING IT!!!
--*** It can simply be activated as superuser with `create extension pg_trgm with schema pg_catalog;`
--*** It can be created with: `create index my_trgm_idx on myschema.mytable using gin (mycolumn gin_trgm_ops)

-- GOOD 6s;
with shadow_table_only_for_ordering as (
    select 'users1' as _, count(*) from users where upper(uid) like upper('%1%ui%')
    union all
    select 'users2' as _, count(*) from users where upper(uid) like upper('%2%ui%')
    union all
    select 'users3' as _, count(*) from users where upper(nickname) like upper('%5%_nick%')
    union all
    select 'users4' as _, count(*) from users where upper(givenname) like upper('%7%_given%')
    union all
    select 'users5' as _,  count(*) from users where upper(surname) like upper('%8%_sure%')
    union all
    select 'users6' as _, count(*) from users where upper(email) like upper('%3%_email%')
    union all
    select 'users7' as _, count(*) from users where upper(city) like upper('%1%_city%')
    union all
    select 'users8' as _, count(*) from users where upper(street) like upper('%9%_street%')
    union all
    select 'users9' as _, count(*) from users where upper(company) like upper('%A%')
) select * from shadow_table_only_for_ordering order by _;
;
