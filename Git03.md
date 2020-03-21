## Git03 ##

这部分的知识点主要包括checkout 以及 reset命令的使用

### reset命令 ###

git可作为版本控制神器的主要原因是可以做到在不同的版本之间做切换，而reset命令可以很方便的帮助我们“回到过去”

回到上一个文件版本，此时不带参数的默认的是`--mixed`

`git reset HEAD~`

**注意**： 此时如果想多返回几版本可以通过增加 `~`的数量来控制

比如： 返回之前第四个版本

`git reset HEAD~~~~` 或 `git reset HEAD~4`

git的版本控制可以裂解为一串有序列码的不同的版本

git reset命令的选项

+ --mixed 
	+ 移动head的指向，将其指向上一个快照，
	+ 将移动后指向的快照回滚至暂存区
	

+ --soft 
	+ 移动head的指向，将其指向上一个快照（撤销一次commit）

+ --hard 
	+ 移动head的指向，将其指向上一个快照
	+ 将head移动后的指向的快照回滚到暂存区域
	+ 将暂存区域的文件还原到工作目录

总结： soft只还原Git仓库， mixed还原git仓库和暂存区，hard三部分都还原

### 回滚指定快照 ###

`git reset 快照ID` 其中快照ID一般是5个字母以上 

### 回滚快照中个别文件 ###

`git reset 版本快照 文件名/路径`


### 去到未来 ###

`git reset 快照ID` 其中快照ID一般是5个字母以上 

### 找寻历史logid ###

`git redlog`

### 关于reset比较好的文章 ###

如下是学习过程中发现比较好的有助于理解reset命令的文章

+ [Git Reset 三种模式](https://www.jianshu.com/p/c2ec5f06cf1a)
+ [git reset 之后的恢复](https://www.jianshu.com/p/5d3ad1a23298)
+ [git commit退出VIM编辑模式](https://blog.csdn.net/weixin_38178584/article/details/81170272)
