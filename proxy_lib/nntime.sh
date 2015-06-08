#!/bin/bash
for i in {1..30}
do
	rep=`curl -s http://nntime.com/proxy-updated-\`[ $i -lt 10 ] && echo 0\`$i.htm | grep -oh '\(.=.;\)\{9\}.=.'`
	content=`curl -s "http://nntime.com/proxy-updated-\`[ $i -lt 10 ] && echo 0\`$i.htm" | grep '<td><input type="checkbox" name="' | grep -oh '\([[:digit:]]\{1,3\}.\)\{4\}script type="text/javascript">document.write(.*)' | sed 's/<script type="text\/javascript">document.write(":"/:/' | sed 's/)//'`
set -- "$rep"
IFS=";"; declare -a Array=($*)
set -- "${Array[0]}"
IFS="="; declare -a a=($*)
set -- "${Array[1]}"
IFS="="; declare -a b=($*)
set -- "${Array[2]}"
IFS="="; declare -a c=($*)
set -- "${Array[3]}"
IFS="="; declare -a d=($*)
set -- "${Array[4]}"
IFS="="; declare -a e=($*)
set -- "${Array[5]}"
IFS="="; declare -a f=($*)
set -- "${Array[6]}"
IFS="="; declare -a g=($*)
set -- "${Array[7]}"
IFS="="; declare -a h=($*)
set -- "${Array[8]}"
IFS="="; declare -a i=($*)
set -- "${Array[9]}"
IFS="="; declare -a j=($*)
echo $content | sed "s/+${a[0]}/${a[1]}/g" | sed "s/+${b[0]}/${b[1]}/g" | sed "s/+${c[0]}/${c[1]}/g" | sed "s/+${d[0]}/${d[1]}/g" | sed "s/+${e[0]}/${e[1]}/g" | sed "s/+${f[0]}/${f[1]}/g" | sed "s/+${g[0]}/${g[1]}/g" | sed "s/+${h[0]}/${h[1]}/g" | sed "s/+${i[0]}/${i[1]}/g" | sed "s/+${j[0]}/${j[1]}/g"
done
