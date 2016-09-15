#!/bin/bash
# HTTP Proxy Server's IP Address (or URL)
proxy_server=$1

# We're trying to reach this url via the given HTTP Proxy Server
# (http://www.google.com by default)
url="http://v4.srv.seadog007.me/test.html"

# Timeout time (in seconds)
timeout=5

# We're fetching the return code and assigning it to the $result variable
result=`HEAD -d -p http://$proxy_server -t $timeout $url`

# If the return code is 200, we've reached to $url successfully
if [ "$result" = "200 OK" ]; then
    echo "http@$proxy_server"
# Otherwise, we've got a problem (either the HTTP Proxy Server does not work
# or the request timed out)
else
	result=`HEAD -d -p socks5://$proxy_server -t $timeout $url`
	if [ "$result" = "200 OK" ]; then
		echo "socks5@$proxy_server"
	fi
fi
