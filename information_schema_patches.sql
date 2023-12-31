--
-- information_schema patches
--

-- give access to readonly user not owner of table
-- for constraint related meta views of types
-- primary key, unique, check and foreign key

-- original view definitions from v16

/*

CREATE OR REPLACE VIEW information_schema.table_constraints AS
 SELECT current_database()::information_schema.sql_identifier AS constraint_catalog,
    nc.nspname::information_schema.sql_identifier AS constraint_schema,
    c.conname::information_schema.sql_identifier AS constraint_name,
    current_database()::information_schema.sql_identifier AS table_catalog,
    nr.nspname::information_schema.sql_identifier AS table_schema,
    r.relname::information_schema.sql_identifier AS table_name,
        CASE c.contype
            WHEN 'c'::"char" THEN 'CHECK'::text
            WHEN 'f'::"char" THEN 'FOREIGN KEY'::text
            WHEN 'p'::"char" THEN 'PRIMARY KEY'::text
            WHEN 'u'::"char" THEN 'UNIQUE'::text
            ELSE NULL::text
        END::information_schema.character_data AS constraint_type,
        CASE
            WHEN c.condeferrable THEN 'YES'::text
            ELSE 'NO'::text
        END::information_schema.yes_or_no AS is_deferrable,
        CASE
            WHEN c.condeferred THEN 'YES'::text
            ELSE 'NO'::text
        END::information_schema.yes_or_no AS initially_deferred,
    'YES'::character varying::information_schema.yes_or_no AS enforced,
        CASE
            WHEN c.contype = 'u'::"char" THEN
            CASE
                WHEN ( SELECT NOT pg_index.indnullsnotdistinct
                   FROM pg_index
                  WHERE pg_index.indexrelid = c.conindid) THEN 'YES'::text
                ELSE 'NO'::text
            END
            ELSE NULL::text
        END::information_schema.yes_or_no AS nulls_distinct
   FROM pg_namespace nc,
    pg_namespace nr,
    pg_constraint c,
    pg_class r
  WHERE nc.oid = c.connamespace AND nr.oid = r.relnamespace AND c.conrelid = r.oid AND (c.contype <> ALL (ARRAY['t'::"char", 'x'::"char"])) AND (r.relkind = ANY (ARRAY['r'::"char", 'p'::"char"])) AND NOT pg_is_other_temp_schema(nr.oid) AND (pg_has_role(r.relowner, 'USAGE'::text) OR has_table_privilege(r.oid, 'INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER'::text) OR has_any_column_privilege(r.oid, 'INSERT, UPDATE, REFERENCES'::text))
UNION ALL
 SELECT current_database()::information_schema.sql_identifier AS constraint_catalog,
    nr.nspname::information_schema.sql_identifier AS constraint_schema,
    (((((nr.oid::text || '_'::text) || r.oid::text) || '_'::text) || a.attnum::text) || '_not_null'::text)::information_schema.sql_identifier AS constraint_name,
    current_database()::information_schema.sql_identifier AS table_catalog,
    nr.nspname::information_schema.sql_identifier AS table_schema,
    r.relname::information_schema.sql_identifier AS table_name,
    'CHECK'::character varying::information_schema.character_data AS constraint_type,
    'NO'::character varying::information_schema.yes_or_no AS is_deferrable,
    'NO'::character varying::information_schema.yes_or_no AS initially_deferred,
    'YES'::character varying::information_schema.yes_or_no AS enforced,
    NULL::character varying::information_schema.yes_or_no AS nulls_distinct
   FROM pg_namespace nr,
    pg_class r,
    pg_attribute a
  WHERE nr.oid = r.relnamespace AND r.oid = a.attrelid AND a.attnotnull AND a.attnum > 0 AND NOT a.attisdropped AND (r.relkind = ANY (ARRAY['r'::"char", 'p'::"char"])) AND NOT pg_is_other_temp_schema(nr.oid) AND (pg_has_role(r.relowner, 'USAGE'::text) OR has_table_privilege(r.oid, 'INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER'::text) OR has_any_column_privilege(r.oid, 'INSERT, UPDATE, REFERENCES'::text));


CREATE OR REPLACE VIEW information_schema.constraint_table_usage AS
 SELECT current_database()::information_schema.sql_identifier AS table_catalog,
    nr.nspname::information_schema.sql_identifier AS table_schema,
    r.relname::information_schema.sql_identifier AS table_name,
    current_database()::information_schema.sql_identifier AS constraint_catalog,
    nc.nspname::information_schema.sql_identifier AS constraint_schema,
    c.conname::information_schema.sql_identifier AS constraint_name
   FROM pg_constraint c,
    pg_namespace nc,
    pg_class r,
    pg_namespace nr
  WHERE c.connamespace = nc.oid AND r.relnamespace = nr.oid AND (c.contype = 'f'::"char" AND c.confrelid = r.oid OR (c.contype = ANY (ARRAY['p'::"char", 'u'::"char"])) AND c.conrelid = r.oid) AND (r.relkind = ANY (ARRAY['r'::"char", 'p'::"char"])) AND pg_has_role(r.relowner, 'USAGE'::text);


CREATE OR REPLACE VIEW information_schema.constraint_column_usage AS
 SELECT current_database()::information_schema.sql_identifier AS table_catalog,
    tblschema::information_schema.sql_identifier AS table_schema,
    tblname::information_schema.sql_identifier AS table_name,
    colname::information_schema.sql_identifier AS column_name,
    current_database()::information_schema.sql_identifier AS constraint_catalog,
    cstrschema::information_schema.sql_identifier AS constraint_schema,
    cstrname::information_schema.sql_identifier AS constraint_name
   FROM ( SELECT DISTINCT nr.nspname,
            r.relname,
            r.relowner,
            a.attname,
            nc.nspname,
            c.conname
           FROM pg_namespace nr,
            pg_class r,
            pg_attribute a,
            pg_depend d,
            pg_namespace nc,
            pg_constraint c
          WHERE nr.oid = r.relnamespace AND r.oid = a.attrelid AND d.refclassid = 'pg_class'::regclass::oid AND d.refobjid = r.oid AND d.refobjsubid = a.attnum AND d.classid = 'pg_constraint'::regclass::oid AND d.objid = c.oid AND c.connamespace = nc.oid AND c.contype = 'c'::"char" AND (r.relkind = ANY (ARRAY['r'::"char", 'p'::"char"])) AND NOT a.attisdropped
        UNION ALL
         SELECT nr.nspname,
            r.relname,
            r.relowner,
            a.attname,
            nc.nspname,
            c.conname
           FROM pg_namespace nr,
            pg_class r,
            pg_attribute a,
            pg_namespace nc,
            pg_constraint c
          WHERE nr.oid = r.relnamespace AND r.oid = a.attrelid AND nc.oid = c.connamespace AND r.oid =
                CASE c.contype
                    WHEN 'f'::"char" THEN c.confrelid
                    ELSE c.conrelid
                END AND (a.attnum = ANY (
                CASE c.contype
                    WHEN 'f'::"char" THEN c.confkey
                    ELSE c.conkey
                END)) AND NOT a.attisdropped AND (c.contype = ANY (ARRAY['p'::"char", 'u'::"char", 'f'::"char"])) AND (r.relkind = ANY (ARRAY['r'::"char", 'p'::"char"]))) x(tblschema, tblname, tblowner, colname, cstrschema, cstrname)
  WHERE pg_has_role(tblowner, 'USAGE'::text);


CREATE OR REPLACE VIEW information_schema.key_column_usage AS
 SELECT current_database()::information_schema.sql_identifier AS constraint_catalog,
    ss.nc_nspname::information_schema.sql_identifier AS constraint_schema,
    ss.conname::information_schema.sql_identifier AS constraint_name,
    current_database()::information_schema.sql_identifier AS table_catalog,
    ss.nr_nspname::information_schema.sql_identifier AS table_schema,
    ss.relname::information_schema.sql_identifier AS table_name,
    a.attname::information_schema.sql_identifier AS column_name,
    (ss.x).n::information_schema.cardinal_number AS ordinal_position,
        CASE
            WHEN ss.contype = 'f'::"char" THEN information_schema._pg_index_position(ss.conindid, ss.confkey[(ss.x).n])
            ELSE NULL::integer
        END::information_schema.cardinal_number AS position_in_unique_constraint
   FROM pg_attribute a,
    ( SELECT r.oid AS roid,
            r.relname,
            r.relowner,
            nc.nspname AS nc_nspname,
            nr.nspname AS nr_nspname,
            c.oid AS coid,
            c.conname,
            c.contype,
            c.conindid,
            c.confkey,
            c.confrelid,
            information_schema._pg_expandarray(c.conkey) AS x
           FROM pg_namespace nr,
            pg_class r,
            pg_namespace nc,
            pg_constraint c
          WHERE nr.oid = r.relnamespace AND r.oid = c.conrelid AND nc.oid = c.connamespace AND (c.contype = ANY (ARRAY['p'::"char", 'u'::"char", 'f'::"char"])) AND (r.relkind = ANY (ARRAY['r'::"char", 'p'::"char"])) AND NOT pg_is_other_temp_schema(nr.oid)) ss
  WHERE ss.roid = a.attrelid AND a.attnum = (ss.x).x AND NOT a.attisdropped AND (pg_has_role(ss.relowner, 'USAGE'::text) OR has_column_privilege(ss.roid, a.attnum, 'SELECT, INSERT, UPDATE, REFERENCES'::text));


CREATE OR REPLACE VIEW information_schema.check_constraints AS
 SELECT current_database()::information_schema.sql_identifier AS constraint_catalog,
    rs.nspname::information_schema.sql_identifier AS constraint_schema,
    con.conname::information_schema.sql_identifier AS constraint_name,
    SUBSTRING(pg_get_constraintdef(con.oid) FROM 7)::information_schema.character_data AS check_clause
   FROM pg_constraint con
     LEFT JOIN pg_namespace rs ON rs.oid = con.connamespace
     LEFT JOIN pg_class c ON c.oid = con.conrelid
     LEFT JOIN pg_type t ON t.oid = con.contypid
  WHERE pg_has_role(COALESCE(c.relowner, t.typowner), 'USAGE'::text) AND con.contype = 'c'::"char"
UNION
 SELECT current_database()::information_schema.sql_identifier AS constraint_catalog,
    n.nspname::information_schema.sql_identifier AS constraint_schema,
    (((((n.oid::text || '_'::text) || r.oid::text) || '_'::text) || a.attnum::text) || '_not_null'::text)::information_schema.sql_identifier AS constraint_name,
    (a.attname::text || ' IS NOT NULL'::text)::information_schema.character_data AS check_clause
   FROM pg_namespace n,
    pg_class r,
    pg_attribute a
  WHERE n.oid = r.relnamespace AND r.oid = a.attrelid AND a.attnum > 0 AND NOT a.attisdropped AND a.attnotnull AND (r.relkind = ANY (ARRAY['r'::"char", 'p'::"char"])) AND pg_has_role(r.relowner, 'USAGE'::text)


*/


-- modified view definitions with extended permissions (last condition mostly)
-- these need to be executed by the postgres super user


CREATE OR REPLACE VIEW information_schema.constraint_table_usage AS
 SELECT current_database()::information_schema.sql_identifier AS table_catalog,
    nr.nspname::information_schema.sql_identifier AS table_schema,
    r.relname::information_schema.sql_identifier AS table_name,
    current_database()::information_schema.sql_identifier AS constraint_catalog,
    nc.nspname::information_schema.sql_identifier AS constraint_schema,
    c.conname::information_schema.sql_identifier AS constraint_name
   FROM pg_constraint c,
    pg_namespace nc,
    pg_class r,
    pg_namespace nr
  WHERE c.connamespace = nc.oid AND r.relnamespace = nr.oid AND (c.contype = 'f'::"char" AND c.confrelid = r.oid OR (c.contype = ANY (ARRAY['p'::"char", 'u'::"char"])) AND c.conrelid = r.oid) AND (r.relkind = ANY (ARRAY['r'::"char", 'p'::"char"])) AND  (pg_has_role(r.relowner, 'USAGE'::text) OR has_table_privilege(r.oid, 'INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER'::text) OR has_any_column_privilege(r.oid, 'INSERT, UPDATE, REFERENCES'::text));


CREATE OR REPLACE VIEW information_schema.check_constraints AS
 SELECT current_database()::information_schema.sql_identifier AS constraint_catalog,
    rs.nspname::information_schema.sql_identifier AS constraint_schema,
    con.conname::information_schema.sql_identifier AS constraint_name,
    SUBSTRING(pg_get_constraintdef(con.oid) FROM 7)::information_schema.character_data AS check_clause
   FROM pg_constraint con
     LEFT JOIN pg_namespace rs ON rs.oid = con.connamespace
     LEFT JOIN pg_class c ON c.oid = con.conrelid
     LEFT JOIN pg_type t ON t.oid = con.contypid
  WHERE con.contype = 'c'::"char" AND (pg_has_role(COALESCE(c.relowner, t.typowner), 'USAGE'::text) OR has_table_privilege(c.oid, 'INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER'::text) OR has_any_column_privilege(c.oid, 'INSERT, UPDATE, REFERENCES'::text))
UNION
 SELECT current_database()::information_schema.sql_identifier AS constraint_catalog,
    n.nspname::information_schema.sql_identifier AS constraint_schema,
    (((((n.oid::text || '_'::text) || r.oid::text) || '_'::text) || a.attnum::text) || '_not_null'::text)::information_schema.sql_identifier AS constraint_name,
    (a.attname::text || ' IS NOT NULL'::text)::information_schema.character_data AS check_clause
   FROM pg_namespace n,
    pg_class r,
    pg_attribute a
  WHERE n.oid = r.relnamespace AND r.oid = a.attrelid AND a.attnum > 0 AND NOT a.attisdropped AND a.attnotnull AND (r.relkind = ANY (ARRAY['r'::"char", 'p'::"char"])) AND (pg_has_role(r.relowner, 'USAGE'::text) OR has_table_privilege(r.oid, 'INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER'::text) OR has_any_column_privilege(r.oid, 'INSERT, UPDATE, REFERENCES'::text));


CREATE OR REPLACE VIEW information_schema.constraint_column_usage AS
 SELECT current_database()::information_schema.sql_identifier AS table_catalog,
    tblschema::information_schema.sql_identifier AS table_schema,
    tblname::information_schema.sql_identifier AS table_name,
    colname::information_schema.sql_identifier AS column_name,
    current_database()::information_schema.sql_identifier AS constraint_catalog,
    cstrschema::information_schema.sql_identifier AS constraint_schema,
    cstrname::information_schema.sql_identifier AS constraint_name
   FROM ( SELECT DISTINCT nr.nspname,
            r.relname,
            r.relowner,
	    r.oid,
            a.attname,
            nc.nspname,
            c.conname
           FROM pg_namespace nr,
            pg_class r,
            pg_attribute a,
            pg_depend d,
            pg_namespace nc,
            pg_constraint c
          WHERE nr.oid = r.relnamespace AND r.oid = a.attrelid AND d.refclassid = 'pg_class'::regclass::oid AND d.refobjid = r.oid AND d.refobjsubid = a.attnum AND d.classid = 'pg_constraint'::regclass::oid AND d.objid = c.oid AND c.connamespace = nc.oid AND c.contype = 'c'::"char" AND (r.relkind = ANY (ARRAY['r'::"char", 'p'::"char"])) AND NOT a.attisdropped
        UNION ALL
         SELECT nr.nspname,
            r.relname,
            r.relowner,
	    r.oid,
            a.attname,
            nc.nspname,
            c.conname
           FROM pg_namespace nr,
            pg_class r,
            pg_attribute a,
            pg_namespace nc,
            pg_constraint c
          WHERE nr.oid = r.relnamespace AND r.oid = a.attrelid AND nc.oid = c.connamespace AND r.oid =
                CASE c.contype
                    WHEN 'f'::"char" THEN c.confrelid
                    ELSE c.conrelid
                END AND (a.attnum = ANY (
                CASE c.contype
                    WHEN 'f'::"char" THEN c.confkey
                    ELSE c.conkey
                END)) AND NOT a.attisdropped AND (c.contype = ANY (ARRAY['p'::"char", 'u'::"char", 'f'::"char"])) AND (r.relkind = ANY (ARRAY['r'::"char", 'p'::"char"]))) x(tblschema, tblname, tblowner, tbloid, colname, cstrschema, cstrname)
  WHERE (pg_has_role(tblowner, 'USAGE'::text) OR has_table_privilege(tbloid, 'INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER'::text) OR has_any_column_privilege(tbloid, 'INSERT, UPDATE, REFERENCES'::text));


--- EOF
