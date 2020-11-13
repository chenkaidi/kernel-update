#!/bin/bash

#centos7 升级内核

#启用 ELRepo 仓库：
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org

#安装时候，查看最新的elrepo源：http://elrepo.org/tiki/tiki-index.php
rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm

#查看可用的系统内核包
yum --disablerepo="*" --enablerepo="elrepo-kernel" list available

#安装最新内核: kernel-ml
yum --enablerepo=elrepo-kernel install kernel-ml -y

#或者，安装长期支持版内核: kernel-lt
#yum --enablerepo=elrepo-kernel install kernel-lt -y

#设置 grub2
#通过 grub2-set-default 0 命令设置：
#其中 0 来自上一步的 awk 命令：
grub2-set-default 0

#编辑 /etc/default/grub 文件
#设置 GRUB_DEFAULT=0
sed -i '/GRUB_DEFAULT/s/^.*$/GRUB_DEFAULT=0/g' /etc/default/grub

#生成 grub 配置文件并重启
grub2-mkconfig -o /boot/grub2/grub.cfg

#重启
reboot
