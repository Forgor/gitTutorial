
## The Git Tutorial ##

This is the Git part7 learning note

这部分包含git匿名分支和git命令中的`checkout`和`reset`的一些辨析


### 匿名分支概念 ###

使用`checkout`命令时，如果未通过`-b`参数指定所创建的分支名称，将会默认生成一个匿名分支，匿名分支的特点是，在你切回master或者其他分支的时候会提示你是否保存至一个分支，否则会自动舍弃匿名分支中的所有提交。

`git checkout HEAD~n`


### checkout命令解析 ###

checkout命令一般有如下两种使用方法：

1. 从历史快照中拷贝文件至暂存区域和当前目录

	`git checkout HEAD~ README.md` 即从HEAD~中拷贝readme文件

2. 拷贝文件从暂存区域至当前目录

	`git checkout readme.md`


### reset和checkout命令对比 ###

+ 共同点

	都可以恢复指定快照的文件，并且他们不会改变head指针的指向

+ 不同点

	1. `reset`只能将文件恢复到暂存区，也就是说在默认的`mixed`情况下，在`hard`和`soft`的情况下，是无法恢复单个文件的，而`checkout`则可以恢复文件到暂存区域和当前目录，因此在恢复文件上面`reset`比`checkout`更安全一些

	2. `reset` 适用于回到过去的，`checkout`则是移动分支，原理上一致。 所以`checkout`命令会比较安全，因为`checkout`之前会检查分支状态，确认三个仓库中版本一致才会切换分支，但是`reset`则是直接更新
	3. 区别在于如何更新head指向：`reset`移动head所在分支的指向，`checkout`则移动head自身指向另一个分支
	