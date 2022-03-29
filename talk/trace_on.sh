#!/usr/bin/env bash
docker exec -i tuningfordummies sed -iE 's/#\?log_statement .*/log_statement = all/' /opt/bitnami/postgresql/conf/postgresql.conf;
docker exec -i tuningfordummies sed -iE 's/#\?log_min_duration_statement .*/log_min_duration_statement = 0/' /opt/bitnami/postgresql/conf/postgresql.conf;
docker exec -i tuningfordummies /opt/bitnami/postgresql/bin/pg_ctl -D /bitnami/postgresql/data reload;
