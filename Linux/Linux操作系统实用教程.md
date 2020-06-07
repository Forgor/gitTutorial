## Linux操作系统实用教程

### 第一章 基础知识

1. Linux 软件体系结构

   Linux由下及上的分层为硬件，设备驱动器，Linux内核，系统调用接口，语言函数库，Linux Shell，应用程序

### 第二章 Linux系统安装

Linux系统的分区

+ / 根目录 整个操作系统的根目录，基本上所有的文件都在这个目录

+ /boot 引导分区， 该分区存放着操作系统的内核，用来启动引导操作系统，使用空间为 50-100MB

  SWAP 交换分区，SWAP大小根据经验可以设置为物理分区的两倍，如果物理分区大于1GB,则设置为2GB

+ 其他分区

  + /home 用户目录分区
  + /usr 应用程序目录分区，
  + /var 文件系统分区，如系统日志，Web空间，系统邮件
  + /temp 临时文件目录分区

Linux系统的启动和关闭

系统启动步骤引导如下

+ 加载BIOS(Basic Input/Output System)
+ 进入GRUB/LILO
+ 加载Linux Kernel
+ 执行init 正确位置是 /sbin/init
+ 运行 /etc/rc.d/rc.sysinit Liinux 系统启动的时候运行的第一个脚本
+ 执行 /etc/inittab
+ 执行默认级别的所有Script
+ 执行 /bin/login

系统关机

+ `shutdown -krhfc -t secs time warning message`
+ `shutdown -h now`
+ `shutdown -r now`
+ 其他类似命令 `halt reboot poweroff`

### Linux操作基础

1. Linux与Shell的关系

   用户通过Shell与系统通讯，而依赖于硬件的操作是由内核管理的

2. Shell简介

   命令解释器以及高级程序设计语言

3. 简单命令

   + `pwd` 查看路径
   + `data`查看日期
   + `who` 查看登录系统的所有用户
   + `cal` 查看日历的命令
   + `uname` 查看当前操作系统的信息， `-r` 版本 `-m`机器类型 `-i`硬件平台 `-v`操作系统版本
   + `wc` 统计行数 `-lwc` 行数 字数 字节数
   + `clear` 清屏命令

4. 帮助命令

   `man` 命令是帮助命令 同样的还用 `info`和`whatis`

5. Shell相关的配置文件

   + `/etc/profile` 用户登陆系统最先检查的文件，系统的环境变量多定义在这个文件里面，主要包括 PATH,USER,LANG,MAIL,,HOSTNAME,HISTSIZE和INPUTRC
   + `~/.bash_profile`每个用户的BASH环境配置文件，存在于用户的主目录下，该文件定义了USERNAME,BASHENV和PATH等环境变量，此处的PATH包括了用户自己定义的路径以及用户的`bin`路径
   + `~/.bashrc` 前两个文件仅在系统登录时候读取，此文件在每次运行BASH时候读取，此文件主要定义的是一些终端设置以及SHELL提示符等等，而不定义环境变量等内容
   + `~/.bash_history` 记录用户使用的历史命令

6. 重定向 管道命令 以及历史命令等等

### 第四章 Linux文件系统

#### 第一节 Linux系统的文件以及其类型

1. 文件的组成

   + 索引节点 包含有关相应文件信息的一个记录 包括 文件权限，文件主，文件大小，位置创建日期等等

   + 数据 文件的实际内容

     `stat filename` 查看文件节点相关信息

2. Linux 文件类型

   + 普通文件

     + 文本文件
     + 数据文件
     + 可执行的二进制文件

   + 目录文件

     + `.` 表示该目录本身 `..` 则表示该目录的父目录

   + 设备文件

     设备文件除了存放在文件节点中的信息外，他们不包含任何数据，系统利用他们标识各个设备驱动器，内核使用他们与硬件通讯

     + 字符设备  允许IO设备传送任意发小的数据，取决于设备本身的容量，使用这种接口的设备包括 键盘，终端 打印机以及鼠标
     + 块设备 这类设备利用核心缓冲区的自动缓存机制，缓冲区进行IO传输总是以1KB为单位，使用这种接口的设备包括 硬盘，软盘和光盘等

   + 链接文件

     为解决文件的共享使用，Linux 系统引入了两种链接：硬链接 (hard link) 与软链接（又称符号链接，即 soft link 或 symbolic link）。链接为 Linux 系统解决了文件的共享使用，还带来了隐藏文件路径、增加权限安全及节省存储等好处。若一个 inode 号对应多个文件名，则称这些文件为硬链接。换言之，硬链接就是同一个文件使用了多个别名（见 [图 2.](https://www.ibm.com/developerworks/cn/linux/l-cn-hardandsymb-links/index.html#fig2)hard link 就是 file 的一个别名，他们有共同的 inode）。硬链接可由命令 link 或 ln 创建。如下是对文件 oldfile 创建硬链接。

     ```shell
     link oldfile newfile 
     ln oldfile newfile
     ```

     由于硬链接是有着相同 inode 号仅文件名不同的文件，因此硬链接存在以下几点特性：

     - 文件有相同的 inode 及 data block；
     - 只能对已存在的文件进行创建；
     - 不能交叉文件系统进行硬链接的创建；
     - 不能对目录进行创建，只可对文件创建；
     - 删除一个硬链接文件并不影响其他有相同 inode 号的文件。

     软链接与硬链接不同，若文件用户数据块中存放的内容是另一文件的路径名的指向，则该文件就是软连接。软链接就是一个普通文件，只是数据块内容有点特殊。软链接有着自己的 inode 号以及用户数据块（见 [图 2.](https://www.ibm.com/developerworks/cn/linux/l-cn-hardandsymb-links/index.html#fig2)）。因此软链接的创建与使用没有类似硬链接的诸多限制：

     - 软链接有自己的文件属性及权限等；
     - 可对不存在的文件或目录创建软链接；
     - 软链接可交叉文件系统；
     - 软链接可对文件或目录创建；
     - 创建软链接时，链接计数 i_nlink 不会增加；
     - 删除软链接并不影响被指向的文件，但若被指向的原文件被删除，则相关软连接被称为死链接（即 dangling link，若被指向路径文件被重新创建，死链接可恢复为正常的软链接）。

   + 查看文件挂载的命令 `df -i --print-type` 或者 `mount`

#### 第二节 Linux系统的文件操作命令

+ Linux 下的文件复制，删除以及移动操作

  + 复制 `cp [options] source  destinaton`

    `cp file1 file2` 复制文件

    `cp ./* Dir1` 复制当前目录全部文件到指定目录

    `cp -f file1 file2` 强制覆盖

    `cp -p file1 file2` 不更改inode 以及生成日期

    `cp -r Dir1 Dir2` 递归复制

  + 移动 `mv [options] source destination`

    `mv file1 file2` 将文件从file1 变化为 file2 同一目录的话 inode不变

    `mv file* Dir1` file开头的多个文件移到 Dir1目录

    `mv -f file1 file2` file2已经存在 覆盖时候不提醒

  + 删除 `rm [optins] filename`

    `rm file1`  删除文件

    `rm -f file1 `强制删除文件

    `rm -r Dir1`  递归删除目录

+ Linux下的文件检索 排序命令

  + 检索命令 grep `grep [options] string [file...]`

    `-i` 忽略字符串大小写

    `-n` 显示行号

  + 排序命令 sort`sort [options] [file list]`

    `sort file`  每行第一个数值排序输出

    `sort file1 file2 ` 两个文件联合排序

    `sort -r file1`  反向排序输出

    `sort -ro outf1 file1` file1 排序输出后 写入 outf1

    `sort -n file1` 每行第一个按照数字排序

    `sort -k 3 file1` 每行第三个字段排序

    `sort -nk 3 file1` 每行第三个字段数值排序输出

+ LInux目录操作命令

  + 创建目录 `mkdir`
    + `mkdir Dir1 Dir2 ` 创建Dir1 以及 Dir2两个子目录
    + `mkdir -p Dir1/Dir2` 生成递归子目录
    + `mkdir -m 744 dir/dir` 创建指定权限的递归目录
  + 删除目录 `rmdir`
    + `rmdir -p dir` 递归删除dir

#### 第三节 文件的权限

+ 文件的属主以及属组

  默认情况下，创建文件的人便是文件的属主，用户可以使用`chown` 更改文件的属主以及属组

  `chown [optins] 属主:属组 文件列表`

+ 文件的访问权限

  用户对象方式修改访问权限 `chmod u + x,g + w,o - r file1`

  数字形式修改权限 `chmod 644 file1`

+ 软连接以及硬链接

  创建硬链接 `ln file1 file2`

  创建软连接 `ln -s file1 file2`



### 第五章 Linux系统管理

Linux系统管理主要包括如下内容，用户和组的管理，软件包的管理以及文件压缩，网络通信管理，进程控制和系统的服务启动管理等。

#### 第一节 用户和组管理

+ 用户和组的配置那文件
  + `passwd`
    + 路径 `/etc/passwd`
    + 作用 用户保存各个用户的这个账户信息
  + `/etc/shadow` 用户账户密码等信息  `newgrp`
  + `/etc/group` 用户账户的分组信息
  + `/etc/gshadow` 定义用户组口令 组管理员的信息

+ 用户和组的管理命令

  + 账户管理

    + `useradd [paras] username`

      + `-d home/dir`  宿主目录
      + `-e date` 过期时间
      + `-g group name` 组别
      + `-s shell name` shell name
      + `-u uid` 设置 uid
      + `-D Username`  设置用户名

      `useradd -d /home/hello -e 2020/05/30 -g root -s /bin/bsh -u 500 haifeng`

    + `usermod [paras] username`
      + `-l newusername username`
      + `-L username` lock
      + `-U username`  unlock 
    + `passwd [paras] uaername`
      + `-S username` 查询口令状态
      + `-l username` lock password
      + `-u username` unlock password
      + `-d username` delete password

  + 组账户管理

    + `groupadd -r groupname`  添加新的组账户
    + `groupmod -r groupname` 修改组属性
    + `groupdel -r groupname` 删除指定的组账户
    + `gpasswd` 向组内添加用户或者删除
      + `gpasswd -a username groupname` 添加
      + `gpasswd -d username groupname` 删除
      + `gpasswd -A username groupname` 设置为管理员



#### 第二节 软件包管理

Linux中的软件包管理有很多种，今天主要以`rpm`、`tar`和`yum` 学习使用

+ rpm Red Hat Package Manager 的简写
  + 安装 `rpm -ivh package name` 
    + `i` install `v` verify `h` horizontal 水平进度条显示
  + 删除 `rpm -e package name`
  + 查询 `rpm -qa`
    + `rpm -q package name`  检查是否安装 `rpm -q tar-1.30-4.el8.x86_64`
    + `rpm -qp package 文件名` 
    + `rpm -qi RPM包名`  描述信息 `rpm -qi tar-1.30-4.el8.x86_64`
    + `rpm -ql RPM包名`  包内所含文件 `rpm -ql tar-1.30-4.el8.x86_64`
    + `rpm -qf 文件名`  
  + 升级 `rpm -Uvh` RPM包名  
  + 验证 `rpm -V 包名`  -Vf 验证是否包含指定文件  -Vp 验证未安装的软件包

+ TAR tape Archive 的简写
  + 建立软件包 `tar zcvf <tar包名> 文件或目录名`
  + 查询TAR包 `tar ztf <tar包名>`
  + 释放TAR包 `tar zxvf <tar包名>`

+ 源代码包的编译以及安装
  1. 释放TAR包
  2. 查看并阅读包内带有的软件安装说明
  3. 进行编译准备 `./configure`
  4. 进行编译 `make`
  5. 进行软件安装 `make install`
  6. 清楚临时文件 `make clean`

#### 第三节 网络通信管理

+ 网络的基本配置

  Linux下的网络配置文件

  | 配置文件名 | 功能 |
  | ---- | ------------ |
  | /etc/sysconfig/network-scripts/ifcfg-eth0 | x系统启动时候，用来初始化网络的文件 |
  | /etc/sysconfig/network | 包含主机基本的网络信息，用于系统启动 |
  | /etc/xinetd.conf | 定义了由超级进程 xinted启动的网络服务 |
  | /etc/hosts | 完成了主机名映射IP地址的功能 |
  | /etc/hosts.conf | 配置域名服务客户端的配置文件 |
  | /etc/resolv.conf | 配置域名客户端的IP地址 |
  | /etc/protocols | 设定主机使用的协议以及各个协议的协议号 |
  | /etc/services | 设定主机不同端口的网络服务 |
  |            |      |

  网络管理工具 `netconfig`

+ 常用的网络通信命令

  + write 实时给其他用户发送信息 `write a pts/1 hello world`

  + wall 广播方式给系统中所有用户发送信息 `wall message`

  + messg 设置消息的禁止与允许 `messg y/n`

  + talk 全双工方式实时与某用户交流 `talk username [tty]`

  + mail 命令详解

    用户所用的邮件地址是 `/var/spool/mail/a`

    + 撰写和发送邮件

      ```
      $mail uasername
      Subject: topic
      text
      Ctrl + D
      Cc:username
      
      ```

    + 以文件的内容作为邮件的正文发送邮件

      ```
      mail -s topic username < filename
      ```

    + 接受以及阅读邮件

      + 直接输入`mail`可以查看收件箱中的mail

      + 如下时mail的常用命令

        | 符号        | 含义               |
        | ----------- | ------------------ |
        | & n         | 阅读n编号的邮件    |
        | ！command   | 调用shell命令      |
        | e           | 编辑刚浏览过的邮件 |
        | d n         | 删除n编号的邮件    |
        | r           | 回复刚才浏览的邮件 |
        | x 或 q      | 退出               |
        | h           | 浏览所有邮件       |
        | ？或者 help | 获取帮助           |

#### 第四节 进程管理

+ 进程概述

  创建进程的目的，就是使多个程序可以并发的执行，从而提高系统的资源利用率以及吞吐量，进程是指程序实体的运行过程，是系统进行资源分配和调度的独立单位

  + 程序只是一个静态的指令集合，而进程是一个程序的动态执行过程
  + 程序和进程并没有一一对应的关系

  进程分类

  + 系统进程  系统环境平台所加载运行的进程
  + 用户进程 与终端连接，用户执行的进程
  + 守护进程  没有屏幕显示， 后台等待用户或者系统的请求，网络多用户系统工作绝大多数都是通过守护进程进行的

+ 守护进程的管理

  + at 作业  处理只执行一次的任务

    + 创建作业 

      ```
      at sometime
      commandlist
      ...
      Ctrl + D
      ```

    + 时间设置

      ```
      at now + 1day
      at 1:00am May 1
      at 2:10pm +3day
      ```

    + 显示 at 作业 `at -l`

    + 删除at作业 `at -d ID`

  + cron作业  定时作业

    crontab命令用来实现cron作业，cron作业可以分为 系统cron作业以及用户cron作业两种

    + cron作业含义 cron是一个守护进程，一个标准的后台服务程序，使用cron作业服务必须安装vixie-cron RPM软件包 运行 crond服务
    + cron作业配置文件路径`/etc/crontab` 或者 `/var/spool/cron/username/`

    + 常用命令

      + `crontab [-u user ] filename` 创建用户任务
      + `crontab -e`  编辑用户cron任务
      + `crontab -l` 显示用户任务
      + `crontab -r` 删除用户任务

    + cron文件含义

      | 表头含义 | Min  | Hour | Day of Mon | Mon  | Day of Work | Comment |
      | -------- | ---- | ---- | ---------- | ---- | ----------- | ------- |
      | 取值范围 | 0-59 | 0-23 | 1-31       | 1-12 | 0-6         |         |

      

+ 进程的控制命令

  + ps 进程查看

    + 常用命令 `ps -ef` 或者 `ps -aux`

    + 其他常用参数有

      | 选项 | 说明                       | 选项 | 说明                             |
      | ---- | -------------------------- | ---- | -------------------------------- |
      | -a   | 显示所有用户进程           | -f   | 显示i进程详细信息                |
      | -e   | 显示包含系统进程的全部进程 | -x   | 显示没有控制终端的进程           |
      | -l   | 显示进程的详细列表         | -u   | 显示进程名以及启动时间等详细信息 |

    + 进程状态含义

      | 符号 | 含义                 | 符号 | 含义       |
      | ---- | -------------------- | ---- | ---------- |
      | S    | 睡眠状态             | Z    | 僵尸状态   |
      | W    | 没有驻留页           | D    | 不间断睡眠 |
      | R    | 运行或者准备运行状态 | T    | 停止或追踪 |
      | I    | 空闲                 | N    | 低优先级   |

      

  + free  显示内存的使用情况

  + top  实时显示系统进程

    + 功能按键及其介绍

      | P    | 根据CPU使用时间排序  |
      | ---- | -------------------- |
      | M    | 根据内存使用排序     |
      | T    | 根据进程执行时间排序 |

    + 监视指定用户 按下U键， 输入用户名
    + 指定刷新时间 `top -d 1`
    + 删除指定进程 按下K，输入进程号，然后回车或者输入 15

  + 进程延续执行 `sleep 2;ls`
  + 杀死进程 `kill -9 进程ID`

+ 进程的前台与后台控制

  + 命令后台执行 `commands&`
  + 查看后台任务 `jobs`
  + 后台调前台 `fg ID`
  + 前台调后台 `bg ID`
  + 前台转后台 `Ctrl + Z`

#### 系统的服务管理

+ INIT进程以及其配置文件

  INIT进程是由Linux内核引导运行的，是系统运行的第一个进程，也是所有服务进程的父进程

  + 配置文件路径 `/etc/inittab`

+ 系统服务管理常用命令

  + 查看运行级别 `runlevel`
  + 查看服务启动状态 `chkconfig --list`
  + 设置系统服务的启动状态 `chkconfig --level 2345 httpd on`
  + 转换运行级别 `init number`
  + service服务状态控制
    + `service 服务名 [status|start|stop|restart]`

#### 磁盘操作管理

+ 查看磁盘分区情况 `fdisk -l`

+ 磁盘文件系统的挂载

  + 使用命令手动挂载

    ```
    mount -t vfat /dev/sda1 /mnt/disk1
    mount -t vfat -o iocharset = cp936 /dev/sda1 /mnt/disk1  #解决中文乱码
    mount -t iso9660 -o loop linux1.iso /mnt/cdrom  #访问ISO文件
    ```

    拓展： 用户可以使用`mkisofs` 创建ISO镜像文件

  + 自动加载

    + 原理：Linux操作系统的文件信息都写在了`/etc/fstab`内，在系统中引导并自动加载该文件内容中的文件系统，该文件中的参数分别表示 设备名称、挂载目录、文件系统类型、参数、Dump（是否检查文件系统）、Pass（检查文件系统顺序）

  + 卸载

    + `umount /dev/cdrom`
    + `umount /etc/cdrom`

+ 常用的磁盘操作命令

  + 磁盘分区 `fdisk -l`

  + 磁盘统计 `du [-a] Dirname`

  + 磁盘空间统计 `df - [ahil] ` a   `df -lh`

    + `-a` 显示所有的文件系统的信息 包括 swap 和 proc
    + `-h` 以最合适的容量单位显示
    + `-i` 显示文件节点 inode的使用情况
    + `-l` 只显示本地系统文件的使用情况

    + 不加参数显示所有已挂载文件系统的磁盘使用信息

 

#### 第六章 VI编辑器

+ VI编辑器启动

  ```
  vi +n filename    //打开以filename命名的文件，光标停在第n行
  vi + filename     //打开以filename命名的文件，光标停在最末行
  vi - r filename   //系统瘫痪后 回复filename文件
  vi + /word filename  //从文件中找出 word 第一次出现的位置
  ```

+ 存盘以及退出

  ```
  : w <回车> 
  ：w filename <回车>  //另存文件
  ：q <回车> //退出
  ：wq <回车>  //存盘后退出
  ：q! <回车>  //强行无条件退出
  ```

+ 命令行下的光标移动

  ```
  h j k l 左 下 上 右
  移至行首 0
  移至行尾 $
  快速跳转某行 nG
  快速跳转某列 n|
  回到首行 gg
  回到末行 GG
  删除光标之后单个字符 x 删除光标之前多个字符 nx dn<enter>
  删除光标之前单个字符 X 删除光标之前多个字符 nX dn|<enter>
  删除当前行以及下面一行 d <enter>
  删除整行 dd
  删除当前行以及以上n-1行 ndd
  删除当前行至n行 dnG
  删除当前行至末尾行 dG
  删除光标至行尾 D 或者 d$
  
  撤销单步骤 u
  撤销单行操作 U
  
  向下合并n行 3J
  
  移动按照8个空格为单元移动
  >n  不包括当前行，以下n行 右移动8个空格
  n>> 包括当前行， 右移动8个空格
  
  检索命令
  向后检索  /word 
  向前检索  ？word
  n重复执行 N反向重复执行
  
  命令行模式命令
  定位行首 :22<enter>
  定位匹配字符行首 :/word/<enter>   :?word?<enter>
  
  全局替换命令 :g/pattern/command list
  屏幕输出 g/word/p
  单次替换 g/word/s//word1/
  多次替换 g/word/s//word1/g
  多次替换并显示 g/word/s//word1/gp
  多次替换并确认 g/word/s//word1/gc  
  多行标记替换  g/word/s/word1/word2/g  如果当前行有word 则用word2替换word1
  不匹配模式替换 g!/pattern/command list
  开头插入空格 g/^/s//    /g
  正则替代文本 s/pattern/text/option  s/is/are/gc  操作对象当前行
  
  插入shell命令
  仅仅执行命令 :!command
  读取命令并插入 :r!command
  
  恢复文件 :recover
  ```



### 第七章 shell程序设计

#### 第一节 shell文件创建以及执行

建立多使用`vi`创建shell文件

执行有如三种办法：

+ `./test`
+ `sh test`
+ `chmod a+x test` `test`

#### 第二节 shell的变量

+ 环境变量大多数都是在 `/etc/profile`中进行初始化的，用户自定义的变量则是在自己的根目录`/home/username/.bash_profile`初始化的

+ 打印并显示环境变量值 `echo $PWD`

+ 常用的环境变量有 `PATH MAIL PWD PS1 ENV `等等

+ 只读的环境变量 

  + `$0` shell程序名
  + `$1-$9` 命令行参数值
  + `$*` 所有命令行参数值
  + `$#` 命令行参数值的总数
  + `$$` 当前进程ID PID
  + `$?` 执行最后一条命令的进程状态 
  + `$!` 在后台运行的最后一个进程的进程ID

+ `set` 可以给位置参数赋值

+ `shift` 位置参数向左移动

+ 用户自定义变量

  + 字母或者下划线打头的字母、数字和下划线序列
  + 区分大小写
  + 默认初始化值是字符串

+ 自定义格式

  + `变量名 = 字符串`

    ```
    mydir=/home/haifeng
    echo $mydir
    ```

  + 变量中含有空格，制表符或换行符，应该用双引号括起来

    ```
    myName = "Hai Feng"
    echo $myName
    ```

  + shell变量可以直接与字符串拼接使用

    ```
    [root@iZ2zehxps1f8a818z6i7xjZ shell+te]# s1=ing
    [root@iZ2zehxps1f8a818z6i7xjZ shell+te]# echo walk$s1 or runn$s1 or eat$s1
    walking or running or eating
    
    [root@iZ2zehxps1f8a818z6i7xjZ shell+te]# path=hone/huang/
    [root@iZ2zehxps1f8a818z6i7xjZ shell+te]# echo my path is ${path}m1.c
    my path is hone/huang/m1.c
    ```

  + 使用 `set`可以查看所有的用户自定义变量

#### 第三节 Shell中的特殊字符

+ 通配符

  | *    | 任意个字符串                 |
  | ---- | ---------------------------- |
  | ？   | 任意一个字符                 |
  | []   | 该字符组所限定的任意一个字符 |
  | ！   | 非                           |

+ 引号

  + 双引号 除了`$ 倒引号`` 反斜线\`仍然保留特殊功能外，其余字符则作为普通字符串处理

  ```
  [root@iZ2zehxps1f8a818z6i7xjZ ~]# path="/home/haifeng"
  [root@iZ2zehxps1f8a818z6i7xjZ ~]# echo "the path is $path "
  the path is /home/haifeng 
  ```

  + 单引号 单引号内的所有字符都会当为普通字符
  + 倒引号 测试失败

+ 顺序操作符号
  + 顺序执行符号 分号 `;`
  + 逻辑与 `&&` 前面执行成功才会执行后面程序
  + 逻辑或 `||` 前面命令执行失败，才会执行后面程序
+ 注释符号，反斜线，后台操作符号
  + 注释符号 `#`
  + 反斜线 转移符号 `\`
  + 后台操作符号 `&`

#### 第四节 Shell编程中的输入输出命令

+ 输入重定向 command < input-file
+ 输出重定向 command > output-file
+ 输出附加命令 comand >> output-file
+ 标准错误重定向 command 2> error file

+ shell 输入 输出命令

  + read命令 `read 变量1 变量2 ...`

  + echo命令 标准输出命令

    | 字符 | 含义                 | 字符 | 含义                   |
    | ---- | -------------------- | ---- | ---------------------- |
    | \h   | 退格                 | \t   | 水平制表符             |
    | \c   | 不将光标移动到下一行 | \    | 垂直制表符             |
    | \f   | 换页                 | \\\  | 反斜线                 |
    | \n   | 换行                 | \\ON | ASCII码为八进制N的字符 |
    | \\r  | 回车                 |      |                        |

#### 第五节 Shell程序控制语句

+ if语句--两路分支if语句

  ```
  if 判断条件
  then 命令1
  else 命令2
  fi
  ```

  示例程序

  ```
  echo "Please type a user name"
  read user
  if who|grep $user
  then echo "hello $user!"
  else echo "user has not log in the system"
  fi
  ```

+ if语句--多路分支

  ```
  if 判断条件1
  then 命令1
  elif 判断条件2
  then 命令2
  ...
  else 命令n
  fi
  ```

+ 测试语句

  测试语句的两种表示方法 `test -f "$1" ` 或者 `[ -f "$1" ]`

  注意：

  ```
  1. test语句中使用shell变量，为表示完整以及避免歧义，应该使用双引号引起来
  2. 任何一个运算符、圆括号或花括号的前后至少需要一个空格
  3. 增加 "\" 表示还是一行语句
  ```

  

  + 文件测试

    + `-r file  `    用户可读

    + `-w file`  用户可写
    + `-x file`  用户可执行
    + `-f file`  存在 普通文件
    + `-d file`  存在 目录文件
    + `-p file`  存在 FIFO文件
    + `-s file`  存在 非空文件

  + 字符串测试

    + `str`  不是空字符串 测试为真
    + `str1 = str2`  判断等于
    + `str1 != str2`   判断不等于
    + `-n str`  长度不为0 测试为真
    + `-z str` 长度为0  测试为真

  + 数值测试

    + `n1 -eq n2`  等于

    + `n1 -ne n2`  不等于

    + `n1 -lt n2`  小于

    + `n1 -le n2 ` 小于等于

    + `n1 -gt n2`  大于

    + `n1 -ge n2`  大于等于
    
  +  逻辑操作符号
  
    + `!`  逻辑非
    + `-a` 逻辑与
    + `-o`  逻辑或
    + `()`  表达式分组
  
  + case语句
  
    ```
    case string1 in
    str1)
    	commands-list;;
    str2)
    	commands-list;;
    ...
    strn)
    	command-list;;
    esac
    ```
  
    注意：
  
    1.  每条命令两个 分号
    2. 正则表达式可以使用通配符号
    3. 如果一个正则表达式是由多个模式组成，那么各个模式之间应该用 "|" 分割开
    4. 各正则表达式是唯一的，不应该重复出现
    5. case 语句若没有执行任何命令，退出值为0
  
  + for 语句
  
    ```
    for variable [in argument-list]
    do
    	command-list
    done
    ```
  
  + while语句
  
    ```
    while expression
    do
    	command-list
    done
    ```
  
  + until语句 只有表达式为假的时候执行
  
    ```
    until expression
    do
    	command-list
    done
    ```
  
  + break 循环体退出
  
  + continue 结束当前循环，跳入下一循环
  
  + expr 算数表达式
  
  + 退出脚本程序命令 exit[n]
  
  + 自定义函数
  
    ```shell
    Function()
    {
    	command-list
    }
    ```

### 第8章 Linux系统的网络服务

#### 第一节 NFS网络文件系统

Sun公司开发的，通常多用于Unix系统，连接网络上计算机共享文件的一种方法

建立步骤

+ 安装 portmap，nfs-utils两个软件包，并启动相关服务
+ 主机对共享文件下发权限
+ 客户机针对下发的权限把远程文件挂载到本地目录