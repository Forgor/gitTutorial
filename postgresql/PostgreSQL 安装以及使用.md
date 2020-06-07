# 【数据可视化系列01】用SQL重新管理你的数据：PostgreSQL教学

视频链接[数据可视化系列01](https://www.bilibili.com/video/BV1X7411z7Lg)

### PostgreSQL

[下载链接](https://www.postgresql.org/download/) 进入链接之后选择不同的安装版本。



schemas 各种各样数据的集合

PGSQL是支持中文的，中文设置如下 

File->preference->user language->Chinese simple

表盘会显示表盘处理的一个实际进程

pgADMIN 不会显示SQL处理语句的信息

+ **安装pgSQL后无法启动 pgadmin，原因是因为不是以管理员方式启动的pgadmin**

使用 pg shell

```
更换数据库
\c databasename
查看表格
\d
查看20条信息
select * from XXX LIMIT 20;
```

### psql 以及pgADMIN讲解

psql是PostgreSQL命令行交互式客户端工具->用于执行SQL语言

常用命令如下

```
首先登录进去之后有一个默认的数据库 postgreSQL
创建数据库 CREATE DATABSASE test;
查看数据库 \l
切换数据库 \c test;
查看表格结构   \d tableName;
查看所有命令  \?

SELECT NOW()::date;
SELECT CURRENT_DATE;
SELECT TO_CHAR(NOW() :: DATE, 'dd/mm/yyyy');
SELECT TO_CHAR(NOW() :: DATE, 'Mon dd, yyyy');
SELECT
	first_name,
	last_name,
	now() - hire_date as diff
FROM
	employees;
	SELECT
	employee_id,
	first_name,
	last_name,
	AGE(birth_date)
FROM
	employees;
```

### 天猫数据入库以及数据检查

默认的数据库是postgre



# 【数据可视化系列02】Tableau如何建立电商kpi指标仪表盘？

视频链接 [数据可视化系列02](https://www.bilibili.com/video/BV1q7411z7Qc?from=search&seid=11439748585922900393)

### 2.1 为什么需要可视化

视觉直观上处理的东西要比文字快捷的多很多

### 2.2 常见主流的BI工具

BI BUSINESS INTELLIGENCE

![image-20200601212022144](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200601212022144.png)

BI是由各种图形以及仪表盘组成

视频中介绍了一款免费以及付费的软件

### 2.3 Tableau 从Pixar谈起

纽交所挂牌的数据可视化工具

PowerPoint 和 Excel 的合体

![image-20200601213246623](C:\Users\HD.huanghf\AppData\Roaming\Typora\typora-user-images\image-20200601213246623.png)

### 2.4 Tableau经典案例展示



### 2.5 Tableau Public软件安装



### 2.6 天猫数据加载以及关系链接



### 2.7 核心指标以及KPI框架设计

了解数据类型很重要，不同的数据类型的处理方式不一样

考量TA，设计分析框架

作为平台

​	各品牌的累计表现

​	双十一销售变动之比较

​	双事宜前后销售的累计趋势

作为消费者

​	什么品牌值得等待

​	什么品牌操作价格最频繁

​	哪些品牌是话题制造者



品牌拖拽到列的位置

价格拖拽到文本的位置



### 2.8 Tableau 仪表盘以及可视化表达1

仪表盘的制作以及呈现

相同的时间 不同的品牌给平台创作的销售额是多少

选中销售量以及销售额  然后点击 水平条

合并一个表 垂直方式而不是水平方式

分析下面有个图标，交换列

两张图重叠--> 总和销售额下拉 选择双轴

降序排列

销售额形状选择条形图，并将销售额行前移



相宜本草销售额和销售量基本相等

但是其他 销售额远远超过销售量



每个品牌不同日期的销售额变化

但是呈现效果是以点的形式，原因是列是以年为单位进行呈现的

更改显示方式为天



看一下各个品牌双十一前后销售额变化比较大

选择行 百分比差异 便会显示每一天相对前一天的百分比变化



查看每天销售额占比总销售额度 --> 面积图

列变成天  显示便会比较清晰

行-> 合计百分比(总额百分比)

行-> 计算依据 -> 表(向下)



仪表盘中的联动

选择 设置筛选器



### 2.9 Tableau 仪表盘以及可视化表达2

针对消费者制作的仪表盘

选择品牌，日期，折扣力度

然后选择第一个图表

然后图标转置

行 选择不同的时间段 选择天

然后选择数据为 平均值



制作热力图

标记选择方形

重新复制一个 格式选择颜色

设置数字格式以百分比出现

颜色 边界 白色

