select s.username, l.object_id, l.session_id, s.serial#, s.lockwait, s.status, s.machine, s.program from v$session s, v$locked_object l where s.sid = l.session_id;
select sql_text from v$sql where hash_value in (select sql_hash_value from v$session where sid in (select session_id from v$locked_object));
alter system kill session '68,24231'; --SID,serial#

select * from ncms_individual_account t -- 查询重复数据
where (t.name, t.individual_account_amount, t.payment_address)
      in (select a.name, a.individual_account_amount, a.payment_address
          from ncms_individual_account a where  a.person_code is null and a.create_name = '李燕'
                                                and a.state = 0 and a.flag = 1 --and --a.update_time = 1553834407
          group by   a.name,a.individual_account_amount, a.payment_address having count(*) > 1)
  and rowid not in (select min(rowid) from ncms_individual_account group by name, individual_account_amount, payment_address having count(*)>1);

                                                                                                   
with
    TB_CHSS_GRJBXX_ as ( 
      select
      t.yljgdm, 
      t.JDYSGH, 
      t.JDYSXM 
    from TB_CHSS_GRJBXX@yanhe t group by t.JDYSGH, t.JDYSXM, t.yljgdm
),
    GDWS_SYS_USER_ as ( 
      select t.INS_ID, 
        t.USER_NAME, 
        t.REAL_NAME 
      from GDWS_SYS_USER t where t.AREA_ID like '520624%' group by t.USER_NAME, t.REAL_NAME, t.INS_ID
  )
select a.*, b.* from TB_CHSS_GRJBXX_ a join GDWS_SYS_USER_ b on a.JDYSXM = b.REAL_NAME; 

select t.SFJLID from TB_JBGL_GXYSQSFGL t group by t.SFJLID having count(t.SFJLID) > 1; --查询重复记录

-- 判断字符串是否为数字
CREATE OR REPLACE FUNCTION IS_NUMBER (str_ VARCHAR2 ) RETURN VARCHAR2
IS num_ NUMBER;
BEGIN
  num_ := to_number(str_);
  RETURN 'Y';
  EXCEPTION
  WHEN OTHERS THEN
  RETURN 'N';
END IS_NUMBER;

--查询数据库最大连接数
select value from v$parameter where name = 'processes';
--修改数据库最大连接数为300
alter system set processes = 300 scope = spfile;

--列转行
SELECT T.PARENT_ID, WMSYS.WM_CONCAT(T.ID) ID FROM GDWS_SYS_HOSP T CONNECT BY PRIOR T.ID = T.PARENT_ID START WITH T.PARENT_ID = '9470201' AND T.FLAG = 0 AND T.STATUS = 0 GROUP BY T.PARENT_ID;

select TRUNC(TO_DATE('2018-09-14', 'YYYY-MM-DD'), 'YYYY') CUR_FIRST_DAY, -- 查询日期年初
TO_CHAR(TO_DATE('2018-09-14', 'YYYY-MM-DD'), 'Q') CUR_QUARTER -- 查询日期季度
from dua;


select * from v$version; -- 查询数据库版本信息
select * from v$pdbs; -- 查询所有可插拨数据库
alter pluggable database ORCLPDB open; -- 打开可插拨数据库
alter session set container = ORCLPDB; -- 
grant dba to WORLD_USER;
show con_name;

alter pluggable database ORCLPDB open; -- 打开可插播数据库
alter session set container=CDB$ROOT; -- 更改当前会话为CDB$ROOT
alter session set container=ORCLPDB; -- 更改当前会话为ORCLPDB

create tablespace tablespace_ Datafile 'C:\software\app\ligenyang\virtual\oradata\orcl\orclpdb\tablespace_1.dbf' size 1024m; -- 新增表空间

CREATE USER USER_ IDENTIFIED BY 123456 DEFAULT TABLESPACE tablespace_; -- 新增用户

drop tablespace tablespace_ including contents and datafiles; -- 删除表空间

select * from DBA_TABLESPACES;
                                                                                                   
SELECT SYSDATE FROM DUAL; -- 当前时间 2018-11-13 15:53:07
SELECT TRUNC(SYSDATE) FROM DUAL; -- 当前时间 2018-11-13 00:00:00
SELECT TRUNC(SYSDATE,'YY') FROM DUAL; -- 当年第一天 2018-01-01 00:00:00
SELECT TRUNC(SYSDATE,'MM') FROM DUAL; -- 当月第一天 2018-11-01 00:00:00
SELECT TRUNC(SYSDATE,'D') FROM DUAL; -- 当前星期第一天 (星期天) 2018-11-11 00:00:00
SELECT TRUNC(SYSDATE,'DD') FROM DUAL; -- 当前日期 2018-11-13 00:00:00
SELECT TRUNC(SYSDATE ,'HH24') FROM DUAL; -- 当前小时的开始时间 2018-11-13 15:00:00
SELECT TRUNC(SYSDATE ,'MI') FROM DUAL; -- 当前分钟的开始时间 2018-11-13 15:57:00
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL; -- 当前日期 2018-11-13
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL; -- 当前时间 (24小时制) 2018-11-13 16:13:50
SELECT TO_CHAR(SYSDATE, 'YYYY') FROM DUAL; -- 当前年份 2018
SELECT TO_CHAR(SYSDATE, 'Q') FROM DUAL; -- 当前季度 4
SELECT TO_CHAR(SYSDATE, 'MM') FROM DUAL; -- 当前月份 11
SELECT TO_CHAR(SYSDATE, 'D') FROM DUAL; -- 当前星期的第几天 3
SELECT TO_CHAR(SYSDATE, 'DAY') FROM DUAL; -- 当前星期几 星期二
SELECT TO_CHAR(SYSDATE, 'YYYY') || '-01-01' FROM DUAL; -- 当年第一天 2018-01-01
                                                                                                   
                                                                                                   
                                                                                                   
-- 毫秒数转日期时间
SELECT TO_CHAR(1406538765000 / (1000 * 60 * 60 * 24) + TO_DATE('1970-01-01 08:00:00', 'YYYY-MM-DD HH:MI:SS'), 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;
-- 日期时间转毫秒数
SELECT TO_NUMBER(TO_DATE('2014-07-28 17:12:45', 'YYYY-MM-DD HH24:MI:SS') - TO_DATE('1970-01-01 8:0:0', 'YYYY-MM-DD HH24:MI:SS')) * 24 * 60 * 60 * 1000 FROM DUAL;
