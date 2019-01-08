-- resultmap
SELECT '<result property="' || LOWER(SUBSTR(T.COLUMN_NAME, 1, 1))
  || SUBSTR(REGEXP_REPLACE(INITCAP(T.COLUMN_NAME), '(\w)[_]', '\1'), 2)
  || '" column="' || UPPER(T.COLUMN_NAME) || '" />'
FROM SYS.USER_TAB_COLUMNS T
WHERE T.TABLE_NAME='GDWS_FUM_CHILD_'
ORDER BY T.COLUMN_ID;
                                            
-- columns
SELECT '<sql id="columns">
            <![CDATA[ ' || WM_CONCAT('T.' || T.COLUMN_NAME) || ' ]]>
       </sql>' COLUMN_NAME
FROM (SELECT O.COLUMN_NAME FROM SYS.USER_TAB_COLUMNS O
WHERE O.TABLE_NAME = 'GDWS_FUM_CHILD2' ORDER BY O.COLUMN_ID) T;
                                            
-- columns and COMMENTS
SELECT 'T.' || A.COLUMN_NAME || ', -- ' || B.COMMENTS || ' ' || A.DATA_TYPE || DECODE(A.DATA_TYPE, 'VARCHAR2', '(' || A.DATA_LENGTH || ')', 'NUMBER', '(' || A.DATA_PRECISION || ',' || A.DATA_SCALE || ')')
FROM SYS.USER_TAB_COLUMNS A
LEFT JOIN SYS.USER_COL_COMMENTS B ON A.TABLE_NAME = B.TABLE_NAME AND A.COLUMN_NAME = B.COLUMN_NAME
WHERE A.TABLE_NAME = 'GDWS_CMC_CHILD' order by a.column_id;
                                            
-- insert
SELECT '<insert id="insert" parameterClass="">
<![CDATA[ INSERT INTO GDWS_FUM_CHILD_ (' || (
SELECT MAX(SUBSTR(SYS_CONNECT_BY_PATH(A.COLUMN_NAME, ','), 2)) COL FROM (
SELECT T.COLUMN_NAME, T.COLUMN_ID 
FROM SYS.USER_TAB_COLUMNS T 
WHERE TABLE_NAME = 'GDWS_FUM_CHILD_') A 
START WITH A.COLUMN_ID = 1 CONNECT BY A.COLUMN_ID = ROWNUM
) || ')
     VALUES (' || (
SELECT MAX(SUBSTR(SYS_CONNECT_BY_PATH(A.COLUMN_NAME, ','),2)) COL FROM (
SELECT '#' || LOWER(SUBSTR(T.COLUMN_NAME, 1, 1))
  || SUBSTR(REGEXP_REPLACE(INITCAP(T.COLUMN_NAME), '(\w)[_]', '\1'), 2)
  ||'#' AS COLUMN_NAME, T.COLUMN_ID
FROM SYS.USER_TAB_COLUMNS T
WHERE T.TABLE_NAME = 'GDWS_FUM_CHILD_') A
START WITH A.COLUMN_ID = 1 CONNECT BY A.COLUMN_ID = ROWNUM
) || ') ]]>
</insert>'
FROM DUAL;

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
WHERE T.TABLE_NAME = 'GDWS_FUM_CHILD_' ORDER BY T.COLUMN_ID;

--updateAll
select '<update id="updateAll" parameterClass="GDWS_CMC_PSY">
<![CDATA[ UPDATE GDWS_CMC_PSY T ]]>
          <dynamic prepend="SET">
        <![CDATA[
            ' || REPLACE(WM_CONCAT(COLUMN_NAME), '#,', '#
            ') || ' ]]>
</dynamic>
<dynamic prepend="WHERE"><![CDATA[ T.ID = #id:String# ]]></dynamic>
</update>' col
from (select 'T.' || upper(column_name) || ' = #' || lower(substr(column_name, 1, 1)) || substr(REGEXP_REPLACE(INITCAP(column_name), '(\w)[_]', '\1'),2) || '#,' as COLUMN_NAME, column_id
from sys.user_tab_columns where table_name='GDWS_CMC_PSY'order by column_id)
start with column_id=1 connect by column_id=rownum;

-- insertList
 select '<insert id="" parameterClass="">
<![CDATA[ INSERT INTO [TABLE_NAME](' || (select max(substr(SYS_CONNECT_BY_PATH('                  ' || COLUMN_NAME, ',
  '),2)) col from ( 
  select COLUMN_NAME as COLUMN_NAME,column_id from sys.user_tab_columns  where table_name='[TABLE_NAME]') 
  start with column_id=1 
  connect by column_id=rownum
) || ') VALUES  ]]>
      <iterate conjunction=",">
      <![CDATA[(' || (select max(substr(SYS_CONNECT_BY_PATH(COLUMN_NAME, ',
      '),2)) col from ( 
  select '                  #list[].'|| lower(substr(column_name,1,1)) ||  substr(REGEXP_REPLACE(INITCAP(column_name), '(\w)[_]', '\1'),2) ||'#' as COLUMN_NAME,column_id from sys.user_tab_columns  where table_name='[TABLE_NAME]') 
  start with column_id=1 
  connect by column_id=rownum) || '
                  )  ]]>
</iterate>
</insert>'
 from dual;
                                                                                                                           
-- entity
SELECT 'private ' 
  || (CASE WHEN A.DATA_SCALE > 0 THEN 'Double ' WHEN A.DATA_SCALE = 0 THEN 'Integer ' ELSE 'String ' END) 
  || LOWER(SUBSTR(A.COLUMN_NAME, 1, 1)) 
  || SUBSTR(REGEXP_REPLACE(INITCAP(A.COLUMN_NAME), '(\w)[_]', '\1'), 2) 
  || '; // ' 
  || B.COMMENTS 
FROM SYS.USER_TAB_COLUMNS A 
LEFT JOIN SYS.USER_COL_COMMENTS B ON A.TABLE_NAME = B.TABLE_NAME AND A.COLUMN_NAME = B.COLUMN_NAME
WHERE A.TABLE_NAME = 'GDWS_FUM_CHILD_'
ORDER BY A.COLUMN_ID;
