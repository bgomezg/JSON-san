[14:31] Gonzalez Gomez Pedro Antonio

[idefix@isblccoraci0027 mongo2ora]$ ./reload_collection.sh movimientos_hismo_vista_0.ini 

Now starting to reload collection: movimientos_hismo_vista_0

Using connect string: CVGT/X_cvgt_2305@c3cssgtpre01-scan.sgtech.pre.corp:1521/otiscvgt_cvgt_dev.sgtech.pre.corp

Now dropping non PK indexes on collection collection: movimientos_hismo_vista_0

 

 

PL/SQL procedure successfully completed.

 

Now checking the current movimientos_hismo_vista_0 collection ...

 

 

PL/SQL procedure successfully completed.

 

Now invoking mongo2ora ...

Using pdbadmin as ADMIN user

Using Z_pdb_1105 as ADMIN password

--== Mongo2Ora v1.2.1 - the MongoDB to Oracle migration tool ==--

╔ dump20230915 DB: 32 collections, 0 JSON doc, 147 index, 0.0 MB

╚═> CVGT DB connecting...

MongoDB (dump) |         0.0 MB/s (max: 0.0 MB/s) - 4s            | Oracle 19.19

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








mongo2ora.log

Caused by: Error : 955, Position : 0, SQL = BEGIN DBMS_SODA_ADMIN.CREATE_COLLECTION(P_URI_NAME => :1, P_CREATE_MODE => 'NEW', P_DESCRIPTOR => :2, P_CREATE_TIME => :3) ; END;, Original SQL = {call DBMS_SODA_ADMIN.CREATE_COLLECTION(P_URI_NAME => ?, P_CREATE_MODE => 'NEW', P_DESCRIPTOR => ?, P_CREATE_TIME => ?) }, Error Message = ORA-00955: name is already used by an existing object

 

 

Index "CVGT"."idContratoLocal_1_0" created.

 
