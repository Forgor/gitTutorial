## Nginx--反向代理 ##

使用Nginx配置反向代理

### 反向解析效果 ###

1. 打开浏览器，输入URL，进入tomcat主界面中

### 准备工作 ###

1. 访问到Tomcat主界面，使用默认端口8080
2. 放置Apache文件至Linux
3. 进入bin目录启动
4. Nginx请求转发，也就是反向代理的功能


### Nginx配置文件 ###

主要是在server字段配置，增加相关location标记

主要内容可以参考如下


 	server{
	listen 80;
	server_name 39.105.168.194;
	
	location /blog/ {
	    uwsgi_pass 127.0.0.1:8080;
	    include /etc/nginx/uwsgi_params;
	}

	location /media/ {
	    alias /home/huang/Blog/media/;
	}

	location /static/ {
	    alias /home/huang/Blog/static/;
	}

	location /myWeb/{
	    proxy_pass http://127.0.0.1:8081;
	}
	
	location /resume/{
	    proxy_pass http://127.0.0.1:8082;
	}
    }


需要注意的是 其中location 后面的字样都是项目名称

### Nginx server配置文件中路径的一些问题 ###

在nginx中配置proxy_pass时，当在后面的url加上了/，相当于是绝对根路径，则nginx不会把location中匹配的路径部分代理走;如果没有/，则会把匹配的路径部分也给代理走。

 首先是location进行的是模糊匹配
    1）没有“/”时，location /abc/def可以匹配/abc/defghi请求，也可以匹配/abc/def/ghi等
    2）而有“/”时，location /abc/def/不能匹配/abc/defghi请求，只能匹配/abc/def/anything这样的请求

	第一种：
	
	location  /proxy/ {
	
	proxy_pass http://127.0.0.1:81/;
	
	}
	
	结论：会被代理到http://127.0.0.1:81/test.html 这个url
	
	 
	
	第二种(相对于第一种，最后少一个 /)
	
	location  /proxy/ {
	
	proxy_pass http://127.0.0.1:81;
	
	}
	
	结论：会被代理到http://127.0.0.1:81/proxy/test.html 这个url
	
	 
	
	第三种：
	
	location  /proxy/ {
	
	proxy_pass http://127.0.0.1:81/ftlynx/;
	
	}
	
	结论：会被代理到http://127.0.0.1:81/ftlynx/test.html 这个url。
	
	 
	
	第四种(相对于第三种，最后少一个 / )：
	
	location  /proxy/ {
	
	proxy_pass http://127.0.0.1:81/ftlynx;
	
	}
	
	结论：会被代理到http://127.0.0.1:81/ftlynxtest.html 这个url

总结 proxy_pass 如果有 '/' 则表示绝对路径，不会吧 location 匹配的内容带走

如果没有 '/' 表示相对路径， 会把 location 匹配的内容带走