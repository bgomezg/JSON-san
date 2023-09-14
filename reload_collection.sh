#!/bin/sh

## Script to reload a collection
## Usage: ./reload_collection.sh <ini file>
## INI file format:
#CNAME=movies
#TABLE=MOVIES
#PARTTABLE=MOVIES_PART
#USER=CVGT
#PASSWORD=CVGT
#ADMINUSER=SYSTEM
#ADMINPASSWD=Oracle_4U
#CONNECTSTRING="(description=(retry_count=5)(retry_delay=3)(address=(protocol=tcp)(port=1521)(host=rdbms19oniaas.sub06221433571.skynet.oraclevcn.com))(connect_data=(service_name=orclpdb1)))"
#DUMPDIR=/home/idfix/dump

####### MANDATORY ENV VARIABLES : MUST CHANGE !!!!
### Requires access to ORACLE_HOME, to run Sql*Plus
LD_LIBRARY_PATH=/opt/oracle/product/19c/dbhome_1/lib
ORACLE_HOME=/opt/oracle/product/19c/dbhome_1
## Requires GraalVM to run mongo2ora !!!
JAVA_HOME=/home/idfix/graalvm-ce-java19-22.3.1
PATH=${JAVA_HOME}/bin:$ORACLE_HOME/bin:$PATH
####### END MANDATORY ENV VARIABLES : MUST CHANGE !!!!

## Read the ini file:
INIFILE=$1
source ./${INIFILE}

echo "Now starting to reload collection: "${CNAME}
echo "Using connect string: "${USER}/${PASSWORD}@${CONNECTSTRING}
STRINGCONNECT=${USER}/${PASSWORD}@${CONNECTSTRING}

## Capture indexes of the underlying table, except the PK index (it will be re-created by mongo2ora):
IDXFILE=$$_tmp_idx.sql

sqlplus -s ${STRINGCONNECT} << EOF > ${IDXFILE}
SET LONG 20000 LONGCHUNKSIZE 20000 PAGESIZE 0 LINESIZE 1000 FEEDBACK OFF VERIFY OFF TRIMSPOOL ON

BEGIN
   DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'SQLTERMINATOR', true);
   DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'PRETTY', true);
   -- Uncomment the following lines if you need them.
   DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'SEGMENT_ATTRIBUTES', false);
   DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'STORAGE', false);
END;
/

SELECT DBMS_METADATA.get_ddl ('INDEX', index_name, user)
FROM   user_indexes
WHERE  table_name = '${TABLE}' and index_type <> 'LOB'
AND INDEX_NAME not in (select index_name from user_constraints where table_name = '${TABLE}' and constraint_type = 'P');

exit
EOF

## If the collection is not mapped to the default table, drop it
echo "Now checking the current "${CNAME}" collection ..."
sqlplus -s ${STRINGCONNECT} << EOF
DECLARE
  v_tab_name VARCHAR2(100);
  ret PLS_INTEGER;
BEGIN
   SELECT OBJECT_NAME
   into v_tab_name
   from user_soda_collections
   where uri_name = '${CNAME}';
--
   if v_tab_name <> UPPER('${CNAME}')
   THEN
       select DBMS_SODA.DROP_COLLECTION('${CNAME}') into ret from dual;
   END IF;
END;
/
exit
EOF

## Reload the collection with mongo2ora:
echo "Now invoking mongo2ora ..."
echo "Using "${ADMINUSER}" as ADMIN user"
echo "Using "${ADMINPASSWD}" as ADMIN password"

java --enable-preview -Xmx6G -Xms6G -XX:+UnlockExperimentalVMOptions -XX:G1MaxNewSizePercent=80 -XX:MaxTenuringThreshold=1 \
-jar mongo2ora-1.2.2-jar-with-dependencies.jar \
-s 'mongodump://'${DUMPDIR} \
-d ${STRINGCONNECT} \
-da ${ADMINUSER} -dp ${ADMINPASSWD} \
-c ${CNAME} \
-p 2  --drop --mongodbapi --oson --skip-secondary-indexes

## Re-create the indexes
echo "Now indexing the underlying table ..."

sqlplus -s ${STRINGCONNECT} << EOF
spool ${IDXFILE}.log
start ${IDXFILE}
spool off
exit
EOF

### If there is a partitioned table

if ! [ -z "${PARTTABLE}" ]
then
## Load the partitioned table row by row to honor hash partitioning !!!
sqlplus -s ${STRINGCONNECT} << EOF
spool load_${PARTTABLE}.log
truncate table ${PARTTABLE};
declare
   cursor c_nopart is
   select ID,CREATED_ON,LAST_MODIFIED,VERSION,DATA from ${TABLE};
BEGIN
   for cur in c_nopart
   LOOP
      insert into ${PARTTABLE} (ID,CREATED_ON,LAST_MODIFIED,VERSION,DATA)
      values (cur.ID,cur.CREATED_ON,cur.LAST_MODIFIED,cur.VERSION,cur.DATA);
   END LOOP;
   ---
   commit;
END;
/
spool off
exit
EOF



## Re-create the collection mapping:
echo "Now re-creating the collection mapping ..."
TABCLAUSE='"tableName" : "'${PARTTABLE}'",'
echo ${TABCLAUSE}

sqlplus -s ${STRINGCONNECT} << EOF
select DBMS_SODA.DROP_COLLECTION('${CNAME}') from dual;
declare
  metadata VARCHAR2(4000) :=
          '{
      ${TABCLAUSE}
      "contentColumn" : {
        "name" : "DATA",
        "sqlType": "BLOB",
        "jsonFormat" : "OSON"
      },
      "keyColumn" : {
       "name" : "ID",
       "assignmentMethod" : "EMBEDDED_OID",
      "path" : "_id"
     },
     "versionColumn" : {
        "name" : "VERSION",
        "method" : "UUID"
     },
     "lastModifiedColumn" : {
        "name" : "LAST_MODIFIED"
     },
     "creationTimeColumn" : {
        "name" : "CREATED_ON"
     }
   }';
   create_time varchar2(255);
begin
  DBMS_SODA_ADMIN.CREATE_COLLECTION(
                   P_URI_NAME    => '${CNAME}',
                   P_CREATE_MODE => 'MAP',
                   P_DESCRIPTOR  => metadata,
                   P_CREATE_TIME => create_time);
end;
/

exit
EOF
fi ## End condition on PARTTABLE

exit 0
