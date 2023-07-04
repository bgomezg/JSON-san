# JSON-san

 select sql_text, sql_handle,plan_name,enabled,accepted,fixed,executions from dba_sql_plan_baselines;
 
 select sql_id, plan_hash_value, search_columns, object_name, object_type, operation, optimizer, cost, bytes,cpu_cost, io_cost,time, timestamp from dba_hist_sql_plan 
 where sql_id = '9mva3tnz3tphs' order by timestamp;
 where rownum <100 order by timestamp;

 desc dba_hist_sql_plan;

alter index cvgt.Index_idContratoLocal_idMov invisible;

drop index Index_idContratoLocal_idMov;

select index_name, table_name, table_owner from user_indexes where table_owner ='CVGT';
desc user_indexes;

exec dbms_stats.gather_table_stats(null,'MOVIMIENTOS_HISMO_VISTA_5',no_invalidate=>false)


select /*+ FIRST_ROWS(101) gather_plan_statistics index(MOVIMIENTOS_HISMO_VISTA_5 "hismovista5_idContratoLocal_idx") */ json_patch("DATA", '007501250607115683'  project returning blob format oson), "ID", "LAST_MODIFIED", "CREATED_ON", "VERSION" 
from "CVGT"."MOVIMIENTOS_HISMO_VISTA_5" where JSON_EXISTS("DATA" format oson,
'$?( (@.idContratoLocal.stringOnly() == $B0) && (@.fechaConsolidacion.dateTimeOnly() <= $B1) )' passing '007501250607115683'  as "B0",  TO_TIMESTAMP('2025-01-20','YYYY-MM-DD')  as "B1") 
order by JSON_VALUE("DATA" format oson,  '$.idMov') desc,  "ID" fetch next 101 rows only


SELECT *
FROM table(DBMS_XPLAN.DISPLAY_CURSOR(FORMAT=>'ALLSTATS LAST ALL +OUTLINE'));


-- Check if this updates the DB
select num_rows,last_analyzed FROM ALL_TABLES WHERE table_name='MOVIMIENTOS_HISMO_VISTA_5';


select count(*) from MOVIMIENTOS_HISMO_VISTA_5;


-- Dropping the index
drop index hismo_vista5_compoundIDX;

--alter SQL dev created indexes
alter index CVGT.hismo_vista5_compoundIDX INVISIBLE;

--alter ORDS created indexes
alter index CVGT."hismovista5_idContratoLocal_idx" VISIBLE;


-- Creating the index with ORDS-like syntax
CREATE INDEX hismo_vista5_compoundIDX ON movimientos_hismo_vista_5 (
     JSON_VALUE("DATA" FORMAT OSON , '$.idMov' RETURNING VARCHAR2(1000) ERROR ON ERROR NULL ON EMPTY) DESC, 
     JSON_VALUE("DATA" FORMAT OSON , '$.idContratoLocal' RETURNING VARCHAR2(1000) ERROR ON ERROR NULL ON EMPTY), 
     JSON_VALUE("DATA" FORMAT OSON , '$.fechaConsolidacion' RETURNING DATE TRUNCATE TIME ERROR ON ERROR NULL ON EMPTY) DESC, 1
    ) 
    TABLESPACE CVGT_DAT 
;






set pagesize 1000
set heading on
set linesize 999
--break on operation skip 1 dup
col operation format a80
col cost format 99999999
col kbytes format 9999999999
col object format a10
col operation format a20

col object_name format a20
