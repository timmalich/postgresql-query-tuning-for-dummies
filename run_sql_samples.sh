#!/usr/bin/env bash
cd "$(dirname "$0")"
SAMPLES_PATH=./sql_samples
ERROR_OUTPUT=./errors.log
if [ -z "$1" ]; then
  OUTPUT=results.md
else
  OUTPUT=$1
fi
echo $OUTPUT

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
  # only get the time and send stdout/stderr to their normal places
  # praise stackoverflow https://stackoverflow.com/questions/4617489/get-values-from-time-command-via-bash-script
  exec 3>&1 4>&2
  timeStdout=$( { time $(cat $file | docker exec -i tuningfordummies psql -x -U postgres -o /dev/null 2>>./$ERROR_OUTPUT) 1>&3 2>&4; } 2>&1 )
  exec 3>&- 4>&-
  echo $timeStdout
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
store_results subquery-missing-backlink-id 3_GOOD_subquery-missing-backlink-id.sql 3_BAD_subquery-missing-backlink-id.sql
store_results subquery-unnecessary-backlinks 4_GOOD_subquery-unnecessary-backlinks.sql 4_BAD_subquery-unnecessary-backlinks.sql
store_results upper-vs-ilike 5_GOOD_upper-vs-ilike.sql 5_BAD_upper-vs-ilike.sql

echo
echo "Results ($OUTPUT):"
cat $OUTPUT
if [ -s $ERROR_OUTPUT ]; then
    echo -e "\033[0;31m Got errors during SQL execution"
    date >> $ERROR_OUTPUT
    cat $ERROR_OUTPUT
    echo -e "\033[0m"
else
  rm $ERROR_OUTPUT
fi
