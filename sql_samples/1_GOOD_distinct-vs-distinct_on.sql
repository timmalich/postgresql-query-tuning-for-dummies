-- be careful! distinct on can be way more effective on some queries.
-- an example would be: you have a not indexed reference column
-- and you are certain that this colum will already contain your distinct result.
with reduceOutput as (
    select sales.* from sales
)
select count(*) from reduceOutput;

