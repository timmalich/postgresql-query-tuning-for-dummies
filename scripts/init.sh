#!/usr/bin/env bash
echo "Initialize tables in default public schema:"
psql -f /docker-entrypoint-initdb.d/schema.sql.lqs
psql -f /docker-entrypoint-initdb.d/functions.sql.lqs
psql -f /docker-entrypoint-initdb.d/gen_data.sql.lqs
psql -c 'vacuum full;'
