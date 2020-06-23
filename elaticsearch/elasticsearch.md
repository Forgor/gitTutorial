
### Elaticsearch 学习手册

学习原则：深度优先，广度次之

本文件整理的资料来源自如下链接[ElasticSearch从入门到精通实战教程](https://www.bilibili.com/video/BV1vE411E7WA?from=search&seid=12580180515607102462)

### 第一节 Restful 引言

#### Restful概念

1. 什么是RESTful？

    定义： REST-表现层状态转化(Representational State Transfer)，如果一个架构符合REST原则，那么就称他为RESTful架构风格

    RESTful 是一种软件架构风格，既不是标准，也不是规范， 作者是Apache协会第一任主席提出的

2. 什么是REST？

    HTTP 协议 1.0 Apache基金会一个博士提出，后来产生了HTTP1.1 网络传输协议
    REST-表现层状态转化(Resource Representational State Transfer)
    更准确的说法是 资源的表现层状态转化
    REST-一组设计原则 设计约束

    Resource 资源，所谓资源是网络上的一个实体，或者是网络上的一个具体信息，举例子，一首歌，一个图片，一条数据库中的记录，将一切事物抽象为资源， 每个资源都有一个唯一的标识，这个标识称为URL(统一资源定位符)
    Representational 表现层，实际上把网络中资源聚集呈现出来的形式，举例子，资源具体呈现出来的形式称为表现层，
    State Transfer 状态转化，客户端操作服务器资源，必须通过某种手段让服务器资源发生状态转化，

    REST设计原则 设计约束，既不是标准，也不是规范

    1. 网络中的一切事物抽象为URL，使用restURL替换传统URL请求

        传统URL http://localhost:8989/xxx/find?id=21  
        RestURL http://localhost:8989/xxx/find/21/name/ 参数隐藏在URL中

    2. 使用Http四种动词对应服务器四种操作：CURD 资源增删改查

        HTTP动词 GET POST PUT DELETE
        GET：查询
        POST：更新操作（添加）
        PUT：添加操作（更新）
        DELETE：删除操作

    3. 数据传送方式多使用JSON。

    Elaticsearch使用的就是Restful的架构

### 第二节 简单使用 Restful

rest设计原则

1. 使用rest的url替换传统url
2. 使用rest四种动词对应服务端四种操作

restful的适用场景（数据交互全部使用JSON）
+ 服务间系统调用（微服务系统）
+ 前后端分离（前端VUE前端技术栈，MVVM后端所有服务与前端分离）

微服务系统开发：项目中模块拆分成若干服务，然后服务拓展为集群，scrum cloud基本概念

http借助Httpclient以及Postman辅助开发

restful开发

1. 相关注解

+ 控制器 @RestController 标识这是一个restful架构
+ 方法上 @GETMapping  @POSTMapping @PUTMapping @DeleteMapping  对应服务端四种操作
+ 参数上 @PathVariba() @RequestBody

2. 开发Restful风格

没有基础，此处略过

### 第三节 全文检索概念以及Elaticsearch基础介绍

#### 1. 什么是全文检索

全文检索是计算机程序通过扫描文章中的每一个词，对每一个词建立一个索引，指明该词在文章中的次数以及位置，当用户查询时，根据建立的索引查找，类似于字段检索字表查字的过程

全文检索（FULL-TEXT Retrieval（检索））以文本作为检索对象，全面、准确和快速是衡量全文检索系统的关键指标


一般检索都是应用的全文检索，并不是数据库常见的模糊查询，故搜索内容时候，搜索的并不是数据库，二十全额全文检索

关于全文检索
1. 只处理文本
2. 不处理语义
3. 搜索时候英文不区分大小写
4. 结果列表有相关度排序

全文检索与数据库检索的不同
1. 全文检索比数据库模糊查询检索效率高得多
2. 数据库检索没有相关度的排序
3. 搜索时候关键词不区分大小写

#### 2. 什么是Elasticsearch

Elasticsearch 简称是ES，是基于Apache Lucense构建的开源搜索引擎，同时ES是由java语言编写，提供了简单易用的restful API，当前比较流行企业级分布式搜索引擎。

Compase Lucense的框架

必须有大数据的基础，才可以构建ELK（Elasticsearch logstash Kibana）

#### 3. ES的应用场景

ES应用于很多大型公司，
ES主要以轻量级的JSON作为数据存储形式，这点和MangoDB很相似，但是读写性能要优于MangoDB，同时也支持地理位置查询，还方便地理位置和文本混合查询，以及在统计，日志类数据存储和分析，可视化这方面是引导者

国外应用：维基百科 stackoverflow Github
国内应用：百度，新浪，阿里，腾讯


### 第四节 安装ES

#### 1. 如下内容介绍elasticsearch安装

1. 安装前准备 
+ centos7
+ java 8
    安装java并在`/etc/profile`中配置环境变量

    不小心配置错误Java环境变量，解决措施
    直接在命令行输入`export PATH=/usr/bin:/usr/sbin:/bin:/sbin:/usr/X11R6/bin 后 Enter`
+ elastic 6.2.4+
    选择[官方网站](https://www.elastic.co/cn/elastic-stack)下载安装包

    ```
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.7.1-linux-x86_64.tar.gz
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.7.1-linux-x86_64.tar.gz.sha512
    shasum -a 512 -c elasticsearch-7.7.1-linux-x86_64.tar.gz.sha512 
    tar -xzf elasticsearch-7.7.1-linux-x86_64.tar.gz
    cd elasticsearch-7.7.1/ 
    ```



2. 官方网站下载ES
    > wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.7.1-linux-x86_64.tar.gz
 
3. ES的目录结构

    + bin + 可执行的二进制脚本文件(重点关注)
    + config + 配置文件 (重点关注)
    + lib  java编写的第三方的依赖库
    + logs + 日志目录 (重点关注)
    + modules
    + plugins +

启动脚本 /bin/elasticsearch
核心配置文件 /config/elasticsearch.yml
logs 以及 plugins默认都是空的

启动 进入bin目录然后执行 `./elasticsearch`

ES启动的时候出现错误：ES默认不能使用root用户启动
原因 索引会占用系统一定的JVM内存和一定的磁盘空间，所以设计的时候不允许以root启动

创建组 groupadd es
创建用户 useradd es -g es
pwd !QAZxsw#EDC

测试ES是否启动

> curl http://localhost:9200

#### 启动报错以及处理方式

报错如下

    控制台报错
```
[es@iZ2zehxps1f8a818z6i7xjZ bin]$ ./elasticsearch
future versions of Elasticsearch will require Java 11; your Java version from [/home/es/jdk1.8.0_231/jre] does not meet this requirement
future versions of Elasticsearch will require Java 11; your Java version from [/home/es/jdk1.8.0_231/jre] does not meet this requirement
Killed
```

    log 文件夹报错

```
[es@iZ2zehxps1f8a818z6i7xjZ logs]$ cat gc.log.18
[2020-06-10T02:13:30.926+0000][5069][gc] Using Concurrent Mark Sweep
[2020-06-10T02:13:30.926+0000][5069][gc,heap,coops] Heap address: 0x00000000c0000000, size: 1024 MB, Compressed Oops mode: 32-bit
[2020-06-10T02:13:31.067+0000][5069][safepoint    ] Entering safepoint region: EnableBiasedLocking
[2020-06-10T02:13:31.068+0000][5069][safepoint    ] Leaving safepoint region
[2020-06-10T02:13:31.068+0000][5069][safepoint    ] Total time for which application threads were stopped: 0.0001419 seconds, Stopping threads took: 0.0000691 seconds
[2020-06-10T02:13:31.069+0000][5069][gc,heap,exit ] Heap
[2020-06-10T02:13:31.069+0000][5069][gc,heap,exit ]  par new generation   total 76672K, used 4089K [0x00000000c0000000, 0x00000000c5330000, 0x00000000c5330000)
[2020-06-10T02:13:31.069+0000][5069][gc,heap,exit ]   eden space 68160K,   6% used [0x00000000c0000000, 0x00000000c03fe7f8, 0x00000000c4290000)
[2020-06-10T02:13:31.069+0000][5069][gc,heap,exit ]   from space 8512K,   0% used [0x00000000c4290000, 0x00000000c4290000, 0x00000000c4ae0000)
[2020-06-10T02:13:31.069+0000][5069][gc,heap,exit ]   to   space 8512K,   0% used [0x00000000c4ae0000, 0x00000000c4ae0000, 0x00000000c5330000)
[2020-06-10T02:13:31.069+0000][5069][gc,heap,exit ]  concurrent mark-sweep generation total 963392K, used 0K [0x00000000c5330000, 0x0000000100000000, 0x0000000100000000)
[2020-06-10T02:13:31.069+0000][5069][gc,heap,exit ]  Metaspace       used 3111K, capacity 4480K, committed 4480K, reserved 1056768K
[2020-06-10T02:13:31.069+0000][5069][gc,heap,exit ]   class space    used 269K, capacity 384K, committed 384K, reserved 1048576K
[2020-06-10T02:13:31.069+0000][5069][safepoint    ] Application time: 0.0016518 seconds
[2020-06-10T02:13:31.069+0000][5069][safepoint    ] Entering safepoint region: Halt
```

```
# Xms represents the initial size of total heap space
# Xmx represents the maximum size of total heap space

修改如下配置
-Xms512m
-Xmx512m

#Xms108s
#Xms108s
```
IQS-3688


### 第五节 ES开启远程连接权限

ES默认情况下只能本地连接，如果需要远程连接，需要修改远程连接文件

1. 修改ES配置文件
    进入ES安装目录中，修改 elasticsearch.yml 修改如下配置,IP地址修改为0.0.0.0
    ```
    # Set the bind address to a specific IP (IPv4 or IPv6):
    #
    network.host: 0.0.0.0
    ```
2. 启动ES服务，处理ES错误,出下如下错误的解决方案

    ```
    1]: max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]
    [2]: JVM is using the client VM [Java HotSpot(TM) Client VM] but should be using a server VM for the best performance
    [3]: system call filters failed to install; check the logs and fix your configuration or disable system call filters at your own risk
    [4]: the default discovery settings are unsuitable for production use; at least one of [discovery.seed_hosts, discovery.seed_providers, cluster.initial_master_nodes] must be configured
    ERROR: Elasticsearch did not exit normally - check the logs at /home/es/elasticsearch-7.7.1/logs/elasticsearch.log
    [2020-06-11T19:14:39,700][INFO ][o.e.n.Node               ] [iZ2zehxps1f8a818z6i7xjZ] stopping ...
    [2020-06-11T19:14:39,713][INFO ][o.e.n.Node               ] [iZ2zehxps1f8a818z6i7xjZ] stopped
    [2020-06-11T19:14:39,714][INFO ][o.e.n.Node               ] [iZ2zehxps1f8a818z6i7xjZ] closing ...
    [2020-06-11T19:14:39,724][INFO ][o.e.n.Node               ] [iZ2zehxps1f8a818z6i7xjZ] closed

    ```
    以下操作，切换到root用户

    1.  解决如下问题 
    
    > max file descriptors[4096] for elasticsearch process is too lw, increase to at least 65536
    编辑 `etc/security/limits.conf`
    ```
        *          soft nofile
        *          hard nofile
        *          soft nproc
        *          hard nproc
    ```
    建议退出重新登录，检查是否生效
    ```
        ulimit -Hn
        ulimit -Sn
        ulimit -Hu
        ulimit -Su 
    ```

    如果出现对应的参数信息，则配置成功
    ```
    [root@iZ2zehxps1f8a818z6i7xjZ ~]#         ulimit -Hn
    65535
    [root@iZ2zehxps1f8a818z6i7xjZ ~]#         ulimit -Sn
    65535
    [root@iZ2zehxps1f8a818z6i7xjZ ~]#         ulimit -Hu
    4096
    [root@iZ2zehxps1f8a818z6i7xjZ ~]#         ulimit -Su
    4096
    [root@iZ2zehxps1f8a818z6i7xjZ ~]#
    ```

    2. 解决如下问题
    > max number of thread [3802] for user [es] is too low, incrrease to at least [4096]

    vim /etc/security/limits.d/20-nproc.conf 在文件中加入 如下配置

    ```
        启动ES用户名 es soft nproc 4096
    ```

    原始配置
    ```
    *         soft    nproc     4096
    root       soft    nproc     unlimited
    ```

    更改为如下配置
    ```
    es         soft    nproc     4096
    root       soft    nproc     unlimited
    ```


    3. 解决如下问题
    > max virtual memory ares vm.max_map_count[65530] is too low, increase to at least[262144]

    vi /etc/sysctl.conf 添加如下命令

    vm.max_map_count=655360

    剩下执行如下命令
    > sysctl -p


    除了以上错误外还有如下错误
    [1]: JVM is using the client VM [Java HotSpot(TM) Client VM] but should be using a server VM for the best performance
    [2]: system call filters failed to install; check the logs and fix your configuration or disable system call filters at your own risk
    [3]: the default discovery settings are unsuitable for production use; at least one of [discovery.seed_hosts, discovery.seed_providers, cluster.initial_master_nodes] must be configured
    ERROR: Elasticsearch did not exit normally - check the logs at /home/es/elasticsearch-7.7.1/logs/elasticsearch.log


    问题[1] 修改文件 JAVA_HOME\jre\lib\i386\jvm.cfg,调整为如下顺序
    > vi jre/lib/i386/jvm.cfg
    ```
        -server KNOWN
        -client IF_SERVER_CLASS -server
        -minimal KNOWN
    ```

    问题[2] 修改文件 vi elasticsearch-7.7.1/config/elasticsearch.yml 
    原因：这是在因为Centos6不支持SecComp，而ES5.2.0默认bootstrap.system_call_filter为true进行检测，所以导致检测失败，失败后直接导致ES不能启动。
    解决：
    在elasticsearch.yml中配置bootstrap.system_call_filter为false，注意要在Memory下面:
    bootstrap.memory_lock: false
    bootstrap.system_call_filter: false

    问题[3] 修改文件 vi elasticsearch-7.7.1/config/elasticsearch.yml 
    elasticsearch.yml
    取消注释保留一个节点
    cluster.initial_master_nodes: ["node-1"]
    这个的话，这里的node-1是上面一个默认的记得打开就可以了

    然后出现了问题[4] 如下
    memory locking requested for elasticsearch process but memory is not locked
    ERROR: Elasticsearch did not exit normally - check the logs at /home/es/elasticsearch-7.7.1/logs/elasticsearch.log

    解决方法一(关闭bootstrap.memory_lock:，会影响性能）：

    vim /etc/elasticsearch/elasticsearch.yml          // 设置成false就正常运行了。
    bootstrap.memory_lock: false
    解决方法二（开启bootstrap.memory_lock:）：
    1. 修改文件/etc/elasticsearch/elasticsearch.yml，上面那个报错就是开启后产生的，如果开启还要修改其它系统配置文件 
    bootstrap.memory_lock: true
    2. 修改文件/etc/security/limits.conf，最后添加以下内容。   
    ```   
        * soft nofile 65536
        * hard nofile 65536
        * soft nproc 32000
        * hard nproc 32000
        * hard memlock unlimited
        * soft memlock unlimited
    ```
    3. 修改文件 /etc/systemd/system.conf ，分别修改以下内容。
    ```
        DefaultLimitNOFILE=65536
        DefaultLimitNPROC=32000
        DefaultLimitMEMLOCK=infinity
    ```
    改好后重启下系统。再启动elasticsearch就没报错了 。



3. 重新启动ES，注意关闭防火墙， 云服务器开启 9200 9300两个端口


### 第六节 ES中重要概念
