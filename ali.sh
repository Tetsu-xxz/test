#!/bin/bash
mkdir -p /etc/yum.repos.d/backup/ 
mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/backup/
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo >/dev/null
if [ $? -eq 0 ]
then
echo "阿里云repo源下载成功"
else
echo "阿里云repo源下载失败"
fi
echo "清理缓存"
yum clean all >/dev/null
yum makecache fast >/dev/null
echo "安装epel源"
yum -y install epel-release >/dev/null
if [ $? -eq 0 ]
then
echo "epel源下载成功"
else
echo "epel源下载失败"
fi

