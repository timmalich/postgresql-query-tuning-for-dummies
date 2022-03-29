-- be careful! distinct on can be way more effective on some queries.
-- an example would be: you have a not index reference column and you are certain that this colum will already contain your distinct result.
-- in this example the opposite is the case, postgres doesn't recognize that sales.id makes the query distinct already.
with reduceOutput as (
    select distinct on (sales.id, sales.users_id) sales.* from sales
)
select count(*) from reduceOutput;
