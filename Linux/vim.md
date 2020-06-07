
## Vim tutorial ##

1. 查看历史命令 `: or /` 以`:`和`/`开头的命令都有历史记录，首先键入相关的符号，然后按上下箭头选择某个历史命令

2. 启动`vim` 在命令行中输入 `vim` 或者 `vim filename` 均可

3. 文件命令

	+ 打开单个文件 `vim filename` 
	+ 同时打开多个文件 `vim file1 file2 file3`
	+ vim窗口打开一个新文件 `:open file`
	+ 新窗口打开文件 `:spilt file`
	+ 切换到下一个文件 `:bn`
	+ 查看当前打开文件的列表 `:args`
	+ 打开远程文件，比如 `ftp` 或者 `share folder`
		+ `:e ftp://192.168.10.76/abc.txt`
		+ `:e \\qadrive/test/1.txt`
		
4. 导航命令 % 括号匹配

5. 查找命令

	+ `/text` 查找text，按n键查找下一个，按N查找前一个
	+ `?text` 查找text，反向查找
	+ `.*+[]^%/?-$` 特殊字符在查找时候需要转义
	+ `:set ignorecase` 忽略大小写查找
	+ `:set noignorecase` 不忽略大小写查找
	+ `:set hlsearch` 高亮搜索结果，所有结果高亮
	+ `:set nohlsearch` 关闭高亮搜索显示
	+ `:nohlsearch` 关闭当前的高亮显示，如果再次搜索会再次显示
	+ `:set wrapscan` 重新搜索，在搜索到文件头或者尾是，返回继续搜索，默认开启

6. 替换命令

	+



### 最后对文件的操作

	:w 保存文件但不退出vi
	:w file 将修改另外保存到file中，不退出vi
	:w! 强制保存，不推出vi
	:wq 保存文件并退出vi
	:wq! 强制保存文件，并退出vi
	q: 不保存文件，退出vi
	:q! 不保存文件，强制退出vi
	:e! 放弃所有修改，从上次保存文件开始再编辑