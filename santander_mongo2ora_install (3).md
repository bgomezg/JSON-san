# Install Mongo2Ora in a VM with RHEL8

## Prerequisites

You should have access to a VM with RHEL8 8.7.


## Create a User "idfix"

```Code
sudo -i

groupadd idfix

useradd -g idfix -m idfix

su - idfix
```


## Install GraalVM for Mongo2ora tool

```Code
wget -c https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-22.3.1/graalvm-ce-java19-linux-amd64-22.3.1.tar.gz


--Comando a usar para probar conexiones
 mongosh --tlsAllowInvalidCertificates 'mongodb://json_ords:Y_json_1105@isblccoraci0027.scisb.isban.corp:27017/json_ords?authMechanism=PLAIN&authSource=$external&ssl=true&retryWrites=false&loadBalanced=true'

--2023-05-11 05:27:27--  https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-22.3.1/graalvm-ce-java19-linux-amd64-22.3.1.tar.gz
Resolving github.com (github.com)... 140.82.121.3
Connecting to github.com (github.com)|140.82.121.3|:443... connected.
HTTP request sent, awaiting response... 302 Found
Location: https://objects.githubusercontent.com/github-production-release-asset-2e65be/222889977/10375ecf-b0e3-4d5b-b4de-33599f423325?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20230511%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20230511T092727Z&X-Amz-Expires=300&X-Amz-Signature=5ea6ca9f308e02f6f96d2099df3829071d31595eafb4c81b3829096ac98e959e&X-Amz-SignedHeaders=host&actor_id=0&key_id=0&repo_id=222889977&response-content-disposition=attachment%3B%20filename%3Dgraalvm-ce-java19-linux-amd64-22.3.1.tar.gz&response-content-type=application%2Foctet-stream [following]
--2023-05-11 05:27:27--  https://objects.githubusercontent.com/github-production-release-asset-2e65be/222889977/10375ecf-b0e3-4d5b-b4de-33599f423325?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20230511%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20230511T092727Z&X-Amz-Expires=300&X-Amz-Signature=5ea6ca9f308e02f6f96d2099df3829071d31595eafb4c81b3829096ac98e959e&X-Amz-SignedHeaders=host&actor_id=0&key_id=0&repo_id=222889977&response-content-disposition=attachment%3B%20filename%3Dgraalvm-ce-java19-linux-amd64-22.3.1.tar.gz&response-content-type=application%2Foctet-stream
Resolving objects.githubusercontent.com (objects.githubusercontent.com)... 185.199.110.133, 185.199.111.133, 185.199.108.133, ...
Connecting to objects.githubusercontent.com (objects.githubusercontent.com)|185.199.110.133|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 272370234 (260M) [application/octet-stream]
Saving to: ‘graalvm-ce-java19-linux-amd64-22.3.1.tar.gz’

graalvm-ce-java19-linux-amd64-22.3.1.t 100%[=========================================================================>] 259.75M  45.2MB/s    in 5.7s    

2023-05-11 05:27:33 (45.4 MB/s) - ‘graalvm-ce-java19-linux-amd64-22.3.1.tar.gz’ saved [272370234/272370234]
````

Uncompress the GraalVM software to be used by Mongo2Ora software.

```Code

tar -xzf graalvm-ce-java19-linux-amd64-22.3.1.tar.gz


[idfix@ordsrhel8 ~]$ ls -la
total 266012
drwx------.  3 idfix idfix       184 May 11 05:28 .
drwxr-xr-x.  5 root  root         51 May 11 05:22 ..
-rw-------.  1 idfix idfix       137 May 11 05:27 .bash_history
-rw-r--r--.  1 idfix idfix        18 Jun 20  2022 .bash_logout
-rw-r--r--.  1 idfix idfix       141 Jun 20  2022 .bash_profile
-rw-r--r--.  1 idfix idfix       376 Jun 20  2022 .bashrc
drwxrwxr-x. 10 idfix idfix      4096 May 11 05:28 graalvm-ce-java19-22.3.1
-rw-rw-r--.  1 idfix idfix 272370234 Jan 23 12:27 graalvm-ce-java19-linux-amd64-22.3.1.tar.gz
-rw-rw-r--.  1 idfix idfix       165 May 11 05:27 .wget-hsts
```


Add Environment Variables in the user idfix in the ".bash_profile"

```Code

export JAVA_HOME=/opt/oracle/graaljdk/graalvm-ce-java19-22.3.1
export PATH=${JAVA_HOME}/bin:$PATH

---pendiente agregar en el bash_profile para hacerlo definitivo

```

## Install Mongo2ora Software

The Mongo2Orasoftware has been published like open source [here](https://github.com/loiclefevre/mongo2ora.git).

Download the JAR file from [Download](https://github.com/loiclefevre/mongo2ora/releases/download/v1.2.1/mongo2ora-1.2.1-jar-with-dependencies.jar) & Upload to the VM in the "idfix" user home.

```Code
su - idfix

mkdir mongo2ora
cp mongo2ora-1.2.1-jar-with-dependencies.jar mongo2ora/.

```

Test the JAR execution with next command:

```Code
java --enable-preview -Xmx6G -Xms6G -XX:+UnlockExperimentalVMOptions -XX:G1MaxNewSizePercent=80 -XX:MaxTenuringThreshold=1 -jar mongo2ora-1.2.1-jar-with-dependencies.jar 

```

Output:


```Code

missing source
Usage: mongo2ora -s <source> -d <destination> -da <destination admin username> -dp <destination admin password> [options...]

where source can be a valid MongoDB connection string optionally enclosed between quotes or double quotes,
and where destination can be a valid Oracle database connection string optionally enclosed between quotes or double quotes
Options:
-p <number>: parallel threads to use (default number of vCPUs)
-b <batch size>: size of batch (default: 4096)
-c <comma-separated list of collection name(s)>: migrate only the selected collection(s)
--drop: drop existing collection(s) from the destination database

```

## Update the ORDS User 


Update the ORDS User created in the previous tutorial "JSON_ORDS" with the PDB_DBA admin "pdbadmin".

```Code

su - oracle

/opt/oracle/sqlcl/bin/sql pdbadmin/Welcome123##@//10.0.0.81:1521/pdb1


grant alter session, select_catalog_role to JSON_ORDS;
grant execute on ctxsys.CTX_DDL to JSON_ORDS; 
grant select any dictionary to JSON_ORDS;

grant connect, resource, soda_app, create session, create table, create view, create sequence, create procedure, create job, unlimited tablespace to CVGT;
grant alter session, select_catalog_role to CVGT;
grant execute on ctxsys.CTX_DDL to CVGT; 
grant select any dictionary to CVGT;


exit
```

## Execute Mongo2Ora


### Connect to Exadata or Database

To import all collections from a mongodump folder, you need to use the next commands

```Code
su - idfix

cd mongo2ora

java --enable-preview -Xmx6G -Xms6G -XX:+UnlockExperimentalVMOptions -XX:G1MaxNewSizePercent=80 -XX:MaxTenuringThreshold=1 -jar mongo2ora-1.2.1-jar-with-dependencies.jar -s 'mongodump:///opt/oracle/mongodb/mongodump/cvgt' -d 'CVGT/******@(description=(address=(protocol=tcp)(port=1521)(host=180.14.21.191))(connect_data=(service_name=otis1exa_cvgt.sgtech.pre.corp)))' -da pdbadmin -dp Z_pdb_1105 -p 2  --drop --oson --skip-secondary-indexes


-- This is the one to be used
-- Solution 1:

java --enable-preview -Xmx6G -Xms6G -XX:+UnlockExperimentalVMOptions -XX:G1MaxNewSizePercent=80 -XX:MaxTenuringThreshold=1 -jar mongo2ora-1.2.1-jar-with-dependencies.jar -s 'mongodump:///u03/dump/<dump db folder>' -d '<user>/<password>@(description=(retry_count=20)(retry_delay=3)(address=(protocol=tcp)(port=<port>)(host=<hostname|IP>))(connect_data=(service_name=<database service name>))(security=(ssl_server_dn_match=no)))' -da <user with DBA privileges> -dp <password of user with DBA privileges> -p 64  --drop --mongodbapi --skip-secondary-indexes

-- Solution 2:

java --enable-preview -Xmx6G -Xms6G -XX:+UnlockExperimentalVMOptions -XX:G1MaxNewSizePercent=80 -XX:MaxTenuringThreshold=1 -jar mongo2ora-1.2.1-jar-with-dependencies.jar -s 'mongodump:///u03/dump/<dump db folder>' -d '<user>/<password>@//<hostname>:<port>/<database service name>' -da <user with DBA privileges> -dp <password of user with DBA privileges> -p 64  --drop --mongodbapi --skip-secondary-indexes


-- Parameter 

user: JSON_ORDS
<user with DBA privileges> : pdbadmin


```

Example :

```Code

java --enable-preview -Xmx6G -Xms6G -XX:+UnlockExperimentalVMOptions -XX:G1MaxNewSizePercent=80 -XX:MaxTenuringThreshold=1 -jar mongo2ora-1.2.1-jar-with-dependencies.jar -s 'mongodump:///tmp/mongodump/json_ords' -d 'CVGT/Welcome1#@(description=(retry_count=20)(retry_delay=3)(address=(protocol=tcp)(port=1521)(host=10.0.0.81))(connect_data=(service_name=pdb1))(security=(ssl_server_dn_match=no)))' -da pdbadmin -dp Welcome123## -p 32  --drop --mongodbapi --skip-secondary-indexes

--adptamos a nuestro entorno

 mongosh --tlsAllowInvalidCertificates 'mongodb://json_ords:Y_json_1105@isblccoraci0027.scisb.isban.corp:27017/json_ords?authMechanism=PLAIN&authSource=$external&ssl=true&retryWrites=false&loadBalanced=true'
c3cssgtpre01-scan.sgtech.pre.corp:1521/otis1exa_cvgt_dev.sgtech.pre.corp


--not working
java --enable-preview -Xmx6G -Xms6G -XX:+UnlockExperimentalVMOptions -XX:G1MaxNewSizePercent=80 -XX:MaxTenuringThreshold=1 -jar mongo2ora-1.2.1-jar-with-dependencies.jar -s 'mongodump:///opt/oracle/mongodb/mongodump/cvgt' -d 'CVGT/******@(description=(retry_count=5)(retry_delay=3)(address=(protocol=tcp)(port=1521)(host=c3cssgtpre01-scan.sgtech.pre.corp))(connect_data=(service_name=otis1exa_cvgt_dev.sgtech.pre.corp))(security=(ssl_server_dn_match=no)))' -da pdbadmin -dp Z_pdb_1105 -p 2  --drop --oson --skip-secondary-indexes 
--not working
java --enable-preview -Xmx6G -Xms6G -XX:+UnlockExperimentalVMOptions -XX:G1MaxNewSizePercent=80 -XX:MaxTenuringThreshold=1 -jar mongo2ora-1.2.1-jar-with-dependencies.jar -s 'mongodump:///opt/oracle/mongodb/mongodump/cvgt' -d 'JSON_ORDS/Y_json_1105@(description=(retry_count=5)(retry_delay=3)(address=(protocol=tcp)(port=1521)(host=c3cssgtpre01-scan.sgtech.pre.corp))(connect_data=(service_name=otis1exa_cvgt_dev.sgtech.pre.corp)))' -da pdbadmin -dp Z_pdb_1105 -p 2  --drop --oson --skip-secondary-indexes    
--con PDBADMIN
java --enable-preview -Xmx6G -Xms6G -XX:+UnlockExperimentalVMOptions -XX:G1MaxNewSizePercent=80 -XX:MaxTenuringThreshold=1 -jar mongo2ora-1.2.1-jar-with-dependencies.jar -s 'mongodump:///opt/oracle/mongodb/mongodump/cvgt' -d 'JSON_ORDS/Y_json_1105@c3cssgtpre01-scan.sgtech.pre.corp:1521/otis1exa_cvgt_dev.sgtech.pre.corp' -da pdbadmin -dp Z_pdb_1105 -p 2  --drop --oson --skip-secondary-indexes 
--con SYSTEM

 export JAVA_HOME=/opt/oracle/graaljdk/graalvm-ce-java19-22.3.1
 export PATH=${JAVA_HOME}/bin:$PATH


 
java --enable-preview -Xmx6G -Xms6G -XX:+UnlockExperimentalVMOptions -XX:G1MaxNewSizePercent=80 -XX:MaxTenuringThreshold=1 -jar mongo2ora-1.2.1-jar-with-dependencies.jar -s 'mongodump:///opt/oracle/mongodb/mongodump/cvgt' -d 'JSON_ORDS/Y_json_1105@c3cssgtpre01-scan.sgtech.pre.corp:1521/otis1exa_cvgt_dev.sgtech.pre.corp' -da system -dp <> -p 2  --drop --oson --skip-secondary-indexes 

java --enable-preview -Xmx6G -Xms6G -XX:+UnlockExperimentalVMOptions -XX:G1MaxNewSizePercent=80 -XX:MaxTenuringThreshold=1 -jar mongo2ora-1.2.1-jar-with-dependencies.jar -s 'mongodump:///opt/oracle/mongodb/mongodump/cvgt' -d 'CVGT/******@(description=(address=(protocol=tcp)(port=1521)(host=180.14.21.191))(connect_data=(service_name=otis1exa_cvgt_dev.sgtech.pre.corp)))' -da pdbadmin -dp Z_pdb_1105 -p 2  --drop --oson --skip-secondary-indexes 


java --enable-preview -Xmx6G -Xms6G -XX:+UnlockExperimentalVMOptions -XX:G1MaxNewSizePercent=80 -XX:MaxTenuringThreshold=1 -jar mongo2ora-1.2.1-jar-with-dependencies.jar -s 'mongodump:///opt/oracle/mongodb/mongodump/cvgt' -d 'CVGT/******@(description=(address=(protocol=tcp)(port=1521)(host=180.14.21.191))(connect_data=(service_name=otis1exa_cvgt_dev.sgtech.pre.corp)))' -da pdbadmin -dp Z_pdb_1105 -p 2  --drop --oson --skip-secondary-indexes 

/opt/oracle/sqlcl/bin/sql cvgt/******@180.14.21.191:1521/otis1exa_cvgt_dev.sgtech.pre.corp


java --enable-preview -Xmx6G -Xms6G -XX:+UnlockExperimentalVMOptions -XX:G1MaxNewSizePercent=80 -XX:MaxTenuringThreshold=1 -jar mongo2ora-1.2.1-jar-with-dependencies.jar -s 'mongodump:///opt/oracle/mongodb/mongodump/cvgt' -d 'CVGT/******@(description=(address=(protocol=tcp)(port=1521)(host=180.14.21.191))(connect_data=(service_name=otis1exa_cvgt.sgtech.pre.corp)))' -da pdbadmin -dp Z_pdb_1105 -p 2  --drop --oson --skip-secondary-indexes


180.14.21.191

SELECT name, failover_type FROM DBA_SERVICES;



-- FUNCIONA!!!!! con nueva versión mongo2ora compatible con failover=y en tns
java --enable-preview -Xmx6G -Xms6G -XX:+UnlockExperimentalVMOptions -XX:G1MaxNewSizePercent=80 -XX:MaxTenuringThreshold=1 -jar mongo2ora-1.2.1-jar-with-dependencies.jar -s 'mongodump:///opt/oracle/mongodb/mongodump/cvgt' -d 'CVGT/******@(description=(address=(protocol=tcp)(port=1521)(host=180.14.21.191))(connect_data=(service_name=otis1exa_cvgt_dev.sgtech.pre.corp)))' -da pdbadmin -dp Z_pdb_1105 -p 8 --drop --oson --skip-secondary-indexes
--log ejecución
INFO  05-15 16:06:55,282 [org.mongodb.driver.main]: COUNTER THREADS=8
INFO  05-15 16:06:55,283 [org.mongodb.driver.main]: COUNTER THREADS PRIORITY=5
INFO  05-15 16:06:55,284 [org.mongodb.driver.main]: WORKER THREADS=8
INFO  05-15 16:06:55,284 [org.mongodb.driver.main]: WORKER THREADS PRIORITY=6
WARN  05-15 16:06:58,230 [org.mongodb.driver.index]: SODA collection does exist => dropping it (requested with --drop CLI argument)
INFO  05-15 16:06:58,352 [org.mongodb.driver.index]: SODA collection does exist => re-creating it
INFO  05-15 16:06:58,353 [org.mongodb.driver.index]: Using metadata: {
        "contentColumn" : {
           "name" : "JSON_DOCUMENT",
           "sqlType" : "BLOB",
           "jsonFormat" : "OSON"
        },
        "keyColumn" : {
           "name" : "ID"
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
}
INFO  05-15 16:06:58,945 [org.mongodb.driver.index]: IS JSON constraint found: SYS_C008608 for collection movimientos2
INFO  05-15 16:06:58,946 [org.mongodb.driver.index]: Disabling Is JSON constraint: SYS_C008608
INFO  05-15 16:06:59,177 [org.mongodb.driver.index]: Primary key found: SYS_C008609 for collection movimientos2 with status VALID
INFO  05-15 16:06:59,178 [org.mongodb.driver.index]: Dropping primary key and associated index: SYS_C008609 for collection movimientos2
INFO  05-15 16:06:59,178 [org.mongodb.driver.index]: Running: alter table CVGT.movimientos2 drop primary key drop index
INFO  05-15 16:06:59,228 [org.mongodb.driver.index]: Running: alter table CVGT.movimientos2 drop primary key drop index DONE!
INFO  05-15 16:06:59,312 [org.mongodb.driver.main]: Collection movimientos2 has 39926 JSON document(s).
INFO  05-15 16:06:59,350 [org.mongodb.driver.MongoCursorDump]: Collection movimientos2 has 39926 documents (skept 0 bytes, map 37242245 bytes in RAM).
INFO  05-15 16:07:01,310 [org.mongodb.driver.gui]: Current throughput: 20.29508686065674 MB/s; Maximum throughput: 20.29508686065674 MB/s
INFO  05-15 16:07:03,311 [org.mongodb.driver.gui]: Current throughput: 7.152557373046875E-6 MB/s; Maximum throughput: 20.29508686065674 MB/s
INFO  05-15 16:07:05,000 [org.mongodb.driver.index]: Enabling JSON constraint...
INFO  05-15 16:07:05,000 [org.mongodb.driver.index]: Re-Enabling Is JSON constraint NOVALIDATE
INFO  05-15 16:07:05,120 [org.mongodb.driver.index]: OK
INFO  05-15 16:07:05,120 [org.mongodb.driver.index]: Adding primary key constraint and index...
INFO  05-15 16:07:05,274 [org.mongodb.driver.index]: PK Index status is: ?
INFO  05-15 16:07:05,278 [org.mongodb.driver.index]: CREATE UNIQUE INDEX CVGT.SYS_C008609 ON CVGT.movimientos2(ID) PARALLEL 16
INFO  05-15 16:07:05,313 [org.mongodb.driver.gui]: Current throughput: 0.00225830078125 MB/s; Maximum throughput: 20.29508686065674 MB/s
INFO  05-15 16:07:05,762 [org.mongodb.driver.index]: ALTER TABLE CVGT.movimientos2 ADD CONSTRAINT SYS_C008609 PRIMARY KEY (ID) USING INDEX CVGT.SYS_C008609 ENABLE NOVALIDATE
INFO  05-15 16:07:05,782 [org.mongodb.driver.index]: Created PK constraint and index with parallel degree of 16 in 0.657s
-- fin log


--Descargamos nueva versión 15/05 del .jar con compatibilidad para TAC
--probamos el full dump con el contenido de la carpeta .../ntsaad3m
java --enable-preview -Xmx6G -Xms6G -XX:+UnlockExperimentalVMOptions -XX:G1MaxNewSizePercent=80 -XX:MaxTenuringThreshold=1 -jar mongo2ora-1.2.1-jar-with-dependencies.jar -s 'mongodump:///opt/oracle/mongodb/mongodump/ntsaad3m' -d 'CVGT/******@(description=(address=(protocol=tcp)(port=1521)(host=180.14.21.191))(connect_data=(service_name=otis1exa_cvgt_dev.sgtech.pre.corp)))' -da pdbadmin -dp Z_pdb_1105 -p 8 --drop --oson --skip-secondary-indexes


--Error 
Caused by: Error : 942, Position : 0, SQL = alter table propiedadesComunes add constraint propiedadesComunes_jd_is_json check (json_document is json format oson (size limit 32m)) novalidate, Original SQL = alter table propiedadesComunes add constraint propiedadesComunes_jd_is_json check (json_document is json format oson (size limit 32m)) novalidate, Error Message = ORA-00942: table or view does not exist

-- Vemos que el error se debe al formato del nombre de tabla, al venir una de las tablas con un solo caracter en MAY, las crea respetando este formato, el resto se ha creado en MAY sin errores.


--No funciona
alter table propiedadesComunes add constraint propiedadesComunes_jd_is_json check (json_document is json format oson (size limit 32m)) novalidate;
--SI funciona
alter "table propiedadesComunes" add constraint propiedadesComunes_jd_is_json check (json_document is json format oson (size limit 32m)) novalidate;

-- Solo fallaba esta tabla, por lo que hemos borrado y lanzado nuevamente con -c para solo esa colección

drop table "CVGT"."propiedadesComunes";


--only one collection -c collection_name
java --enable-preview -Xmx6G -Xms6G -XX:+UnlockExperimentalVMOptions -XX:G1MaxNewSizePercent=80 -XX:MaxTenuringThreshold=1 -jar mongo2ora-1.2.1-jar-with-dependencies.jar -s 'mongodump:///opt/oracle/mongodb/mongodump/ntsaad3m' -d 'CVGT/******@(description=(address=(protocol=tcp)(port=1521)(host=180.14.21.191))(connect_data=(service_name=otis1exa_cvgt_dev.sgtech.pre.corp)))' -da pdbadmin -dp Z_pdb_1105 -p 8 -c propiedadescomunes --drop --oson --skip-secondary-indexes
```
-- Revisamos que no hay más errores y que el número de registros coinciden, se chequean tablas con 0 registros pero coinciden con ficheros vacíos en el dumnp de origen.



To import some collections from a mongodump folder, you need to add one parameter "-c <collections list> "

```Code
su - idfix

cd mongo2ora

java --enable-preview -Xmx6G -Xms6G -XX:+UnlockExperimentalVMOptions -XX:G1MaxNewSizePercent=80 -XX:MaxTenuringThreshold=1 -jar mongo2ora-1.2.1-jar-with-dependencies.jar -s 'mongodump:///u03/dump/<dump folder>' -d '<user>/<password>@(description=(retry_count=20)(retry_delay=3)(address=(protocol=tcp)(port=<port>)(host=<hostname|IP>))(connect_data=(service_name=<database service name>))(security=(ssl_server_dn_match=no)))' -da <user with DBA privileges> -dp <password of user with DBA privileges> -p 64 -c <collections list> --drop --mongodbapi --skip-secondary-indexes

user: JSON_ORDS
<user with DBA privileges> : pdbadmin

```

Now, Mongo2Ora tool is working with Exadata or Database.


### Connect to Autonomous

To import all collections from a mongodump folder, you need to use the next commands

```Code
su - idfix

cd mongo2ora

java --enable-preview -Xmx6G -Xms6G -XX:+UnlockExperimentalVMOptions -XX:G1MaxNewSizePercent=80 -XX:MaxTenuringThreshold=1 -jar mongo2ora-1.2.1-jar-with-dependencies.jar -s 'mongodump:///u03/dump/<dump folder>' -d '<user>/<password>@(description=(retry_count=20)(retry_delay=3)(address=(protocol=tcps)(port=<port>)(host=<hostname|IP>))(connect_data=(service_name=<database service name>))(security=(ssl_server_dn_match=no)))' -da <user with DBA privileges> -dp <password of user with DBA privileges> -p 64  --drop --mongodbapi --skip-secondary-indexes

user: JSON_ORDS
<user with DBA privileges> : pdbadmin


```

Now, Mongo2Ora tool is working with Autonomous.


## Mongodump

How to extract a dump of Mongo DB Instance

```Code
export URI='mongodb://json_ords:Welcome1%23@10.0.0.81:27017/json_ords?authMechanism=PLAIN&authSource=$external&ssl=true&retryWrites=false&loadBalanced=true'


./mongodump --tlsInsecure --uri=$URI --out=/tmp/mongodump


```



