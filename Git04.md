
## The Git Tutorial ##

This is the Git part4 learning note

这部分包含git中信息对比的相关信息

### 版本对此 ###

`git diff` diff是Linux上的一个基本命令，用于比较有区分的部分

diff技巧

+ 第一行：对比存放暂存和工作目录的两个文件
+ 第二行：文件ID和文件权限
+ 第三行：三个减号表示暂存区
+ 第四行：三个加号表示文件目录
+ 第五行：@减号旧文件，加号新文件  +1,2表示：新文件从第一行开始，两行 @
+ J 向下一行 K向上一行 F一页下移  B一页上移 D/U 下/上半页
+ diff这部分一些按键和操作参考vim命令

diff将两个文件合并在一起打印，用于显示美观

### 比较两个历史快照 ###

`git diff 快照ID1 快照ID2`

### 比较当前目录和Git仓库中的快照 ###

`git diff 快照ID`

### 比较暂存区域和Git仓库中的快照 ###

对比暂存区域和当前仓库中的`git diff --cached`

对比暂存区和仓库中某个版本的快照`git diff --cached[快照ID]`