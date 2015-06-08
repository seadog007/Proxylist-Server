for i in `seq 10`
do
	w3m -dump -T text/html -cols 120 http://proxy-list.org/english/index.php\?p\=$i | grep -E -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}:[0-9]{1,}';
done
