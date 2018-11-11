select s.username, l.object_id, l.session_id, s.serial#, s.lockwait, s.status, s.machine, s.program from v$session s, v$locked_object l where s.sid = l.session_id;
select sql_text from v$sql where hash_value in (select sql_hash_value from v$session where sid in (select session_id from v$locked_object));
alter system kill session '68,24231'; --SID,serial#

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
