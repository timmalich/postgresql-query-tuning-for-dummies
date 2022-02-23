# Postgresql Query Tuning for Dummies
Repository to create a Postgres database with dummy data and query tuning samples

## Setup database:
With this statement you'll create a running postgres instance on port 64271.
It will include 4 tables in schema 'public':

| table name | rows      |
|------------|-----------|
| sales      | 2.000.000 |
| users      | 1.000.000 |
| products   | 100.000   |
| shops      | 10.000    |

```bash
# IMPORTANT: depending on your hardware this might run a couple of minutes. 
# The database is available after you see this line on stdout:
# `... database system is ready to accept connections`
docker rm -f tuningfordummies; docker run --name tuningfordummies -p 64271:5432 -v $(pwd)/scripts:/docker-entrypoint-initdb.d/ -e POSTGRESQL_PASSWORD=pg -e PGPASSWORD=pg bitnami/postgresql:14.2.0
# Note: the additional env parameter PGPASSWORD=pg only allows to execute `psql -U postgres` in the running container without being prompted for the password.
```

## Configure amount of test data:
You can change the amount of test data in this [script](scripts/gen_data.sql.lqs).
Simply configure the amount variables in the declare section:
```sql
sales_amount    integer := 2000000;
users_amount    integer := 1000000;
products_amount integer := 100000;
shops_amount    integer := 10000;
```

## Connection settings for your SQL user interface
Username: postgres
Password: pg
JDBC URL: jdbc:postgresql://localhost:64271/postgres

