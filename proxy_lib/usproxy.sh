w3m -dump -T text/html -cols 120 http://www.us-proxy.org/ | grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | awk '{printf("%s:%s\n", $1,$2)}'
