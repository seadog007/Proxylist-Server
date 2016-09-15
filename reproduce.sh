#!/bin/bash

while read line
do
	set -- "$line"
	IFS=";"; declare -a Array=($*)
	echo ${Array[1]}
done < $1
