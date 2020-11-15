#!/bin/bash
#######远程同步脚本
INOTIFY_CMD="inotifywait -mrq -e modify,create,move,attrib,delete /var/www/html/"
RSYNC_CMD="rsync -azH --delete --password-file=/etc/server.pass /var/www/html/ backuper@192.168.200.111::wwwroot"
$INOTIFY_CMD | while read DIRECTORY EVENT FILE
do
        if [ $(pgrep rsync | wc -l) -le 0 ]
        then
                $RSYNC_CMD &> /dev/null
        fi
done