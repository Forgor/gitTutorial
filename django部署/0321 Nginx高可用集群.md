
## Nginx 高可用集群 ##

### 如何实现 ###

通过软件 keepalived 实现 Nginx 的高可用，keepalived 相当于一个路由，会通过内部的脚本检测当前的 Nginx 是否还活着，如果检测到已经down 了，会切换到Backup Nginx服务器， 但是备份服务器需要对外提供一个虚拟的IP，实际不存在，只是用于访问备用服务器的

所以需要如下：

+ 两台 Nginx 服务器
+ 需要 keepalive 服务
+ 需要虚拟 ip

### 准备工作 ###

1. 需要两台服务器
2. 两台服务器 安装nginx
3. 连台服务器 安装 keepalived

安装路径是 `/etc/keepalived`

查询已安装包 `rpm -q -a keepalived`

### 修改配置文件完成高可用配置 ###


1. 高可用主备模式

	1.1. 修改 keepalived.conf 配置文件    
	1.2  在 /usr/local/src/ 添加检测脚本


		#!/bin/bash
		A=`ps -C nginx -no-header | wc -1`
		if [ $A -eq 0];then
			/usr/local/nginx/sbin/nginx
			sleep 2
			if [`ps -C nginx --no-header | wc -1` -eq 0];then
				killall keepalived
			fi
		fi

	1.3 两台服务器 启动 nginx 以及 keepalive `systemctl start keepalive.service`