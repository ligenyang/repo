-- resultmap
SELECT '<result property="' || LOWER(SUBSTR(T.COLUMN_NAME, 1, 1))
  || SUBSTR(REGEXP_REPLACE(INITCAP(T.COLUMN_NAME), '(\w)[_]', '\1'), 2)
  || '" column="' || UPPER(T.COLUMN_NAME) || '" />'
FROM SYS.USER_TAB_COLUMNS T
WHERE T.TABLE_NAME='NCMS_INDIVIDUAL_ACCOUNT'
ORDER BY T.COLUMN_ID;

-- columns
SELECT '<sql id="columns">
            <![CDATA[ SELECT ' || WM_CONCAT('T.' || T.COLUMN_NAME) || ' ]]>
       </sql>' COLUMN_NAME
FROM (SELECT O.COLUMN_NAME FROM SYS.USER_TAB_COLUMNS O
WHERE O.TABLE_NAME = 'NCMS_INDIVIDUAL_ACCOUNT' ORDER BY O.COLUMN_ID) T;

-- query criteria
SELECT '<isNotEmpty prepend=" AND " property="' 
  || LOWER(SUBSTR(T.COLUMN_NAME, 1, 1)) 
  || SUBSTR(REGEXP_REPLACE(INITCAP(T.COLUMN_NAME), '(\w)[_]', '\1'), 2) 
  || '"><![CDATA[ T.'
  || UPPER(T.COLUMN_NAME) 
  || ' = #' 
  || LOWER(SUBSTR(T.COLUMN_NAME, 1, 1)) 
  || SUBSTR(REGEXP_REPLACE(INITCAP(T.COLUMN_NAME), '(\w)[_]', '\1'), 2) 
  || '# ]]></isNotEmpty>' AS COLUMN_NAME
FROM SYS.USER_TAB_COLUMNS T
WHERE T.TABLE_NAME = 'NCMS_INDIVIDUAL_ACCOUNT' ORDER BY T.COLUMN_ID;

-- insert
SELECT '<insert id="insert" parameterClass="MedicalNuringAttach">
<![CDATA[ INSERT INTO NCMS_INDIVIDUAL_ACCOUNT (' || (
SELECT MAX(SUBSTR(SYS_CONNECT_BY_PATH(A.COLUMN_NAME, ','), 2)) COL FROM (
SELECT T.COLUMN_NAME, T.COLUMN_ID 
FROM SYS.USER_TAB_COLUMNS T 
WHERE TABLE_NAME = 'NCMS_INDIVIDUAL_ACCOUNT') A 
START WITH A.COLUMN_ID = 1 CONNECT BY A.COLUMN_ID = ROWNUM
) || ')
     VALUES (' || (
SELECT MAX(SUBSTR(SYS_CONNECT_BY_PATH(A.COLUMN_NAME, ','),2)) COL FROM (
SELECT '#' || LOWER(SUBSTR(T.COLUMN_NAME, 1, 1))
  || SUBSTR(REGEXP_REPLACE(INITCAP(T.COLUMN_NAME), '(\w)[_]', '\1'), 2)
  ||'#' AS COLUMN_NAME, T.COLUMN_ID
FROM SYS.USER_TAB_COLUMNS T
WHERE T.TABLE_NAME = 'NCMS_INDIVIDUAL_ACCOUNT') A
START WITH A.COLUMN_ID = 1 CONNECT BY A.COLUMN_ID = ROWNUM
) || ') ]]>
</insert>'
FROM DUAL;

-- insertList
select '<insert id="insertList" parameterClass="java.util.List">
<![CDATA[ INSERT ALL ]]> 
<iterate>
<![CDATA[ INTO NCMS_INDIVIDUAL_ACCOUNT (' ||
(select max(substr(sys_connect_by_path(b.column_name, ','), 2)) col from (
select a.column_name, a.column_id from sys.user_tab_columns a where a.table_name = 'NCMS_INDIVIDUAL_ACCOUNT') b
start with b.column_id = 1 connect by b.column_id = rownum ) ||
') VALUES ]]>
<![CDATA[ (' || (
select max(substr(sys_connect_by_path(b.column_name, ','), 2)) col from (
select '#list[].'|| lower(substr(a.column_name, 1, 1)) || substr(regexp_replace(initcap(a.column_name), '(\w)[_]', '\1'), 2) || '#' column_name, a.column_id from sys.user_tab_columns a where a.table_name = 'NCMS_INDIVIDUAL_ACCOUNT') b
start with b.column_id = 1 connect by b.column_id = rownum
) || ') ]]>
</iterate>
<![CDATA[SELECT 1 FROM DUAL ]]>
</insert>'
 from dual;

-- update
SELECT '<isNotEmpty property="' 
  || LOWER(SUBSTR(T.COLUMN_NAME, 1, 1)) 
  || SUBSTR(REGEXP_REPLACE(INITCAP(T.COLUMN_NAME), '(\w)[_]', '\1'), 2) 
  || '" prepend=","><![CDATA[ T.'
  || UPPER(T.COLUMN_NAME) 
  || ' = #' 
  || LOWER(SUBSTR(T.COLUMN_NAME, 1, 1)) 
  || SUBSTR(REGEXP_REPLACE(INITCAP(T.COLUMN_NAME), '(\w)[_]', '\1'), 2) 
  || '# ]]></isNotEmpty>' AS COLUMN_NAME
FROM SYS.USER_TAB_COLUMNS T
WHERE T.TABLE_NAME = 'NCMS_INDIVIDUAL_ACCOUNT' ORDER BY T.COLUMN_ID;

--updateAll
select '<update id="updateAll" parameterClass="MedicalNuringAttach">
<![CDATA[ UPDATE NCMS_INDIVIDUAL_ACCOUNT T ]]>
          <dynamic prepend="SET">
        <![CDATA[
            ' || REPLACE(WM_CONCAT(COLUMN_NAME), '#,', '#
            ') || ' ]]>
</dynamic>
<dynamic prepend="WHERE"><![CDATA[ T.ID = #id:String# ]]></dynamic>
</update>' col
from (select 'T.' || upper(column_name) || ' = #' || lower(substr(column_name, 1, 1)) || substr(REGEXP_REPLACE(INITCAP(column_name), '(\w)[_]', '\1'),2) || '#,' as COLUMN_NAME, column_id
from sys.user_tab_columns where table_name='NCMS_INDIVIDUAL_ACCOUNT'order by column_id)
start with column_id=1 connect by column_id=rownum;

-- entity
SELECT 'private ' 
  || (CASE WHEN A.DATA_SCALE > 0 THEN 'Double ' WHEN A.DATA_SCALE = 0 THEN 'Integer ' ELSE 'String ' END) 
  || LOWER(SUBSTR(A.COLUMN_NAME, 1, 1)) 
  || SUBSTR(REGEXP_REPLACE(INITCAP(A.COLUMN_NAME), '(\w)[_]', '\1'), 2) 
  || '; // ' 
  || B.COMMENTS 
FROM SYS.USER_TAB_COLUMNS A 
LEFT JOIN SYS.USER_COL_COMMENTS B ON A.TABLE_NAME = B.TABLE_NAME AND A.COLUMN_NAME = B.COLUMN_NAME 
WHERE A.TABLE_NAME = 'NCMS_INDIVIDUAL_ACCOUNT'
ORDER BY A.COLUMN_ID;

-- È¥³ýÖØ¸´¼ÇÂ¼
delete from gdws_cmc_child t
where exists(select 1 from gdws_cmc_child a where t.person_id = a.person_id group by a.person_id having count(1) > 1)
and t.rowid <> (select max(o.rowid) rowid_ from gdws_cmc_child o where t.person_id = o.person_id group by o.person_id having count(1) > 1);

-- columns and COMMENTS
SELECT 'T.' || A.COLUMN_NAME || ', -- ' || B.COMMENTS || ' ' || A.DATA_TYPE || DECODE(A.DATA_TYPE, 'VARCHAR2', '(' || A.DATA_LENGTH || ')', 'NUMBER', '(' || A.DATA_PRECISION || ',' || A.DATA_SCALE || ')')
FROM SYS.USER_TAB_COLUMNS A
LEFT JOIN SYS.USER_COL_COMMENTS B ON A.TABLE_NAME = B.TABLE_NAME AND A.COLUMN_NAME = B.COLUMN_NAME
WHERE A.TABLE_NAME = 'GDWS_CMC_CHILD' order by a.column_id;
