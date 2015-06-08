#!/bin/bash
while true
do
	#####################################
	./proxy_lib/nntime.sh >> ./proxylist_tmp
	./proxy_lib/hidemyass.py >> ./proxylist_tmp
	./proxy_lib/checkerproxy.sh >> ./proxylist_tmp
	./proxy_lib/freeproxylist.sh >> ./proxylist_tmp
	./proxy_lib/proxylist.sh >> ./proxylist_tmp
	#####################################
	cat ./proxylist ./proxylist_tmp | sort -u | sort -R > ./proxylist
	rm proxylist_tmp
	echo "`date '+%Y/%m/%d %H:%M'` Updated"
	sleep 120
done
