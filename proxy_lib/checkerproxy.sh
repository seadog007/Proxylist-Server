for i in `seq 0 59`
do
	curl -s "http://checkerproxy.net/`date -d -"$i"days +%d-%m-%Y`" | grep '<li>.*</li>' | sed 's/\t//g' | sed 's/<\/li><li>/\n/g' | sed 's/<li>//g' | sed 's/<\/li><\/ul>//g'
done
