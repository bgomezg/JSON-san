Error starting at line : 2 in command -
DECLARE
   cursor c_idx is
      select index_name
      FROM   user_indexes
   WHERE  table_name = 'MOVIMIENTOS_HISMO_VISTA_0' and index_type <> 'LOB'
   AND INDEX_NAME not in (select index_name from user_constraints where table_name = 'MOVIMIENTOS_HISMO_VISTA_0' and constraint_type = 'P');
BEGIN
   for cur in c_idx
   LOOP
     execute immediate ('drop index "' || cur.index_name || '" force' ); 
   END LOOP;
END;
Error report -
ORA-29862: cannot specify FORCE option for dropping non-domain index
ORA-06512: at line 10
ORA-06512: at line 10
29862. 00000 -  "cannot specify FORCE option for dropping non-domain index"
*Cause:    A DROP INDEX FORCE was issued for a non-domain index.
*Action:   Reissue the command without the FORCE option.
Now checking the current movimientos_hismo_vista_0 collection ...

 

 

PL/SQL procedure successfully completed.

 

Now invoking mongo2ora ...
Using pdbadmin as ADMIN user
Using Z_pdb_1105 as ADMIN password
--== Mongo2Ora v1.2.1 - the MongoDB to Oracle migration tool ==--
╔ dump20230915 DB: 32 collections, 0 JSON doc, 147 index, 0.0 MB
╚═> CVGT DB connecting...
MongoDB (dump) |         0.0 MB/s (max: 0.0 MB/s) - 2s            | Oracle 19.19
java.sql.SQLSyntaxErrorException: ORA-00955: name is already used by an existing object
ORA-06512: at "XDB.DBMS_SODA_ADMIN", line 2518
ORA-06512: at "XDB.DBMS_SODA_ADMIN", line 2369
ORA-06512: at "XDB.DBMS_SODA_ADMIN", line 444
ORA-06512: at "XDB.DBMS_SODA_ADMIN", line 2360
ORA-06512: at line 1

 

        at oracle.jdbc.driver.T4CTTIoer11.processError(T4CTTIoer11.java:702)
        at oracle.jdbc.driver.T4CTTIoer11.processError(T4CTTIoer11.java:608)
        at oracle.jdbc.driver.T4C8Oall.processError(T4C8Oall.java:1335)
        at oracle.jdbc.driver.T4CTTIfun.receive(T4CTTIfun.java:1041)
        at oracle.jdbc.driver.T4CTTIfun.doRPC(T4CTTIfun.java:443)
        at oracle.jdbc.driver.T4C8Oall.doOALL(T4C8Oall.java:533)
        at oracle.jdbc.driver.T4CCallableStatement.doOall8(T4CCallableStatement.java:216)
        at oracle.jdbc.driver.T4CCallableStatement.executeForRows(T4CCallableStatement.java:1346)
        at oracle.jdbc.driver.OracleStatement.executeSQLStatement(OracleStatement.java:1877)
        at oracle.jdbc.driver.OracleStatement.doExecuteWithTimeout(OracleStatement.java:1520)
        at oracle.jdbc.driver.OraclePreparedStatement.executeInternal(OraclePreparedStatement.java:3751)
        at oracle.jdbc.driver.OraclePreparedStatement.execute(OraclePreparedStatement.java:4180)
        at oracle.jdbc.driver.OracleCallableStatement.execute(OracleCallableStatement.java:4203)
        at oracle.jdbc.driver.OraclePreparedStatementWrapper.execute(OraclePreparedStatementWrapper.java:1015)
        at oracle.ucp.jdbc.proxy.oracle$1ucp$1jdbc$1proxy$1oracle$1StatementProxy$2oracle$1jdbc$1internal$1OracleCallableStatement$$$Proxy.execute(Unknown Source)
        at com.oracle.mongo2ora.migration.oracle.OracleCollectionInfo.createMongoDBAPICompatibleCollection(OracleCollectionInfo.java:319)
        at com.oracle.mongo2ora.migration.oracle.OracleCollectionInfo.getCollectionInfoAndPrepareIt(OracleCollectionInfo.java:81)
        at com.oracle.mongo2ora.Main.main(Main.java:414)
Caused by: Error : 955, Position : 0, SQL = BEGIN DBMS_SODA_ADMIN.CREATE_COLLECTION(P_URI_NAME => :1, P_CREATE_MODE => 'NEW', P_DESCRIPTOR => :2, P_CREATE_TIME => :3) ; END;, Original SQL = {call DBMS_SODA_ADMIN.CREATE_COLLECTION(P_URI_NAME => ?, P_CREATE_MODE => 'NEW', P_DESCRIPTOR => ?, P_CREATE_TIME => ?) }, Error Message = ORA-00955: name is already used by an existing object
ORA-06512: at "XDB.DBMS_SODA_ADMIN", line 2518
ORA-06512: at "XDB.DBMS_SODA_ADMIN", line 2369
ORA-06512: at "XDB.DBMS_SODA_ADMIN", line 444
ORA-06512: at "XDB.DBMS_SODA_ADMIN", line 2360
ORA-06512: at line 1

 

        at oracle.jdbc.driver.T4CTTIoer11.processError(T4CTTIoer11.java:710)
        ... 17 more
Now indexing the underlying table ...

 

 

Error starting at line : 3 File @ /opt/oracle/mongo2ora/942919_tmp_idx.sql
In command -
  CREATE INDEX "CVGT"."idContratoLocal_1_0" ON "CVGT"."MOVIMIENTOS_HISMO_VISTA_0" (JSON_VALUE("DATA" FORMAT OSON , '$.idContratoLocal' RETURNING VARCHAR2(2000) ERROR ON ERROR NULL ON EMPTY), 1)
Error report -
ORA-00955: name is already used by an existing object
00955. 00000 -  "name is already used by an existing object"
*Cause:    
*Action:

 

Error starting at line : 6 File @ /opt/oracle/mongo2ora/942919_tmp_idx.sql
In command -
  CREATE INDEX "CVGT"."INDEXSEARCHVISTA0" ON "CVGT"."MOVIMIENTOS_HISMO_VISTA_0" ("DATA") 
   INDEXTYPE IS "CTXSYS"."CONTEXT_V2"  PARAMETERS ('SIMPLIFIED_JSON ')
Error report -
ORA-00955: name is already used by an existing object
00955. 00000 -  "name is already used by an existing object"
*Cause:    
*Action:

 

 

Table MOVIMIENTOS_HISMO_VISTA_0_PART truncated.

 
