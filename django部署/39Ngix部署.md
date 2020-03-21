
## Nginx + uWSGI部署 ##

Linux常用的web服务器软件：Apache，Nginx

Apache  

+ 模块多，功能强大
+ 内置了对PHP，Python，Perl和其他语言的支持

Nginx(Engine-X)

+ 轻量级，抗高并发，速度快


### 使用Nginx + uWSGI部署 ###

#### 安装uwsgi ####

	pip3 install uwsgi
	创建软连接
	ln -s /usr/local/python3/bin/uwsgi /usr/bin/uwsgi

#### 测试uwsgi ####

	cd /home
	ls  查看目录中都有什么信息
	编写测试文件 参考自https://uwsgi-docs-zh.readthedocs.io/zh_CN/latest/tutorials/Django_and_nginx.html的测试文件
	运行 uwsgi --http :8001 --wsgi-file test.py

WSGI 规范 Web Server Gateway interface

启动服务发现内置服务器错误,错误原因如下，缺少配置`--module 选项`

`--- no python application found, check your startup logs for errors ---`

`uwsgi --chdir=/home/huang/Blog/ --home=/home/huang/mysite_env --http :8080 --module=mysite.wsgi`

可能加载的时候缺少静态显示，wsgi知识把动态内容成功加载出来


#### 安装Nginx ####

所以如上提到的静态的未加载出来的内容就采用 nginx加载

导入 `yum install nginx`

```
cd /etc/nginx

```

#### 配置 ####


#### 启动nginx ####

netstat -ntlp

uwsgi --ini /home/huang/blog_uwsgi/mysite.ini
uwsgi --stop /home/huang/blog_uwsgi/master.pid

/etc/nginx/sites-available
/var/log/nginx.access.log
service nginx restart

service nginx stop

查看 nginx 报错 journalctl -xe

<hr>

### Nginx使用过程中的问题 ###

1. 无法加载静态页面

	无法加载静态页面的方法可能有两个，一个是页面的location配置问题，还有一个是用户权限问题，本人遇到的是第二个问题

	+ 因为设置的 user 为 nginx 所以无法访问一些静态资源，用户更改为 root 后问题解决，相关设置在`nginx.conf`的首行


2. 无法加载Django后台管理布局的一些CSS样式

	参照的解决方法是[django无法加载admin的静态内容的问题(Centos7+Nginx+uwsgi环境下)](https://www.cnblogs.com/Skrillex/p/6836907.html),  
	可以如下这么理解

	+ Django不会去解析静态内容（css,js,img）等，这些资源需要交给Nginx去处理，所以`nginx.conf`文件需要配置好
	+ 需要配置Django settings.py中的 STATIC_ROOT 和 STATIC_URL

			STATIC_ROOT = '/static/'
			STATIC_URL = '/static/'

	具体解决步骤如下

	1. 首先运行 `python manage.py collectstatic` 将静态资源搬到那个路径下，如有必须，需要开启虚拟环境
	2. Nginx文件配置

   
			location /static {
				root /;
				alias {{ /static }}/static;
			}
			
			BLOG后台管理系统无法进入
			
			
			/upload/2020/02/10/1.png
			