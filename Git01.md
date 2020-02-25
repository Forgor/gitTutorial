
## The Git Tutorial ##

This is the Git part1 learning note

+ 安装Git
+ 配置Git


### 安装Git ###

GIT官网地址如下，[The Git Offical Website](http://git-scm.com "Git web")，下载完成后点击安装导入即可

### 配置Git ###

如果是第一次使用git的话，开启后需要如下配置

1. 配置git用户名

	`git config --global user.name "username" `

2. 配置git邮箱

	`git config --global user.email "email"`

3. 查看git参数

	`git config --list`

### Git知识 ###

Git是类似于SVN的版本控制软件，git中比较重要的概念有三棵树:工作区、暂存区和工作仓库

Git的工作流程如下：

1. 在工作目录中添加，修改文件
2. 将需要进行版本管理的文件放入暂存区域
3. 将暂存区域的文件提交到Git仓库

Git管理的文件有三种状态

+ 已修改（modified）
+ 已暂存（staged)
+ 已提交（committed)


### Git操作 ###

1.  在需要的路径下初始化git仓库  

	`git init`

2. 添加文件至暂存区域

	`git add readme.md`

3. 提交文件至文件仓库, -m 选项表示是说明

	`git commit -m "add an readme file"`


```

	https://github.com/Forgor/gitTutorial.git
	
	echo "# gitTutorial" >> README.md
	git init
	git add README.md
	git commit -m "first commit"
	git remote add origin https://github.com/Forgor/gitTutorial.git
	git push -u origin master
	
	
	git remote add origin https://github.com/Forgor/gitTutorial.git
	git push -u origin master


```