SELECT COLLATIONPROPERTY('Chinese_PRC_Stroke_CI_AI_KS_WS', 'CodePage'); -- 查看编码格式

-- 截取字符串
select left('character', 6); -- [0, 6]
select right('character', 6);
select substring('character', 0, 6); -- [0, 6)
select substring('character', 1, 6); -- [1, 6]
select patindex('%[^0-9]%', '1234213213'); -- 若全部字符为数字, 则返回0
select charindex ( expressionToFind , expressionToSearch [ , start_location ] ); -- 查找字符串
REPLACE ( string_expression , string_pattern , string_replacement ) -- 替换字符串
CAST ( expression AS data_type [ ( length ) ] )  -- 数据类型转换
CONVERT ( data_type [ ( length ) ] , expression [ , style ] )  -- 数据类型转换

-- SQL Wildcard(通配符)

-- SQL Server Functions(函数) 标量函数 内联表值函数 多语句表值函数

-- Transact-SQL Scalar Function Syntax  (Transact-SQL标量函数语法)
CREATE [ OR ALTER ] FUNCTION [ schema_name. ] function_name   
( [ { @parameter_name [ AS ][ type_schema_name. ] parameter_data_type   
    [ = default ] [ READONLY ] }   
    [ ,...n ]  
  ]  
)  
RETURNS return_data_type  
    [ WITH <function_option> [ ,...n ] ]  
    [ AS ]  
    BEGIN   
        function_body   
        RETURN scalar_expression  
    END  
[ ; ]  

USE databaseName -- 数据库名称
  GO
-- 新增方法
create function f_gonghao(@xingming nvarchar(5))
  returns varchar
  as
  begin
  declare @gonghao varchar
  set @gonghao = (select y.dah  from t_et_xsejtfsjl as y where y.xm = @xingming)
  return @gonghao
  end
go
-- 更新方法
alter function f_gonghao(@xingming nvarchar(5))
  returns varchar
  as
  begin
  declare @gonghao varchar
  set @gonghao = (select y.dah  from t_et_xsejtfsjl as y where y.xm = @xingming)
  return @gonghao
  end
go
-- 删除方法
drop function F_GONGHAO
go

Character Data Type
char(n) Variable length Fixed length
varchar(n)
varchar(max)
text

Unicode Data Type
nchar(n)
nvarchar(n) -- Unicode [1, 4000]
nvarchar(max)
ntext

Binary Data Type
bit
binary(n)
varbinary(n)
varbinary(max)
image

Number Data Type
tinyint [0, 255]
smallint [-32768, 32767]
int[2147483648, 2147483647]
bigint
decimal(p,s)
numeric(p,s)
smallmoney
money
float(n)
real

Date Data Type
datetime
datetime2
smalldatetime
date
time
datetimeoffset
timestamp

sql_variant Data Type
uniqueidentifier Data Type
xml Data Type
cursor Data Type
table Data Type
