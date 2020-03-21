
## Nginx安装 ##

1. 远程工具安装，使用工具远程连接到Linxu服务器
2. 安装
	1. 需要的素材
		+ pcre-8.37.tar.gz
		+ openssl-1.0.1t.tar.gz
		+ zlib-1.2.8.tar.gz
		+ nginx-1.11.1.tar.gz

	2. 安装文件 pcre
		1. `tar -zxvf filename`
		2. 进入目录执行 `./configure`
		3. 使用 `make && make install`
		4. 安装完成之后查看版本 `pcre-config --version`

	3. 安装其他依赖

		`yum -y install gcc zlib zlib-devel pre-devel openssl openssl-devel`

	4. 安装其他依赖

		1. nginx放置到系统中
		2. 解压缩文件
		3. 进入压缩目录，执行 ./configure
		4. 使用 make && make install 完成按住给你 

		安装完成之后 在 etc/下面由 nginx的文件夹
		/usr/sbin/nginx 是一个情动命令

注意： 需要在防火墙中添加规则开放防火墙端口 `firewall-cmd --list-all`

firewall 命令补充学习来自[Centos7.3防火墙配置](https://www.cnblogs.com/xxoome/p/7115614.html)

1. 查看服务状态  `systemctl status firewalld`
2. 查看firewall状态 `firewall-cmd --statue`
3. 开启、关闭、重启 firewalld.service

	```
	开启
	service firewalld start
	重启
	service firewalld restart
	关闭
	service firewalld stop
	```
4. 查看防火墙规则 `firewall-cmd --list-all`
5. 查询、开放、关闭端口
	
	```
	查询端口是否开放
	firewall-cmd --query-port=8080/tcp
	开放80端口
	firewall-cmd --permanent --add-port=80/tcp
	移除端口
	firewall-cmd --permanent --remove-port=8080/tcp
	重启防火墙(修改配置后要重启防火墙)
	firewall-cmd --reload
	参数解释
	1、firwall-cmd：是Linux提供的操作firewall的一个工具；
	2、--permanent：表示设置为持久；
	3、--add-port：标识添加的端口；
	```
	



