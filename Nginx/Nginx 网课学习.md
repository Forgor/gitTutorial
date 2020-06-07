## Nginx 网课学习

努力学习，奋斗。

概念，原理，安装，部署，排错

Nginx， MYSQL，Redis，MQ，ZK，CEPH

### 概念

Nginx是一款开源的，免费的WEB服务软件，2019.3.12被F5硬件负载均衡厂家收购了

Nginx Web软件默认只能处理静态网页，不能直接处理动态网页，动态网页交于第三方软件去解析，Nginx官方宣称其处理静态网页的并发能力可以达到 5w/s,相当于Apach WEB整体性能的5-10倍

### 部署

+ YUM二进制方式

  部署方式比较简单，快捷、搞笑可以自动校验软件包的正确性，可以自动校验软件包之间的依赖关系，可以自动安装软件服务并且设置为系统服务

  缺点： 不能自定义软件服务特定的功能和模块，会安装全部弄块，安装的目录比较分散，不便于后期的管理

+ MAKE源码编译方式

  有点以及缺点正好跟YUM向相反

基于MAKE源码编译方式，从0开始构建Nginx Web平台，首先从Nginx官网下载Nginx如那件包稳定版本，nginx-1.16.0.tar.gz

下载地址

​	`wget -c http://WWW.XXXXXXXXXXX -P /tmp/`	

​	`rz -y `

​	`yum install lrzsz -y`



因为Nginx是基于C语言开发的源代码软件程序，默认不能被Linxu直接使用，所以需要戒指C编译器将原地阿玛编译生成二进制文件

+ 预编译 检测Linux 安装软件的依赖，系统是否存在gcc编译器，自定义部署路径，部署模块以及功能，最终产生 Makefile文件

  --with 开启模块，状态监控模块

   `./configure --prefix=/usr/local/nginx --user=www --group=www --with-http_stub_status_module`

  > ./configure --prefix=/usr/local/nginx/ --user=www --group=www --with-http_stub_status_module

+ 编译 `make`

+ 安装 `make install`

  主要是将第二步

![image-20200414204649978](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200414204649978.png)

![image-20200414204724263](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200414204724263.png)

![image-20200414205335628](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200414205335628.png)



#### 排错

C编译器没找到

解决方式 

`yum -y install gcc* gcc-* make`

`yum -y install gcc`  ---

`whereis cc`

`yum install -y pcre pcre-devel `   ---

`yum install -y zlib zlib-devel` ---

`yum install openssl openssl-devel -y`---

`cc -c只编译不产生二进制文件`

`cc -o `



conf 配置目录

html 发布目录

logs 日志文件

sbin  启动文件



`ps -ef|grep nginx 查看进程`



`netstat -tnlp|grep -w 80 查看端口 ` -w word 关键词

`iptables -t filter -A INPUT -m tcp -p tcp --dport 80 -j ACCEPT`

`firewall-cmd --add-port=80/tcp --permanent`



基于Perl语言的正则库

![image-20200414210717451](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200414210717451.png)

`find / -name "*pcre*.so"` 不到万不得已 不要使用 find命令

![image-20200414211314857](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200414211314857.png)

![image-20200414212426777](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200414212426777.png)