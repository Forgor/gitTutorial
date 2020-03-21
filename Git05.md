
## The Git Tutorial ##

This is the Git part4 learning note

这部分包含git总常用的一些技巧


### 情景一 ###

1. 修改最后一次提交
2. 修改版本说明

执行带 --amend选项的commit提交命令，Git就会更正最近一次提交 

`git commit --amend`
`git commit --amend -m "description"`

### 情景二 ###

1. 删除文件，比如删除了工作路径下的文件
2. 工作路径增加test.py 


`git rm filename`
`git reset --soft HEAD~`

`git rm -f test.py` 强制删除test.py文件
`git re --cached test.py` 删除暂存区的test.py文件

git rm命令只是删除工作目录和暂存区域的文件，也就是取消跟踪，在下次提交时不纳入版本管理

### 情景三 ###

1. 文件重命名遇到的git问题

`git mv game.py wordgame.py `