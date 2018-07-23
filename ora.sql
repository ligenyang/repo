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
