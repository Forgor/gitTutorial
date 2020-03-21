
## 0320 负载均衡相关配置 ##


### 实现效果 ###

1. 浏览器地址栏输入地址，实现负载均衡效果，平均到8080 和 8081端口中


### 准备工作 ###

1. 准备两台 tomcat 服务器，一台8080， 一台8081

### 进行配置 ###

http块server之前增加

```
upstream myserver{
	ip_hash;
	server XX.XX.XXX.XXX:9001 weight = 1;
	server XX.XX.XXX.XXX:9002 weight = 1;
}
```

server 块中增加 

```
server{
	location / {
		proxy_pass http://myserver;
		proxy_connect_timeout 10;
	}
}
```

### 分配策略 ###

1. 轮询： 每个请求按招生时间顺序逐一分配到不同的后端服务器，如果后端服务器 down掉，则自动剔除
2. weight weight代表权重 默认是1 权重越高分配用户越多
3. ip_hash 解决 session共享
4. fair方式 按照后端服务器的响应时间具体分配，响应时间断的优先分配  写法加上 fair 就可以了
