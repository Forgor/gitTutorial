## MySQL命令 ##

### MySQL安装

主要内容参考文章[手把手教你怎么使用运服务器](https://www.cnblogs.com/Java3y/p/11751688.html)

1. 安装MySQL所需要的相关环境

		[root@localhost ~]# yum -y install make bison-devel ncures-devel libaio 
		[root@localhost ~]# yum -y install libaio libaio-devel    
		[root@localhost ~]# yum -y install perl-Data-Dumper    
		[root@localhost ~]# yum -y install net-tools   

2. 安装 bison，写者这里跟推荐的一样安装的2.5.1版本

		bison下载地址：http://www.gnu.org/software/bison/  
		[root@localhost ~]# tar zxvf bison-2.5.1.tar.gz   
		[root@localhost ~]# cd bison-2.5.1   
		[root@localhost ~]# ./configure   
		[root@localhost ~]# make   
		[root@localhost ~]# make install  

3. 安装gcc环境

		yum -y install gcc gcc-c++ autoconf automake zlib* libxml* ncurses-devel libmcrypt* libtool* cmake

4. 安装cmake，这里安装版本是3.15.4

		cmake下载地址：http://www.cmake.org/
		
		tar -xzvf cmake-3.15.4.tar.gz
		cd cmake-3.15.4
		./bootstrap
		make   
		make install   
		
		# 更新一下配置
		source /etc/profile

5. 下载mysql并解压

	`MySQL官网链接 https://dev.mysql.com/downloads/mysql/5.6.html#downloads`
	`tar -zxvf mysql-5.6.46.tar.gz`  
	`cd mysql-5.6.46`

		# 安装必要的配置
		yum install openssl-devel

6. 使用 cmake安装

	```cmake \-DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DMYSQL_DATADIR=/usr/local/mysql/data -DSYSCONFDIR=/etc/my.cnf  -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_MEMORY_STORAGE_ENGINE=1 -DWITH_READLINE=1 -DMYSQL_UNIX_ADDR=/tmp/mysqld.sock -DMYSQL_TCP_PORT=3306 -DENABLED_LOCAL_INFILE=1 -DWITH_PARTITION_STORAGE_ENGINE=1 -DEXTRA_CHARSETS=all -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci ```

	不过我这便安装的时候有摆错：是关于cmake中的boost组件的错误，这里我借鉴了这个[解决办法](https://blog.csdn.net/u012767761/article/details/78185768/)

	具体解决如下：

		+ 在/usr/local下创建一个名为boost的文件夹 mkdir -p /usr/local/boost
		+ 进入这个新创建的文件夹然后下载boost wget http://www.sourceforge.net/projects/boost/files/boost/1.59.0/boost_1_59_0.tar.gz
		+ 解压 tar -xvzf boost_1_59_0.tar.gz
		+ 继续cmake，添加上最后选项的boost路径

		cmake \-DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DMYSQL_DATADIR=/usr/local/mysql/data -DSYSCONFDIR=/etc/my.cnf  -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_MEMORY_STORAGE_ENGINE=1 -DWITH_READLINE=1 -DMYSQL_UNIX_ADDR=/tmp/mysqld.sock -DMYSQL_TCP_PORT=3306 -DENABLED_LOCAL_INFILE=1 -DWITH_PARTITION_STORAGE_ENGINE=1 -DEXTRA_CHARSETS=all -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DWITH_BOOST=/usr/local/boost 

7. 错误解决完了就是安装导入，用时较长 `make && make install`

8. 配置mysql

	```
	检查系统是否已经有mysql用户，如果没有则创建
	[root@localhost mysql-5.6.46]# cat /etc/passwd | grep mysql  
	[root@localhost mysql-5.6.46]# cat /etc/group | grep mysql  
	```

9. 创建mysql用户

	```
	[root@localhost mysql-5.6.46]# groupadd mysql
	[root@localhost mysql-5.6.46]# useradd -g mysql mysql  
	```
10. 修改权限

	```
	[root@localhost mysql-5.6.46]# chown -R mysql:mysql /usr/local/mysql  
	```

11. 切换到 mysql 目录

	`cd /usr/local/mysql`

12. 设置相关权限

	`chown -R mysql:mysql .`
	`script/mysql_install_db --user=mysql`
	`chown -R root:mysql .`
	`chown -R mysql:mysql ./data`
	`chown -R ug+rwx`

13. 将mysql的配置文件拷贝到/etc

	``


报错以及处理
1. `ERROR! The server quit without updating PID file (/usr/local/mysql/data/iZ2zehxps1f8a818z6i7xjZ.pid)`


### mysql卸载 ###

参看自[链接](https://blog.csdn.net/best_luxi/article/details/81205555)

首先，查看是否已经安装mysql 如果已经安装了mysql 按步骤删除

	[root@hadoop001 ~]# yum list installed | grep mysql                      
	[root@hadoop001 ~]# rpm -qa | grep mysql*
	[root@hadoop001 ~]# yum remove mysql mysql-server mysql-libs compat-mysql51 -y

查看/var/lib/mysql文件和/etc/my.cnf  如果存在的话，删除

	[root@hadoop001 ~]# rm -rf /var/lib/mysql
	[root@hadoop001 ~]# rm /etc/my.cnf

查看是否已经删除mysql安装 如有存在的话 继续上一步删除

	[root@hadoop001 ~]# yum list installed | grep mysql*
	[root@hadoop001 ~]# rpm -qa | grep mysql*

查看yum中是否存在mysql-server和mysql-devel安装包

### 查看版本 ###

	[root@hadoop001 ~]# yum list mysql*

1. status
2. select version()


### 服务方面

1. 启动服务

	+ 使用 service 启动 `service mysql(d) start`
	+ 使用 mysqld 脚本启动 `/etc/inint.d/mysqld start`
	+ 使用 safe_mysqld 启动 `safe_mysqld&`


2. 停止服务

	+ 使用 service 停止 `service mysql(d) stop`
	+ 使用 mysqld 脚本停止 `/etc/inint.d/mysqld stop`
	+ 使用 mysqladmin 停止 `mysqladmin shutdown`

3. 重启服务

	+ 使用 service 重启 `service mysql(d) restart`
	+ 使用 mysqld 脚本停止 `/etc/inint.d/mysqld restart`


`ps -ef|grep mysqld`

`systemctl status mysqld`

`usr/local/mysql/bin/mysqld`

<hr>

启动服务`service mysqld start`之后遇到如下报错

`Job for mysqld.service failed because the control process exited with error code. See "systemctl status mysqld.service" and "journalctl -xe" for details.`

查看日志文件`cat /var/log/mysqld.log`发现如下

`2020-03-15T02:06:37.874239Z 0 [ERROR] Can't start server: Bind on TCP/IP port: Address already in use
2020-03-15T02:06:37.874243Z 0 [ERROR] Do you already have another mysqld server running on port: 3306 ?
2020-03-15T02:06:37.874250Z 0 [ERROR] Aborting`

`ps aux|grep mysql` 另个一个服务占用了3306端口

`kill port` 问题解决

<hr>

修改root默认密码时候遇到如下错误
`ERROR 3009 (HY000): Column count of mysql.user is wrong. Expected 45, found 42. Created with MySQL 50564, now running 50729. Please use mysql_upgrade to fix this error.`

原因：升级数据库，数据库信息结构会发生变化
措施：更新表结构

`mysql_upgrade -u root -p 密码`

<hr>

mysql 远程连接不允许，更改如下配置

	mysql> GRANT ALL PRIVILEGES ON *.* TO 'hhf'@'39.105.168.194' with grant option;
	Query OK, 0 rows affected (0.00 sec)
	
	mysql> flush privileges;
	Query OK, 0 rows affected (0.00 sec)
	
	mysql> exit
	Bye

还有可能是访问的数据表的host无法访问导致的，这个时候应该更新数据表中的 host 字段为 % 

`update user set host = '%' where user ='hhf';`


一些SQL语句

	```  
	
	select
	TABLE_NAME,
	TABLE_COMMENT
	from
	INFORMATION_SCHEMA.Tables
	where
	table_schema = 'mysql'
	
	
	select
	COLUMN_NAME，
	COLUMN_COMMENT
	from
	INFORMATION_SCHEMA.Columns
	where
	table_name = 'user'
	and table_schema='mysql';
	
	
	select host,user,authentication_string from mysql.user;
	mysql -u hhf -h 39.105.168.194 -p
	alter user 'hhf'@'39.105.168.194' identified by 'test123'
	添加用户
	create user 'hhh'@'localhost' identified by 'test123';
	update user set host = '%' where user ='hhf';
	```  