#!/bin/bash
# cut_nginx_log.sh
datetime=$(date -d "-1 day" "+%Y%m%d")
log_path="/usr/local/nginx/logs"
pid_path="/usr/local/nginx/logs/nginx.pid"
[ -d $log_path/backup ] || mkdir -p $log_path/backup
if [ -f $pid_path ]
then
        mv $log_path/access.log $log_path/backup/access.log-$datetime
        kill -USR1 $(cat $pid_path)        #通知nginx写新的access.log日志文件
        find $log_path/backup -mtime +30 | xargs rm -f    #30天前的日志清理掉
else
        echo "Error,Nginx is not working!" | tee -a /var/log/messages
fi