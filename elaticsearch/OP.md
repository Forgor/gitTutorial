
### Nginx 访问不成功




2020/06/13 15:15:57 [error] 3112#0: *57 connect() failed (111: Connection refused) while connecting to upstream, client: 121.71.230.105, server: 39.105.168.194, request: "GET /favicon.ico HTTP/1.1", upstream: "uwsgi://127.0.0.1:8080", host: "www.hhaifeng.com", referrer: "http://www.hhaifeng.com/"

首先断定是uwigs没有正常开启，开启服务

> uwsgi --ini /home/huang/blog_uwsgi/mysite.ini

"Can't connect to local MySQL server through socket '/var/lib/mysql/mysql.sock' (2

选择重启mysql服务

> service mysqld restart

mysql username  passwd

hhf test1234
root hhf123

查看登录用户
> select user();


