
### 阿里云云服务器Kibana配置血泪史

由于工作需要，需要学习ES以及Kibana的相关知识，本打算在自己的云服务器上配置试一下，没想到过程这么曲折。

相关环境参数如下
```
阿里云服务器：CentOS 7.7 64位
ES版本：7.7.1

```
所以需要下载对应版本的Kibana

#### 第一步 基于视频教程逐步配置

基于如下视频[ElasticSearch从入门到精通实战教程](https://www.bilibili.com/video/BV1vE411E7WA?p=8)，初步完成了Kibana的相关配置，但是通过命令`netstat -tunlp |grep 5601`查看端口占用情况，没有发现Kibana服务启用，故放弃这种方法，尝试别的方式

后来初步判定 是没有进入相关路径例如`kibana\bin\kibana` 启动相关进程
如果排除如上错误，请检查防火墙相关设置(关闭防火墙，或者防火墙添加5601端口)
阿里云服务器增加安全组，开放5601端口

### 第二步 结合网上教程安装

网上教程参考的是如下两篇文章,虽然版本不一样，但操作还是可借鉴的

[阿里云服务器CentOS7.4安装kibana 6.4.3，结合Elasticsearch使用](https://www.jianshu.com/p/b6e3c6c59481)

[kibana连接外网连不上的坑](https://www.jianshu.com/p/7c793878183c)

其中如果使用的是阿里云服务器在填写 `kibana.yml`文件时候，需要注意如下

```
server.port:5601 #Kibana服务的访问端口
server.host: #Kibana服务绑定的地址（Kibana部署所在的服务器），可以是IP也可以是机器名，如果设置成localhost，则只能在本机访问
```
这是因为云主机一般有双IP，即内外网，切记：这个时候server.host一定要设置为内网IP

但是安装完成止之后启动服务始终有如下报错

```
FATAL  [mapper_parsing_exception] No handler for type [flattened] declared on field [state] :: {"path":"/.kibana_1","query":{},"body":"{\"mappings\":{\"dynamic\":\"strict\",\"properties\":{\"
Dec 11 10:03:14 mcjca033031 kibana[5320]: \":{\"type\":\"geo_shape\"},\"mapStateJSON\":{\"type\":\"text\"},\"layerListJSON\":{\"type\":\"text\"},\"uiStateJSON\":{\"type\":\"text\"}}},\"maps-telemetry\":{\"properties\":{\"mapsTotalCou
Dec 11 10:03:14 mcjca033031 kibana[5320]: \":\"keyword\"},\"color\":{\"type\":\"keyword\"},\"label\":{\"type\":\"keyword\"}}},\"limit\":{\"type\":\"integer\"},\"groupBy\":{\"type\":\"keyword\"},\"filterQuery\":{\"type\":\"keyword\"},
Dec 11 10:03:14 mcjca033031 kibana[5320]: displayValue\":{\"type\":\"text\"},\"operator\":{\"type\":\"text\"}}},\"and\":{\"properties\":{\"id\":{\"type\":\"keyword\"},\"name\":{\"type\":\"text\"},\"enabled\":{\"type\":\"boolean\"},\"
Dec 11 10:03:14 mcjca033031 kibana[5320]: \":\"long\",\"null_value\":0},\"cluster\":{\"type\":\"long\",\"null_value\":0},\"indices\":{\"type\":\"long\",\"null_value\":0}}},\"ui_reindex\":{\"properties\":{\"close\":{\"type\":\"long\",
Dec 11 10:03:14 mcjca033031 kibana[5320]: t\"},\"hits\":{\"type\":\"integer\"},\"kibanaSavedObjectMeta\":{\"properties\":{\"searchSourceJSON\":{\"type\":\"text\"}}},\"sort\":{\"type\":\"keyword\"},\"title\":{\"type\":\"text\"},\"vers
Dec 11 10:03:14 mcjca033031 kibana[5320]: },\"timelion_sheet\":{\"type\":\"text\"},\"title\":{\"type\":\"text\"},\"version\":{\"type\":\"integer\"}}},\"ui-metric\":{\"properties\":{\"count\":{\"type\":\"integer\"}}}},\"_meta\":{\"mig
Dec 11 10:03:14 mcjca033031 kibana[5320]: ",\"sample-data-telemetry\":\"7d3cfeb915303c9641c59681967ffeb4\",\"telemetry\":\"358ffaa88ba34a97d55af0933a117de4\",\"timelion-sheet\":\"9a2a2748877c7a7b582fef201ab1d4cf\",\"ui-metric\":\"0d4
Dec 11 10:03:15 mcjca033031 systemd[1]: kibana.service: main process exited, code=exited, status=1/FAILURE
Dec 11 10:03:15 mcjca033031 systemd[1]: Unit kibana.service entered failed state.
Dec 11 10:03:15 mcjca033031 systemd[1]: kibana.service failed.

```

进一步断定，应该不是安装步骤的原因，应该是安装的软件包有问题

### 第三步 从官网下载OSS类型的软件包，重新安装

这里先普及一些概念 Kibana OSS 版 和 Kibana non-OSS版

我们从官网或者Linux下直接安装的都是 Kibana non-OSS版,例如如下两个版本

+ kibana-7.7.1-x86_64.rpm
+ kibana-7.7.1-linux-x86_64.tar.gz

如果是OSS版，文件名中会明显带有OSS的标记，例如如下

+ kibana-oss-7.7.1-linux-x86_64.tar.gz

那么OSS和non-OSS有什么区别呢？

来自ES官方Team的解释

```
The non-OSS version is the default release that contains the commercially licensed code. The release that contains only open source will have the-oss appended to it.
```

所以下一步下载non-OSS版本的kibana安装试试。


参考链接 

+ [What is open X-Pack](https://www.elastic.co/cn/what-is/open-x-pack)

+ [What are the differences between the Kibana ‘oss’ and ‘non-oss’ build?](https://discuss.elastic.co/t/what-are-the-differences-between-the-kibana-oss-and-non-oss-build/152364)

+ [Cannot start Kibana 7.5.0 Fatal Error have not done any changes in configuration file](https://stackoverflow.com/questions/59316461/cannot-start-kibana-7-5-0-fatal-error-have-not-done-any-changes-in-configuration)

+ [No handler for type [flattened] declared on field [state] #52324](https://github.com/elastic/kibana/issues/52324)


Kibana OSS: `https://artifacts.elastic.co/downloads/kibana/kibana-oss-${VERSION}-linux-x86_64.tar.gz`

Kibana non-OSS: `https://artifacts.elastic.co/downloads/kibana/kibana-${VERSION}-linux-x86_64.tar.gz`

Elastic OSS: `https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-oss-${VERSION}-no-jdk-linux-x86_64.tar.gz`

Elastic non-OSS: `https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${VERSION}-no-jdk-linux-x86_64.tar.gz`

我们需要安装 7.7.7版本的Kibana

所以用如下链接
`https://artifacts.elastic.co/downloads/kibana/kibana-oss-7.7.1-linux-x86_64.tar.gz`

浏览器输入如上链接，自动下载，下载完成后传输至服务器，安装并修改相关信息即可。



