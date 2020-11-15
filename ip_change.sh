#!/bin/bash
read -p "更改的IP为：" c
read -p "需要更改的网卡为：" b
sed -i '/^IPADDR/d' /etc/sysconfig/network-scripts/ifcfg-$b
sed -i 's/BOOTPROTO=dhcp/BOOTPROTO=static/g' /etc/sysconfig/network-scripts/ifcfg-$b
sed -i 's/ONBOOT=no/ONBOOT=yes/g' /etc/sysconfig/network-scripts/ifcfg-$b
sed -i "17aIPADDR=$c" /etc/sysconfig/network-scripts/ifcfg-$b
sed -i '$aNETMASK=255.255.255.0' /etc/sysconfig/network-scripts/ifcfg-$b
sed -i '$aGATEWAY=192.168.1.2' /etc/sysconfig/network-scripts/ifcfg-$b
sed -i '$aDNS1=192.168.1.2' /etc/sysconfig/network-scripts/ifcfg-$b
systemctl restart network
ifconfig $b
