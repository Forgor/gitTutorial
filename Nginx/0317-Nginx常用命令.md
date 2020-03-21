## Nginx操作中常用命令 ##

使用Nginx的命令的时候有一个前提条件，必须进入Nginx的命令中才能使用

### Nginx常用命令 ###

1. 列出版本号 `nginx -v`
2. 关闭命令   `nginx -s stop`
3. 启动命令   `nginx`
4. 重加载     `nginx -s reload`

### Nginx重要目录 ###

1. 日志目录  `/var/log/nginx`

### Nginx配置文件 ###

Nginx的配置文件所在位置是 /etc/nginx/nginx.conf 

+ 第一部分 全局块： 配置整体运行的指令
+ 第二部分 events块： events设计的指令主要影响Nginx与用户网络的连接
+ 第三部分 http块 nginx中配置最频繁的地方，代理、缓存和日志定义等绝大多数功能和第三方模块都在这里   
http块又包含 http块和server块两部分   
http块包括 文件引入，MIME-TYPE定义，日志自定义、连接超时时间、单连接请求数目上限等等   
server块 server块和虚拟主机有密切关系，虚拟主机从用户角度看和一台独立的硬件主机是一样的，该技术的产生是为了节省互联网服务器硬件成本   
每个http块有多个server块，而每个server块相当于一个虚拟主机   
而每个server块也分为全局server块，以及可以同时包含多个location块


### sftp命令传输文件 ###

1. 连接sftp服务 `sftp root@ip address`
2.  查看文件 lls 当前路径  ls 远程服务器的路径
3.  get 获得文件
4.  put 上传文件
5.  ！command 查看本地文件或者内容