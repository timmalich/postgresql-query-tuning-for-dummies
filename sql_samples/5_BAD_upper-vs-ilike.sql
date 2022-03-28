-- BAD 8s:
with shadow_table_only_for_ordering as (
    select 'users1' as _, count(*) from users where uid ilike upper('%1%ui%')
    union all
    select 'users2' as _, count(*) from users where uid ilike upper('%2%ui%')
    union all
    select 'users3' as _, count(*) from users where nickname ilike upper('%5%_nick%')
    union all
    select 'users4' as _, count(*) from users where givenname ilike upper('%7%_given%')
    union all
    select 'users5' as _, count(*) from users where surname ilike upper('%8%_sure%')
    union all
    select 'users6' as _, count(*) from users where email ilike upper('%3%_email%')
    union all
    select 'users7' as _, count(*) from users where city ilike upper('%1%_city%')
    union all
    select 'users8' as _, count(*) from users where street ilike upper('%9%_street%')
    union all
    select 'users9' as _, count(*) from users where company ilike upper('%A%')
) select * from shadow_table_only_for_ordering order by _;
