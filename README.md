
declare
   METADATA varchar2(8000);
   COL SODA_COLLECTION_T;
begin
   METADATA := '{"tableName" : "MOVIMIENTOS_HISMO_AHORRO_0",
                 "keyColumn" : {
					"name" : "ID",
					"assignmentMethod" : "EMBEDDED_OID",
					"path" : "_id"
				},
                 "contentColumn":{"name":"DATA",
                                  "sqlType":"BLOB",
								  "jsonFormat":"OSON"},
                 "versionColumn":{"name":"VERSION",
                                  "method":"SHA256"},
                 "lastModifiedColumn":{"name":"LAST_MODIFIED"},
                 "creationTimeColumn":{"name":"CREATED_ON"},
                 "readOnly":false}';
   -- Create a collection using "map" mode, based on the table we've created above and specified in
   -- the custom metadata under "tableName" field.
   COL := dbms_soda.create_collection('movimientos_hismo_ahorro_0', METADATA, DBMS_SODA.CREATE_MODE_MAP);
end;
/
