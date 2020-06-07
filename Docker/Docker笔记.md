wget https://www.kernel.org/pub/linux/utils/util-linux/v2.24/util-linux-2.24.tar.gz  
tar -xzvf util-linux-2.24.tar.gz  
cd util-linux-2.24/  
./configure --without-ncurses  
make nsenter  
sudo cp nsenter /usr/local/bin  
————————————————
版权声明：本文为CSDN博主「hahachenchen789」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/hahachenchen789/java/article/details/80523296Docker基础知识学习

如下笔记是学习自Bilibili视频教程[尚硅谷_Docker核心技术（基础篇）](https://www.bilibili.com/video/BV1Vs411E7AR?from=search&seid=952349996604499175),如有任何疑问，请后续自己学习教程

学习Docker前面基础准备

+ Linux 如果没有基础，可以参考[韩顺平老师的视频教程](https://www.bilibili.com/video/BV1dW411M7xL?from=search&seid=675850875753289639)
+ Maven/Git相关知识 [Git/Github教程](https://www.bilibili.com/video/BV1pW411A7a5?from=search&seid=14380393504884378076)

Docker是基于Go语言开发的，

Docker基础篇

+ 什么是镜像，什么是容器
+ 容器虚拟化技术和虚拟机有什么区别

Docker高级篇

### Docker简介

#### Docker出现背景

传统上开发工程师提交的产物给运维基本上都是代码或者war包的形式，前提是在本机一切都是运行正常的情况，但是运维部署因为一些别的原因会导致一些问题，环境或者配置不一样往往导致出现一些问题，于是Docker技术应用而生，将所有的代码，环境，以及底层实现完全拷贝出来，

docker三要素

+ 镜像 
+ 容器
+ 仓库

互联网买哦对比较的情况是服务器集群分布，

#### Docker理念

Docker是基于Go语言实现的云开源项目，Docker的主要目标是“Build ship and run any app, anywhere”

#### Docker作用

Docker容器又叫做容器虚拟，

以下是虚拟机相关知识，虚拟机连硬件都是需要模拟的

![image-20200411210912219](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200411210912219.png)

虚拟机缺点

+ 资源占用多
+ 冗余步骤多
+ 启动慢

Docker比虚拟机快的原因

+ docker有比虚拟机更少的抽象层，由于docker不需要Hypervison实现硬件资源虚拟化，运行在docker容器安徽国内的程序直接使用的都是实际物理机的硬件资源，因此在CPU,内存利用率上docker将会在效率上有明显优势
+ docker利用的是宿主机的内核，而不需要Guset OS，因此，当新建一个容器时，docker不需要和虚拟机一样重新加载一个操作系统内核，因而避免引寻，加载操作系统内核返个比较费时费资源的过程，当新建一个虚拟机时，虚拟机软件需要加载Guset OS,返回新建过程十分钟级别的，而docker由于直接利用宿主的操作系统，则省略了返回过程，因此创建一个docker容器只需要几秒钟。

![image-20200412203934093](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200412203934093.png)

以下介绍Docker特点

![image-20200411211244498](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200411211244498.png)



Docker和传统虚拟机的不同之初

+ 传统虚拟技术是虚拟出一套硬件之后，在其上运行一个完整操作系统，在该系统上在运行所需应用进程
+ 而容器内的应用直接运行于宿主的内核，容器呢没有自己的内核，而且也没有进行硬件虚拟，因此容器要比传统虚拟机更为轻便
+ 每个容器之间相互隔离，每个容器有自己的文件系统，容器之间进程不会相互影响，能区分计算资源

![image-20200411212016518](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200411212016518.png)

![image-20200411212104700](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200411212104700.png)

#### Docker下载

hub.docker.com docker的云端存储仓库

### Docker实际应用

#### Docker安装准备知识

Docker安装在Centos必须是6.5以上，因为是基于Go语言编写的，2014出来，2017年开始火爆

Docker支持以下的CentOS版本

+ CentOS (64-bit)
+ CentOS 6.5 (64-bit)或更高的版本

前提条件

+ 目前，CentOS仅发行版本中的内核支持Docker
+ Docker运行在CentOS 7上，要求系统为64位，系统内核版本为3.10以上
+ Docker运行在CentOS-6.5 或更高版本CentOS以上，要求系统为64位，系统内核版本为2.6.32-431或者更高版本

如下介绍安装步骤

1. 查看系统内核信息 `uname -r`
2. 查看已安装Centos版本信息 `lsb_release -a` 或者使用命令 `cat /etc/redhat-release`

#### Docker的架构图

Docker底层原理

Docker是一个CS架构的系统，Docker守护进程运行在主机上，然后通过Socket链接从客户端访问，守护进程从客户端接受命令并管理运行在主机上的容器， <font color="#FF0000">容器，是一个运行时环境，就是我i们前面说到的集装箱</font>>

架构图参照如下所示

![image-20200412152139849](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200412152139849.png)

Client  连接客户端 

Registry 注册仓库，远程仓库会有各种依赖以及

Image 拉取到本地就叫做镜像

Container 镜像的实例就叫做容器

镜像/容器

Docker镜像(Image)就是一个<font color="#FF0000">只读</font>的模板，镜像可以用来创建Docker容器，一个镜像可以创建很多容器，**所以容器与镜像的关系类似于面向对象中的对象和类。**

Docker利用容器(Container)独立运行的一个或一组应用，容器使用镜像创建的运行实例

它可以启动，开始，停止，删除，每个容器都是相互隔离的

可以把容器看作一个简易版的Linux环境(包括root用户权限，进程空间，用户空间和网络空间等)和运行在其中的应用程序

容器的定义和镜像几乎一模一样，也是一堆层的统一视角，我i以区别在于容器的最上面那一层是可读可写的。

仓库

仓库(Repository)是集中存放镜像文件的场所

仓库(Repository)和仓库有注册服务器(Registry)是有区别的，仓库注册服务器上往往存放着多个仓库，每个仓库中又包含多个镜像，每个镜像有不同的标签(tag)

仓库分为公开仓库(Public)和私有仓库(Private)两种形式，

最大的公开仓库是Docker Hub(https://hub.docker.com/)  国内公开仓库包括阿里云，网易云等

需要正确的理解仓库/镜像/容器这几个概念

Docker本身是一个容器运行载体或者称之为管理引擎，我们把我们把应用程序和配置依赖打包好形成一个可交付的运行环境，这个打包好的运行环境就似乎image镜像，只用通过这个镜像才可以生成Docker容器，Image可以看成容器的模板，Docker根据image文件生成容器的实例，同一个image文件，可以生成多个同时运行的容器实例

+ image文件生成的容器实例，本身就是一个文件，称为镜像文件
+ 一个容器运行一种服务，当我们需要的是偶，就可以通过Docker客户端创建一个对应的运行实例，也就是我们的容器
+ 至于仓储，就是放了一堆镜像的地方，我们可以把镜像发布到仓储中，需要的时候从仓储上拉下来即可

#### Centos安装

centos版本不一样，对应的安装步骤也不一样

1. CentOS 6.8
   + `yum install -y epel-release`
   + `yum install -y docker-io`
   + 安装后的配置文件 `/etc/sysconfig/docker`  或者`/usr/bin/docker`
   + 启动Docker后台服务 `service docker start`
   + Docker版本验证 `docker version`



Docker hello world镜像验证

阿里云镜像加速配置

寻找路径是 `产品分类-> 云计算基础-> 容器镜像服务->镜像中心->镜像加速器` CentOS配置如下

```shell
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://kz9z9e4m.mirror.aliyuncs.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker

```





#### Docker hello world 学习

输入命令 `docker run hello-world`



```shell
`[root@iZ2zehxps1f8a818z6i7xjZ docker]# docker run hello-world`
`Unable to find image 'hello-world:latest' locally`
`Trying to pull repository docker.io/library/hello-world ...` 
`latest: Pulling from docker.io/library/hello-world`
`1b930d010525: Pull complete` 
`Digest: sha256:f9dfddf63636d84ef479d645ab5885156ae030f611a56f3a7ac7f2fdd86d7e4e`
`Status: Downloaded newer image for docker.io/hello-world:latest`

`Hello from Docker!`
`This message shows that your installation appears to be working correctly.`

`To generate this message, Docker took the following steps:`

  1. `The Docker client contacted the Docker daemon.`
  2. `The Docker daemon pulled the "hello-world" image from the Docker Hub.`
     `(amd64)`
  3. `The Docker daemon created a new container from that image which runs the`
     `executable that produces the output you are currently reading.`
  4. `The Docker daemon streamed that output to the Docker client, which sent it`
     `to your terminal.`

`To try something more ambitious, you can run an Ubuntu container with:`
 `$ docker run -it ubuntu bash`

`Share images, automate workflows, and more with a free Docker ID:`
 `https://hub.docker.com/`

`For more examples and ideas, visit:`
 `https://docs.docker.com/get-started/`

`[root@iZ2zehxps1f8a818z6i7xjZ docker]#` 

```



 `docker run +++` 后面需要run一个镜像，这个形象需要生成类的模板

docker run命令整个运行流程如下

![image-20200412202403177](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200412202403177.png)



### Docker命令以及实际操作

#### 帮助命令

+ docker version
+ docker info  自身容器相关详细信息的一个说明
+ docker --help  帮助命令

#### 镜像命令

鲸鱼背上有集装箱

蓝色的大海里面 -- 宿主机系统WIN10

鲸鱼 -- docker

集装箱 -- 容器实例  from 来自我们的镜像模板

+ 列出本地镜像 docker images
  + -a 列出本地所有镜像，含有中间镜像层
  + -q 只显示镜像ID
  + --digests 显示镜像的摘要信息
  + --no-trunc 显示完整的镜像信息
+ 在Docker Hub搜索镜像 docker search 某个XXX镜像名称 
  + --no-trunc 显示完整镜像描述
  + -s 列出收藏数不小于指定值的镜像
    + --filter=stars=n
  + --automated  只列出 automated build类型的镜像
+ docker pull 某个镜像名字
+ docker rmi 某个镜像名字ID
  + 删除单个经镜像 `docker rmi -f 镜像`
  + 删除多个 `docker rmi -f hello-world nginx`
  + 删除全部 `docker rmi -f $(docker images -qa) `

#### 容器的相关命令

有镜像才能创建容器，这是根本前提（下载一个CentOS镜像演示）

+ 新建并启动容器

  + `docker run [options] IMAGE [COMMAND] [ARG...]` 依照镜像新建镜像容器
  + options 说明
    + --name="容器新名字" 为容器制定一个名称
    + -d 后台运行容器，并且返回容器ID，也即启动守护式容器
    + -i (interactive)以交互模式运行容器，通常与 -t 同时使用
    + -t (tty)为容器分配一个伪输入终端，通常与-i一起使用
    + -P 随机端口映射
    + -p 指定端口映射，有如下四种方式
      + ip:hostPort:containerPort
      + ip::containerPort
      + hostPort:containerPort
      + containerPort

  实际命令 `docker run -it id`

  使用镜像 centos:latest以交互模式启动一个容器，在容器内执行/bin/bash命令

  `docker run -it centos /bin/bash`

+ 列出当前所有正在运行的容器

  `docker ps [OPTIONS]` docker运行的全部进程

  + -a 列出当前所有正在运行的容器 + 历史上运行过的容器
  + -l 显示最近创建的容器
  + -n 显示最近n个创建的容器
  + -q 静默模式 只显示容器编号
  + --no-trunc 不截断输出

+ 退出容器

  + exit 容器停止推出
  + Ctrl + P + Q  容器不停止推出

+ 再次进入容器

  + 创建一个守护状态的docker容器 `docker run -itd ubuntu:16.04 /bin/bash `
  +  docker attach方式进入容器 `docker attach dockerID`

  

  + 进入一个已经运行的容器  `docker exec -it 775c7c9ee1e1 /bin/bash  `





> nsenter：namespace enter。
>
> 需要安装nsenter，如果没有安装的话，按下面步骤安装即可（注意是主机而非容器或镜像）
>
> 具体的安装命令如下
>
> wget https://www.kernel.org/pub/linux/utils/util-linux/v2.24/util-linux-2.24.tar.gz  
>tar -xzvf util-linux-2.24.tar.gz  
> cd util-linux-2.24/  
> ./configure --without-ncurses  
> make nsenter  
> sudo cp nsenter /usr/local/bin  
> 
> nsenter可以访问另一个进程的名称空间。所以为了连接到某个容器我们还需要获取该容器的第一个进程的PID。可以使用docker inspect命令来拿到该PID。
>
> docker inspect  container ID
>
> sudo docker inspect 44fc0f0582d9  
>可以显示出PID
> 
> 最后利用nsenter：
>
> sudo nsenter --target 3326 --mount --uts --ipc --net --pid 
>3326就是PID。
> 
> 该方法的缺点在于步骤比较繁琐。
>————————————————
> 





+ 启动容器
  
  + docker start 容器名或者ID
  
+ 重启容器
  
  + docker restart 容器名或者ID
  
+ 停止容器
  
  + docker stop 容器名或者ID
  
+ 强制停止容器
  
  + docker kill 容器名或者ID
  
+ 删除已停止容器
  
  + docker rm 容器名或者ID
  
+ 一次性删除多个容器
  + docker rm -f $(docker ps -a -q)
  + docker ps -a -q | xargs docker rm
  
+ **重要**

  + 启动守护式容器 `docker run -d centos` 一定启动成功过

    + docker容器后台运行，就必须有一个前台进程
    + 某种情况下， -d -i 都得有 

    ![image-20200416212924781](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200416212924781.png)

  + 查看容器日志 `docker logs -f -t --tail 容器id`
    
    + 利用centos终端执行循环每间隔2秒输出 hello zzyy `docker run -d centos /bin/sh -c "while true:do echo hello zzyy;sleep 2;done"`
  + 查看容器内运行的进程 `docker top 容器ID`
  + 查看容器内部细节 `docker inspect 容器ID`
  + 进入正在运行的容器内部
    + attach 直接进入容器启动命令的终端，不会启动新的进程
    + exec 在容器中打开新的终端，可以启动新的进程
  + 从容器拷贝文件至主机 
    
    + docker cp 容器ID:容器内的路径 目的主机路径

sudo docker run -itd ubuntu:16.04 /bin/bash  

sudo docker attach 44fc0f0582d9 



![image-20200416220531264](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200416220531264.png)

![image-20200416220547252](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200416220547252.png)



docker exec -it 775c7c9ee1e1 /bin/bash  

15901515172  liuyicheng

docker exec -it docker /bin/bash  

### Docker镜像原理

#### 镜像是什么

镜像是一种轻量级的，可执行的独立软件包，用来打包软件运行环境和基于运行环境开发的软件，它包含运行某个软件所需的所有内容，包括代码，运行时，库，环境变量和配置文件

+ UnionFS 联合文件系统

  UnionFS(联合文件系统) Union文件系统是一种分层、轻量级并且高性能的文件系统，它支持对文件系统的修改作为一次提交来一层层的叠加，同时可以将不同目录挂载到同一个虚拟文件系统下(unite serveal directions into a single virtual filesystem), Union文件系统是Docker镜像的基础，镜像可以通过过分层来进行继承，基于基础镜像(没有父镜像)，可以制作各种具体的应用镜像

  特性：一次同时加载多个文件系统，但从外面看起来，只能看到一个文件系统，联合加载会把各层文件系统累加起来，这样最终的

+ Docker镜像加速原理

  ![image-20200418102143218](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200418102143218.png)

  ![image-20200418102424970](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200418102424970.png)

+ 分层的镜像

  ![image-20200418103255065](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200418103255065.png)

+ 为什么Docker要采用分层的结构

  最大的好处是共享资源

  比如 有多个镜像抖胸相同的base镜像创建而来，那么宿主机只需要在磁盘上保留一份base镜像，同时内存中也只需加载一份base镜像，就可以为所有容器服务了，而且镜像的每一层都可以被共享

#### 镜像特点

Docker镜像都是只读的，当容器启动时，一个新的可写层被加载到镜像的顶部，这一层通常被称作“容器层”，容器层之下的都被称作“镜像层”

#### 镜像commit

+ `docker commit `提交容器副本使之成为一个新的镜像`
+ `docker commit -m="提交的描述信息" -a="作者" 容器ID 要创建的目标镜像名:[标签名]docker commit -a="haifeng" -m="test" 35ab749ac45d atbendi/mytomcat:1.2`
+ `docker commit -a="haifeng" -m="test" 35ab749ac45d atbendi/mytomcat:1.2`

#### 补充知识

docker运行一个容器后想后台守护进行，run后面添加`-d`参数

`docker run -d -p 6666:8080 tomcat`

#### 案例演示

1. 从Hub上下载tomcat镜像到本地，并运行成功

   `docker run -it -p 8888:8080 tomcat`

   + -p 主机端口：docker容器端口
   + -P随机分配端口
   + -i 交互
   + -t终端

   `ss -lntpd | grep :22`

   `netstat -tnlp | grep :22`

   lsof -i tcp:22

### Docker容器数据卷

#### 是什么

docker运行的数据持久化，也就是保存下来的意思，类似于redis中的RDB 和 AOF模式

![image-20200418163033330](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200418163033330.png)

#### 能干啥

容器的持久化 + 容器之间能够贡献数据

![image-20200418163451322](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200418163451322.png)

### 容器数据卷用v命令添加

容器内添加

#### 直接命令添加

+ 命令 `docker run -it -v /宿主机绝对路径目录:/容器内目录 镜像名`

  -v 含有新建的功能相当于 mkdir

  `docker run -it -v  C:\Users\HD.huanghf\docker_test\:/var/test/ centos`

+ 查看数据卷是否挂在成功

  `docker inspect 容器ID` 查找 volume 字段，查看是否成功挂载

+ 容器和宿主机之间文件共享

  实时同步

+ 容器停止退出后，主机修改后数据是否同步

  同步

+ 命令

  `docker run -it -v /宿主机绝对路径目录:/容器内目录:ro镜像名` 此时在容器内只能对数据卷信息读取，而不能创建

#### DockerFile添

+ 根目录下新建mydocker文件夹并进入

+ 可在Dockerfile中使用VOLUME命令来给镜像添加一个或者多个数据卷

  命令： `VOLUME["/dataVolumeContainer"，"/dataVolumeContainer2","/dataVolumeContainer3"]`

  说明： 出于可移植和分享的考虑，用-v主机目录:容器目录这种半大不能够直接在DockerFile中实现，由于宿主目录是依赖于特定宿主机的，并不能保证在所有的宿主机上都存在这样的塔顶目录

+ FIle构建

  > \# volume test
  >
  > FROM centos
  >VOLUME ["TEST01","TEST02"]
  > CMD echo "finished,----success1"
  > CMD /bin/bash
  
+ build 后生成镜像

  `docker build -f dockerFile文件路径 -t centos .` 

  `docker build -f /mydocker/dockerfile2 -t haifeng/centos .`

  注意build后面有个`.`表示当前目录

  将当前目录下的`docker_test` 挂载到虚拟机上，并创建一个新的image

  ![image-20200419100623245](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200419100623245.png)

  



+ run容器

  ![image-20200419100913706](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200419100913706.png)

+ 通过上述步骤，容器内的卷目录地址已经知道，对应的主机目录在哪

  ![image-20200419101322694](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200419101322694.png)

+ 主机应对应默认地址

#### 数据卷容器

命名的容器挂在数据卷，其他容器通过挂在这个（父容器）实现数据共享，挂载数据卷的容器，称之为数据卷容器

总体介绍

+ 以上一部新建的镜像 zzyy/centos为模板，并运行容器dc01/dc02/dc03
+ 他们已经具有容器 TEST01 TEST02

容器件传递共享(--volumes-from)

1. 先启动父容器 dc01 -> 在TEST02 增加内容

   ![image-20200419105110267](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200419105110267.png)

2. dc02/dc03继承自dc01 

   + --volumes-from

   + 命令

     `docker run -it --name dc02 --volumes-from dc01 ttyy/centos`

     ![image-20200419105343162](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200419105343162.png)

3. 回到dc01可以看到02/03各自添加的内容都能共享

   ![image-20200419105621027](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200419105621027.png)

4. 删除dc01，dc02修改后dc03可否访问

5. 删除dc02后 dc03可否访问

6. 新建dc04 继承dc03后 在删除 dc03

7. **结论 容器之间配置信息的传递，数据卷的生命周期一直持续到没有容器使用它**为止



### DockerFile 解析

前面知识回顾

+ 手动编写一个dockerFile文件
+ 有了文件之后，直接docker build 文件执行，获得一个自定义的镜像
+  docker run

#### 文件初解析

> FROM scratch  -- 基础镜像 源镜像
>
> MAINTAINER the CentOS Project <cloud-ops@centos.org>  -- 作者 + 邮箱
>
> ADD c68-docker.tar.xz
>
> LABEL 
>
> \# Default command 默认的执行命令
>
> CMD ["/bin/bash"]

#### Dockerfile内容基础知识

1. 每条保留字指令都必须为大写字母且后面要跟随至少一个参数
2. 指令按照从上到下，顺序执行
3. /#表示注释
4. 每条指令都会创建一个新的镜像层，并对镜像进行提交

#### Docker执行Dockerfile的大致流程

1. docker从基础镜像运行一个容器
2. 执行一条命令并对容器做出修改
3. 执行类似docker commit的操作提交一个新的镜像层
4. docker在基于刚刚提交的镜像在运行一个新的容器
5. 执行dockerfile中的吓一跳指令直到所有指令都执行完成

#### 小总结

![image-20200419144059450](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200419144059450.png)

![image-20200419144333252](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200419144333252.png)

#### Dockerfile 体系结构（保留字指令）

+ FROM  基础镜像，当前新镜像是基于那个镜像的

+ MAINTAINER  镜像维护者的姓名和邮箱地址

+ RUN  容器构建时候需要运行的命令

+ EXPOSE  实例启动对外暴露的端口号

+ WORKDIR 创建容器后，终端默认登陆的进来工作目录，一个落脚点

+ ENV  构建镜像过程中设置环境变量

+ ADD  拷贝+解压缩

+ COPY  拷贝

+ VOLUME  容器数据卷，用于保存数据以及持久化

+ CMD  指定一个容器启动时要运行的命令

  ​			Dockerfile 中可以有多个CMD指令，**但只有最后一个生效**，CMD会被docker run之后的参数替换

  ![image-20200419145630987](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200419145630987.png)

+ ENTRYPOINT  指定一个容器启动时要运行的命令 ， 命令追加实现

+ ONBUILD  当构建一个被继承的Dockerfile 时运行命令，父镜像在被子继承后父镜像onbulid被触发

  

小总结

![image-20200419153352426](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200419153352426.png)

#### Dockerfile 实际案例应用

dockerfile案例自定义镜像 mycentos

1. Base镜像（scratch） Docker hub中99%的镜像实在base镜像的基础上演化而来的

2. 自定义镜像 mycentos  在已经拥有的基础上进行重构以及修改

   1. 默认登录是在根目录 -> 修改登录目录
   2. 增加VIM编辑器
   3. 查看网络配置ifconfig支持

   Docker 文件的编写

   > FROM centos
   >
   > 
   >
   > ENV mypath /tmp
   >
   > WORKDIR $mypath
   >
   > 
   >
   > RUM yum -y install vim
   >
   > RUN yum -y install net-tools
   >
   > 
   >
   > EXPOSE 80
   >
   > CMD /bin/bash

   `docker build -f DockerFile2 -t mycentos:1.3 .`

   `docker history imagename:varsion` 查看docker版本相关内容

3. CMD/ENTRYPOINT镜像案例、

   > FROM centos
   >
   > RUN yum install -y curl
   >
   > CMD ["curl","-s","http://ip.cn"]

   ![image-20200419203601603](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200419203601603.png)

   ![image-20200419203629881](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200419203629881.png)

4. 自定义镜像Tomcat9

   + `mkdir -p /zzyyuse/mydockerfile/tomcat9`

   + 上述目录 `touch c.txt`

   + dockerfile内容

     > FROM centos
     >
     > MAINTAINER haifeng@gmail.com
     >
     > \# 宿主机当前上下文的c.txt拷贝到容器中的/usr/lcoal路径下
     >
     > COPY c.txt /usr/local/c.txt
     >
     > \# 把java与tomcat添加到容器中
     >
     > ADD jdk-8u171-linuxXXXXXX
     >
     > ADD apache-tomcatXXXX
     >
     > \# 安装vim编辑器
     >
     > RUN yum -y install vim
     >
     > \#设置工作访问是偶的WORKDIR路径，登录落脚点
     >
     > ENV MYPATH /usr/local
     >
     > WORKDIR $MYPATH
     >
     > \# 配置java与tomcat的环境变量
     >
     > ENV JAVA_HOME /usr/local/jdk1.8.0_171
     >
     > ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
     >
     > ENV CATALINA_HOME
     >
     > ENV CATALINA_BASE
     >
     > \# 容器运行时监听端口
     >
     > EXPOSE 8080
     >
     > \# 启动时候运行 tomcat
     >
     > \# ENTRYPOINT ["/usr/local/apache-tomcat/bin/startup.sh"]
     >
     > \# CMD ["/usr/local/apache-tomcat/bin/catalina.sh","run"]
     >
     > CMD /usr/local/apache=tomcat-9.0.0/bin/startup.sh && tail -F /usr/local/apache-tomcat-9.0.8/bin/logs/catalina.out

### Docker 应用实例

#### 安装MySQL

![image-20200420212149720](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200420212149720.png)

MySQL数据库备份

![image-20200420212608210](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200420212608210.png)

### 本地镜像PUSH到阿里云

阿里云是共有云，

### 知识补充CentOS下Docker安装

[dockers官方文档](https://docs.docker.com/get-started/)

[Docker中文网]([http://www.dockerinfo.net/docker%e5%ae%89%e8%a3%85-centos](http://www.dockerinfo.net/docker安装-centos))



1. 官网中文安装手册

2. 确定你是CENTOS7及以上版本 `cat /etc/redhat-release` 或者 `lsb_release -a`

3. yum安装gcc相关  `yum install gcc` 或者`yum install gcc-c++`

4. 卸载旧版本  `yum remove -y docker*`

   ![image-20200422210119751](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200422210119751.png)

5. 安装需要软件包 `yum install -y yum-utils device-mapper-persistent-data lvm2`

6. 设置stable镜像仓库

   `yum-config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo`

   ![image-20200422211527509](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200422211527509.png)

   ![image-20200422211102557](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200422211102557.png)

   ​		`cat /etc/yum.repos.d/docker-ce.repo`

​		![image-20200422211630671](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200422211630671.png)

1. 更新yum软件包索引 `yum makecache fast`

   ![image-20200422211857871](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200422211857871.png)

2. 安装Docker CE `yum -y install docker-ce`

3. 启动docker `systemctl start docker`

   ![image-20200422212133073](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200422212133073.png)

4. 测试

   `docker version`

   `docker run hello-world`

5. 配置镜像加速

   + `mkdir -p /etc/docker`

   + `vim /etc/docker/daemon.json`

     ![image-20200422212640001](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200422212640001.png)

   + `systemctl daemon-reload`

   + `systemctl restart docker`

6. 卸载

   `yum remove docker-ce`



$T23909 PN01FNI



PNM assemble

PNN assemble EC

fup copy  TPNN2JLI





> fileinfo *PNN2J*

> obey OPNN2JLD
>
> volume $T23908.PN01OPI
>
> if terminal exists
>
> obey  OPNN2JSP
>
> secom commands
>
> secome INT-PN-TACL-
>
>  alter \T05033.$PNN2J.#SWITCH.INTSW001
>
> fup secure PNN2Jic, "NNNN"



tedit filename







for the port  > 60000

