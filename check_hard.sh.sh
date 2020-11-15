#!/bin/bash
#提取性能监控指标，（磁盘占用，CPU占用，内存使用）
D=$(df -hT | awk '/\/$/ {print $6}' | awk -F% '{print $1}')
C=$(expr 100 - $(mpstat | tail -1 | awk '{print $NF}' | awk -F. '{print $1}'))
M=$(expr $(expr $(free  | awk '/Mem:/{print $3}') \* 100 / $(free  | awk '/Mem:/{print $2}')))
# 设置告警日志文件、告警邮箱
ALOG="/tmp/alert.txt"
> /tmp/alert.txt
# 判断是否记录告警
if [ $D -gt 90 ]
then
echo "磁盘占用率：$D %" >> $ALOG
fi
if [ $C -gt 80 ]
then
echo "CPU使用率：$C %" >> $ALOG
fi
if [ $M -gt 90 ]
then
echo "内存使用率：$M %" >> $ALOG
fi
#发送告警
IP=$(ifconfig ens33 |awk '/inet /{print $2 }')
export sjr="tetsu6@163.com"
[ -f $ALOG ] && /usr/bin/dos2unix -k $ALOG
/bin/mail -s "主机报警$IP" "$sjr" <$ALOG