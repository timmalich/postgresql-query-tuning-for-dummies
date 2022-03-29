#!/usr/bin/env bash
cd "$(dirname "$0")"
docker logs -n 0 -f tuningfordummies | cut -d ' ' -f 9- | ./replace-sql-parameters.py

