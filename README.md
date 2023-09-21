select * from v$mystat

select instance_name from v$instance;

select sid, serial# from v$session where sid=SYS_CONTEXT ('USERENV', 'SID');

begin 
    dbms_monitor.session_trace_enable(2440,23259,true,true);
end;
/



begin 
    dbms_monitor.session_trace_disable(2440,23259);
end;
/
