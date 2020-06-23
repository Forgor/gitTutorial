

### RPM 包管理


#### RPM介绍

RPM是RedHat Package Manager（RedHat软件包管理工具）的缩写，但理念是通用的
Linux的分发版本都有采用（suse,redhat, centos 等等），

包的命名格式

```
rpm包名基本格式：
一个rpm包名：firefox-45.0.1-1.el6.centos.x86_64.rpm
+ 名称:firefox
+ 版本号：45.0.1-1
+ 适用操作系统: el6.centos.x86_64 表示centos6.x的64位系统
+ 如果是i686、i386表示32位系统，noarch表示通用
```


#### 查询命
rpm -qa：查询所安装的所有rpm软件包
rpm -qa | more ：查询所安装的所有rpm软件包 并且分页显示
rpm -qa | grep X [rpm -qa | grep firefox ] ：查询是否安装有某个软件（火狐的软件）
rpm -q 软件包名 ：查询软件包是否安装 rpm -q firefox
rpm -qi 软件包名 ：查询软件包信息
rpm -ql 软件包名 ：查询软件包中的文件的安装位置
rpm -qf 文件全路径名：查询文件所属的软件包 ，例如：rpm -qf /etc/passwd 


#### 安装
基本语法： rpm -ivh  RPM包全路径名称
参数说明： i=install 安装 v=verbose 提示 h=hash  进度条


