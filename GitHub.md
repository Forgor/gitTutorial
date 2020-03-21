
## Github 手册

### 基本命令

	https://github.com/Forgor/gitTutorial.git
	
	echo "# gitTutorial" >> README.md
	git init
	git add README.md
	git commit -m "first commit"
	git remote add origin https://github.com/Forgor/gitTutorial.git
	git push -u origin master
	
	
	git remote add origin https://github.com/Forgor/gitTutorial.git
	git push -u origin




### 0321 合并Nginx文档发现如下问题

`fatal: refusing to merge unrelated histories`

然后使用如下命令解决

`git pull --allow-unrelated-histories`
