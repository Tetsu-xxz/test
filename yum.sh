#!/bin/bash
rm -rf /etc/yum.repos.d/*
cat >>/etc/yum.repos.d/a.repo <<END
[a]
name=a
baseurl=file:///media
gpgcheck=0
END
if [ $? -eq 0 ];then
echo "yum平台搭建完成"
else
echo "yum平台搭建失败"
fi
mount /dev/cdrom /media >>/dev/null
if [ $? -eq 0 ];then
echo "光盘挂载完成"
else
echo "请检查光盘"
fi
yum clean all
yum makecache
