#!/bin/bash
#检测主机IP存活情况，并以文本形式储存在/tmp/ip.txt中
rm -rf /tmp/ip.txt
touch /tmp/ip.txt && echo "存活ip">/tmp/ip.txt
echo "请稍等存活IP正在写入/tmp/ip.txt中"
for i in 192.168.1.{1..254}
do
ping -c 3 -i 0.1 -W 3 $i &>/dev/null
        if [ $? -eq 0 ];then
        echo "$i up" >>/tmp/ip.txt
        fi
done
echo "写入完成"
