--update
select '<update id="update" parameterClass="">
<![CDATA[ UPDATE GDWS_FUM_PSY ]]>
        <dynamic prepend="SET">
        ' || REPLACE(WM_CONCAT(COLUMN_NAME),'>,', '>
') || '
</dynamic>
<dynamic prepend="WHERE"><![CDATA[ ID = #id:String#]]></dynamic>
</update>' col
from (select '<isNotEmpty property="' || lower(substr(column_name, 1, 1)) || substr(REGEXP_REPLACE(INITCAP(column_name), '(\w)[_]', '\1'), 2) || '" prepend=","><![CDATA[ T.'|| upper(column_name) || ' = #' || lower(substr(column_name, 1, 1)) || substr(REGEXP_REPLACE(INITCAP(column_name), '(\w)[_]', '\1'), 2) || '# ]]></isNotEmpty>' as COLUMN_NAME, column_id
from sys.user_tab_columns where table_name='GDWS_FUM_PSY' order by column_id)
start with column_id=1 connect by column_id=rownum;

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

--get
  select * from [TABLE_NAME] t where t.id = #id#;

--insert
  select '<insert id="insert" parameterClass="">
<![CDATA[ INSERT INTO GDWS_FUM_PSY(' || (
  SELECT MAX(SUBSTR(SYS_CONNECT_BY_PATH(COLUMN_NAME, ', '), 2)) COL FROM (
  SELECT COLUMN_NAME, COLUMN_ID FROM SYS.USER_TAB_COLUMNS WHERE TABLE_NAME='GDWS_FUM_PSY')
  START WITH COLUMN_ID = 1 CONNECT BY COLUMN_ID = ROWNUM
) || ') 
    VALUES (' || (
  SELECT MAX(SUBSTR(SYS_CONNECT_BY_PATH(COLUMN_NAME, ', '), 2)) COL FROM (
  SELECT '#' || LOWER(SUBSTR(COLUMN_NAME, 1, 1)) || SUBSTR(REGEXP_REPLACE(INITCAP(COLUMN_NAME), '(\W)[_]', '\1'), 2) || '#' AS COLUMN_NAME, COLUMN_ID FROM SYS.USER_TAB_COLUMNS WHERE TABLE_NAME = 'GDWS_FUM_PSY')
  START WITH COLUMN_ID = 1 CONNECT BY COLUMN_ID = ROWNUM
) || ') ]]>
</insert>'
 from dual;
 
--insertList
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
 
 --resultMap
 select '<result property="' || lower(substr(column_name,1,1)) ||  substr(REGEXP_REPLACE(INITCAP(column_name), '(\w)[_]', '\1'),2) || '" column="' || upper(column_name) || '"/>'
 from user_tab_columns where table_name='[TABLE_NAME]' order by column_name;
 --entity
select '/**' || chr(10) || ' * ' || comments || chr(10) || ' */' || chr(10) ||
'private ' || (case when data_scale>0 then 'Double ' when data_scale=0 then 'Integer ' else 'String ' end) || lower(substr(a.column_name,1,1)) ||  substr(REGEXP_REPLACE(INITCAP(a.column_name), '(\w)[_]', '\1'),2) || ';' as col,column_id from sys.user_tab_columns a 
   left join user_col_comments b on a.table_name = b.table_name and a.COLUMN_NAME = b.column_name
   where a.table_name='GDWS_STOCK'
 order by column_id;
