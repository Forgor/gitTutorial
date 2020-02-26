
## The Git Tutorial ##

This is the Git part6 learning note

这部分包含git分支的一些概念以及操作


### 分支概念 ###

分支： 对线上现有项目创建分支，然后再将你所修改的合并到主项目

GIT采用异端的方式存储文件，将每份文件独立存储
其他采取增量存储


### 创建分支 ###

创建分支  `git branch feature`  
查看带有分支的日志  `git log --decorate --oneline`

master git 默认分支



### 切换分支 ###

`git checkout feature`

图状结构查询分支显示状态`git log --decorate --oneline --graph --all`

### 合并分支 ###

`git merge 分支名称`

### 删除分支 ###

`git branch -d 分支名称`