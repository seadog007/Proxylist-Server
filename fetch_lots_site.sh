#!/bin/bash
while true
do
	#####################################
	./proxy_lib/nntime.sh >> ./proxylist_tmp
	./proxy_lib/hidemyass.py >> ./proxylist_tmp
	cat ./proxylist* | sort >> ./proxylist
	rm proxylist_tmp
	echo "`date '+%Y/%m/%d %H:%M'` Updated"
	sleep 120
done
