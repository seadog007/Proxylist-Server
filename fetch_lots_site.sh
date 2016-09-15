#!/bin/bash
while true
do
	#####################################
	./proxy_lib/nntime.sh >> ./proxylist_tmp
	./proxy_lib/hidemyass.py >> ./proxylist_tmp
	./proxy_lib/checkerproxy.sh >> ./proxylist_tmp
	./proxy_lib/freeproxylist.sh >> ./proxylist_tmp
	./proxy_lib/proxylist.sh >> ./proxylist_tmp
	#./proxy_lib/kuaidaili.py; echo ./proxy_lib/result.txt >> ./proxylist_tmp; rm ./result.txt
	#####################################
	./reproduce.sh checked/proxylist >> ./proxylist
	cat ./proxylist ./proxylist_tmp | sort -u | sort -R > ./proxylist_uncheck
	rm proxylist_tmp
	rm proxylist
	./checker.sh proxylist_uncheck > checked/proxylist

	echo "`date '+%Y/%m/%d %H:%M'` Updated"
	sleep 180
done
