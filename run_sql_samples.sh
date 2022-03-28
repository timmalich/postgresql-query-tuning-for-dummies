#!/usr/bin/env bash
OUTPUT=results.md
SAMPLES_PATH=./sql_samples

echo "measuring started"
echo '| Query                   | GOOD   | BAD    |' > $OUTPUT
echo '|-------------------------|--------|--------|' >> $OUTPUT

TIMEFORMAT=%Rs

function drop_container_caches(){
  docker exec -u 0 tuningfordummies bash -c 'echo 1 > /proc/sys/vm/drop_caches;'
  sleep 1s
}

function measure_file(){
  file=$SAMPLES_PATH/$1
  echo $( { time $(cat $file | docker exec -i tuningfordummies psql -x -U postgres -o /dev/null); } 2>&1 )
}

function store_results(){
  nick=$1
  goodFile=$2
  badFile=$3

  drop_container_caches
  goodTime=$(measure_file $goodFile)
  echo "$goodTime: $goodFile"

  drop_container_caches
  badTime=$(measure_file $badFile)
  echo "$badTime: $badFile"

  echo "|$nick|$goodTime|$badTime|" >> $OUTPUT
}

store_results distinct-vs-distinct_on 1_GOOD_distinct-vs-distinct_on.sql 1_BAD_distinct-vs-distinct_on.sql
store_results in-vs-exists 2_GOOD_in-vs-exists.sql 2_BAD_in-vs-exists.sql
# TODO 3 is broken (no space left on device). Error handling in script is currently too poor
#store_results subquery-missing-backlink-id 3_GOOD_subquery-missing-backlink-id.sql 3_BAD_subquery-missing-backlink-id.sql
store_results subquery-unnecessary-backlinks 4_GOOD_subquery-unnecessary-backlinks.sql 4_BAD_subquery-unnecessary-backlinks.sql
store_results upper-vs-ilike 5_GOOD_upper-vs-ilike.sql 5_BAD_upper-vs-ilike.sql

echo
echo "Results ($OUTPUT):"
cat $OUTPUT
