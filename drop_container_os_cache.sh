#!/usr/bin/env bash
docker exec -u 0 tuningfordummies bash -c 'echo 1 > /proc/sys/vm/drop_caches;'
echo done
