--update
select '<update id="update" parameterClass="">
<![CDATA[ UPDATE GDWS_SKIN_TEST_RESULT ]]>
        <dynamic prepend="SET">
        ' || REPLACE(WM_CONCAT(COLUMN_NAME),'>,', '>
') || '
</dynamic>
<dynamic prepend="WHERE"><![CDATA[ ID = #id:String#]]></dynamic>
</update>' col 
from      (select '<isNotEmpty property="' || lower(substr(column_name,1,1)) ||  substr(REGEXP_REPLACE(INITCAP(column_name), '(\w)[_]', '\1'),2) || '" prepend=","><![CDATA[  '|| upper(column_name) || '=#' || lower(substr(column_name,1,1)) ||  substr(REGEXP_REPLACE(INITCAP(column_name), '(\w)[_]', '\1'),2) || '# ]]></isNotEmpty>' as COLUMN_NAME,column_id 
          from sys.user_tab_columns  where table_name='GDWS_SKIN_TEST_RESULT' 
          order by column_id)
start with column_id=1 connect by column_id=rownum;

--update2
select '<update id="update" parameterClass="">
<![CDATA[ UPDATE GDWS_DATA_COMMONMEDICINE ]]>
        <dynamic prepend="SET">
        ' || REPLACE(WM_CONCAT(COLUMN_NAME),'>,', '>
') || '
</dynamic>
<dynamic prepend="WHERE"><![CDATA[ ID = #id:String#]]></dynamic>
</update>' col 
from      (select '<![CDATA[  '|| upper(column_name) || '=#' || lower(substr(column_name,1,1)) ||  substr(REGEXP_REPLACE(INITCAP(column_name), '(\w)[_]', '\1'),2) || '# ]]>' as COLUMN_NAME,column_id 
          from sys.user_tab_columns  where table_name='GDWS_DATA_COMMONMEDICINE' 
          order by column_id)
start with column_id=1 connect by column_id=rownum;

--get
  select * from GDWS_CMC_CHILD t where t.id = #id#;

--insert
  select '<insert id="insert" parameterClass="">
<![CDATA[ INSERT INTO GDWS_SKIN_TEST_RESULT(' || (
  select max(substr(SYS_CONNECT_BY_PATH(COLUMN_NAME, ','),2)) col from ( 
  select COLUMN_NAME as COLUMN_NAME,column_id from sys.user_tab_columns  where table_name='GDWS_SKIN_TEST_RESULT') 
  start with column_id=1 
  connect by column_id=rownum
) || ') 
     VALUES (' || (
  select max(substr(SYS_CONNECT_BY_PATH(COLUMN_NAME, ','),2)) col from ( 
  select '#'|| lower(substr(column_name,1,1)) ||  substr(REGEXP_REPLACE(INITCAP(column_name), '(\w)[_]', '\1'),2) ||'#' as COLUMN_NAME,column_id from sys.user_tab_columns  where table_name='GDWS_SKIN_TEST_RESULT') 
  start with column_id=1 
  connect by column_id=rownum
) || ')  ]]>
</insert>'
 from dual;
 
--insertList
 select '<insert id="" parameterClass="">
<![CDATA[ INSERT INTO GDWS_PH_MEDICINE(' || (select max(substr(SYS_CONNECT_BY_PATH('                  ' || COLUMN_NAME, ',
  '),2)) col from ( 
  select COLUMN_NAME as COLUMN_NAME,column_id from sys.user_tab_columns  where table_name='GDWS_PH_MEDICINE') 
  start with column_id=1 
  connect by column_id=rownum
) || ') VALUES  ]]>
      <iterate conjunction=",">
      <![CDATA[(' || (select max(substr(SYS_CONNECT_BY_PATH(COLUMN_NAME, ',
      '),2)) col from ( 
  select '                  #list[].'|| lower(substr(column_name,1,1)) ||  substr(REGEXP_REPLACE(INITCAP(column_name), '(\w)[_]', '\1'),2) ||'#' as COLUMN_NAME,column_id from sys.user_tab_columns  where table_name='GDWS_PH_MEDICINE') 
  start with column_id=1 
  connect by column_id=rownum) || '
                  )  ]]>
</iterate>
</insert>'
 from dual;
 
 --resultMap
 select '<result property="' || lower(substr(column_name,1,1)) ||  substr(REGEXP_REPLACE(INITCAP(column_name), '(\w)[_]', '\1'),2) || '" column="' || upper(column_name) || '"/>'
 from user_tab_columns where table_name='GDWS_SKIN_TEST_RESULT' order by column_name;
 
 --entity
  select 'private ' || (case when data_scale>0 then 'Double ' when data_scale=0 then 'Integer ' else 'String ' end) || lower(substr(a.column_name,1,1)) ||  substr(REGEXP_REPLACE(INITCAP(a.column_name), '(\w)[_]', '\1'),2) || '; //' || comments  from sys.user_tab_columns a 
   left join user_col_comments b on a.table_name = b.table_name and a.COLUMN_NAME = b.column_name
   where a.table_name='GDWS_SKIN_TEST_RESULT'
 order by column_id;
