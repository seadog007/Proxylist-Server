#!/bin/bash
limit=300
while read line
do
  until [ `jobs | wc -l | sed 's/ //g'` -lt $limit ]
  do
    sleep 0.2
  done
./checker_one.sh $line  &
done < $1

