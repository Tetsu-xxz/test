#!/bin/bash
url="http://ispip.clang.cn/"
for i in chinatelecom unicom_cnc cmcc crtc cernet othernet
do
wget $url$i.html -O /tmp/$i.txt
sed -n '/^[0-9]/ s/$/;/gp' /tmp/$i.txt | sed "1iacl $i {" | sed '$a};'>/var/named/$i.txt
done