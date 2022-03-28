---------------------- NOTE -----------------------------
-- Postgres will automatically create indexes for primary key columns,
--   but not for columns on the referenced table (e.g.: create index on sales (users_id);).
-- Therefore these queries will benefit even more if these indexes are existing.
--
-- I've seen big performance issues under some special circumstances, because of unnecessary joins,
--   but I'm currently not able to reproduce it with the data provided in the repository. :(
-- I've never found an edge case wich would benefit from such an unnecessary join:
--   if you see them, you should be safe to kill'em ...
--                             ... unless your application code is generating dynamic SQL and forcing you to keep them
---------------------------------------------------------
-- Query A - with join
select sales.*
from sales join users on users_id = sales.id
where users.id > 1000 and users.id < 10000
;

-- Query B - without join
select sales.* from sales
where users_id > 1000 and users_id < 10000;

