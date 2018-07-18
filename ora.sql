select s.username, l.object_id, l.session_id, s.serial#, s.lockwait, s.status, s.machine, s.program from v$session s, v$locked_object l where s.sid = l.session_id;
select sql_text from v$sql where hash_value in (select sql_hash_value from v$session where sid in (select session_id from v$locked_object));
alter system kill session '68,24231'; --SID,serial#
