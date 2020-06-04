

# 1. 创建数据库
\l
CREATE DATABASE tyk;
# 创建数据库

# 2. 创建表格 保证字段与CSV文件列名一致
CREATE TABLE data(
    update_time date,
    id text,
    title text,
    price numeric,
    sale_count int,
    comment_count int,
    店名 text
);

# 删除表
DROP TABLE data;

# 增加字段
alter table data add ...

# 导入数据 注意忽略第一行

\COPY 客户端数据拷贝至数据库
COPY 数据库里面的数据做拷贝

\COPY data from 'C:\Users\HD.huanghf\Downloads\体验课资料_双十一淘宝美妆数据.csv' WITH CSV HEADER;

# 检查数据
\d data

# 3. 查看数据
SELECT * FROM data limit 10;

INSERT INTO public.data(
	update_time, id, title, price, sale_count, comment_count, "店名")
	VALUES (?, ?, ?, ?, ?, ?, ?);

## 数据清洗
删除为空的字段的相关值

# 数据整理以及计算

# 修改列名
ALTER TABLE data RENAME COLUMN id TO 商品id;
ALTER TABLE data RENAME COLUMN update_time TO 日期;
ALTER TABLE data RENAME COLUMN title TO 商品名称;
ALTER TABLE data RENAME COLUMN price TO 价格;
ALTER TABLE data RENAME COLUMN sale_count TO 销售量;
ALTER TABLE data RENAME COLUMN comment_count TO 评价数量;
ALTER TABLE data RENAME COLUMN 店名 TO 品牌名称;

# 计算销售量 
ALTER TABLE data ADD 销售额 numeric;
UPDATE data SET 销售额 = 价格 * 销售量;

# 计算折扣力度
CREATE TABLE data2 AS 
    SELECT 商品id, MAX(价格), MIN(价格) FROM data GROUP BY 商品id; 

ALTER TABLE data2 ADD 折扣力度 numeric;
UPDATE data2 SET 折扣力度 = MIN/MAX;

# 更改表字段
ALTER TABLE data2 RENAME COLUMN 商品id TO 商品id2;

# 根据查询集合，新建表
CREATE TABLE data3 AS
    SELECT * FROM data,data2 WHERE data.商品id = data2.商品id2;

# 删除多余字段
ALTER TABLE data3 DROP max,min,商品id2;


# 导出数据TO
\COPY data3 TO 'C:\Users\HD.huanghf\Downloads\结果数据.csv' WITH CSV HEADER;


