/**********************************************************************************************************************
*  Purpose: Generates REST API code
*
*  Date        Author      Description
*  ----------  ----------  --------------------------------------------------------------------------------------------
*  99/99/9999  MATTRO      Created! (VEGA-1)
**********************************************************************************************************************/
CREATE OR REPLACE FUNCTION pl_dev.fn_gen_rest_api(IN p_schema            VARCHAR,
                                                  IN p_table_main        VARCHAR,
                                                  IN p_author            VARCHAR,
                                                  IN p_task_name         VARCHAR,
                                                  IN p_entity_name       VARCHAR,
                                                  IN p_display_name      VARCHAR,
                                                  IN p_versioned         BOOLEAN DEFAULT FALSE,
                                                  IN p_table_flags       VARCHAR DEFAULT NULL,
                                                  IN p_table_flag_values VARCHAR DEFAULT NULL)
  RETURNS TABLE (
    dbapi_main    TEXT,
    dbapi_flags   TEXT,
    dbapi_dal     TEXT
  ) AS $$
DECLARE
  l_base_api                TEXT := ' ';
  l_base_return             TEXT := ' ';
  l_base_return_parms       TEXT := ' ';
  l_base_select_parms       TEXT := ' ';
  l_base_select_query_cols  TEXT := ' ';
  l_base_select_query_where TEXT := ' ';
  l_base_edit_parms         TEXT := ' ';
  l_base_insert_cols        TEXT := ' ';
  l_base_insert_values      TEXT := ' ';
  l_base_update_cols        TEXT := ' ';
  l_base_edit_where         TEXT := ' ';
  l_base_delete_parms       TEXT := ' ';
  l_flag_api                TEXT := ' ';
  l_api_main                TEXT := ' ';
  l_api_flags               TEXT := ' ';
  l_api_dal                 TEXT := ' ';
  l_schema                  VARCHAR := LOWER(p_schema);
  l_table_main              VARCHAR := LOWER(p_table_main);
  l_first_col               BOOLEAN := TRUE;
  l_first_col_pk            BOOLEAN := TRUE;
  l_fn_base_indent          INTEGER := 38 + LENGTH(p_schema) + LENGTH(p_entity_name);
  i                         RECORD;
BEGIN
  FOR i IN 
  (
    WITH primary_key AS
    (
      SELECT cc.column_name
        FROM information_schema.table_constraints tc
        JOIN information_schema.constraint_column_usage cc
          ON cc.table_schema    = tc.table_schema
         AND cc.table_name      = tc.table_name
         AND cc.constraint_name = tc.constraint_name
       WHERE tc.table_schema    = l_schema
         AND tc.table_name      = l_table_main
         AND tc.constraint_type = 'PRIMARY KEY'
    ),
    column_list AS
    (
      SELECT c.column_name dbcolumn_name,
             CASE
               WHEN SUBSTRING(c.column_name, 1, 2) = 'db' THEN
                 SUBSTRING(c.column_name, 3)
               ELSE
                 c.column_name
             END dbparam_name,
             d.dbcode dbdatabase_type,
             (pk.column_name IS NOT NULL) dbprimary_key,
             c.ordinal_position
        FROM information_schema.columns c
        LEFT JOIN primary_key pk
          ON c.column_name = pk.column_name
        LEFT JOIN pl_dev.datatypes d
          ON d.dbudt_name = c.udt_name
       WHERE table_schema = l_schema
         AND table_name   = l_table_main
    ),
    column_stats AS
    (
      SELECT MAX(LENGTH(dbcolumn_name)) dblongest_column,
             MAX(LENGTH(dbparam_name)) dblongest_param
        FROM column_list
    )
    SELECT c.dbcolumn_name,
           c.dbparam_name,
           RPAD(c.dbcolumn_name, s.dblongest_column + 1, ' ') dbcolumn_name_indented,
           RPAD(c.dbparam_name, s.dblongest_param + 1, ' ') dbparam_name_indented,
           c.dbdatabase_type,
           c.dbprimary_key,
           s.dblongest_column
      FROM column_list c
     CROSS JOIN column_stats s
     ORDER BY c.ordinal_position
  ) LOOP
    IF l_first_col THEN
      l_base_return := i.dbcolumn_name_indented || i.dbdatabase_type;

      l_base_return_parms := 'p_' || i.dbparam_name;

      l_base_select_query_cols := i.dbcolumn_name;

      l_base_edit_parms := 'IN p_' || i.dbparam_name_indented || i.dbdatabase_type;

      l_base_insert_cols := i.dbcolumn_name;

      l_base_insert_values := 'p_' || i.dbparam_name;

      l_base_update_cols := i.dbcolumn_name_indented || '= p_' || i.dbparam_name;

      l_first_col := FALSE;
    ELSE
      l_base_return := l_base_return || ',
    ' || i.dbcolumn_name_indented || i.dbdatabase_type;

      l_base_return_parms := l_base_return_parms || ', p_' || i.dbparam_name;

      l_base_select_query_cols := l_base_select_query_cols || ',
           ' || i.dbcolumn_name;

      l_base_edit_parms := l_base_edit_parms || ',
' || LPAD('', l_fn_base_indent, ' ') || '       IN p_' || i.dbparam_name_indented || i.dbdatabase_type;

      l_base_insert_cols := l_base_insert_cols || ',
          ' || i.dbcolumn_name;

      l_base_insert_values := l_base_insert_values || ',
          p_' || i.dbparam_name;

      l_base_update_cols := l_base_update_cols || ',
         ' || i.dbcolumn_name_indented || '= p_' || i.dbparam_name;
    END IF;

    IF i.dbprimary_key THEN
      IF l_first_col_pk THEN
        l_base_select_parms := 'IN p_' || i.dbparam_name_indented || i.dbdatabase_type;

        l_base_select_query_where := i.dbcolumn_name_indented || '= p_' || i.dbparam_name;

        l_base_edit_where := i.dbcolumn_name_indented || '= p_' || i.dbparam_name;

        l_base_delete_parms := 'IN p_' || i.dbparam_name_indented || i.dbdatabase_type;

        l_first_col_pk := FALSE;
      ELSE
        l_base_select_parms := l_base_select_parms || ',
' || LPAD('', l_fn_base_indent, ' ') || 'IN p_' || i.dbparam_name_indented || i.dbdatabase_type;

        l_base_select_query_where := l_base_select_query_where || '
       AND ' || i.dbcolumn_name_indented || '= p_' || i.dbparam_name;

        l_base_edit_where := l_base_edit_where || '
     AND ' || i.dbcolumn_name_indented || '= p_' || i.dbparam_name;

        l_base_delete_parms := l_base_delete_parms || ',
       ' || LPAD('', l_fn_base_indent, ' ') || 'IN p_' || i.dbparam_name_indented || i.dbdatabase_type;
      END IF;
    END IF;
  END LOOP;

  l_api_main := '/**********************************************************************************************************************
*  Purpose: ' || p_display_name || ' REST API
*
*  Date        Author      Description
*  ----------  ----------  -------------------------------------------------------------------------------------------
*  99/99/9999  ' || RPAD(p_author, 10, ' ') || '  Created! (' || p_task_name || ')
**********************************************************************************************************************/

-- GET api.gslans.net/rest/
CREATE OR REPLACE FUNCTION ' || l_schema || '.rest_' || p_entity_name || '_select(' || l_base_select_parms || ')
  RETURNS TABLE (
    ' || l_base_return || '
  ) AS $' || '$
BEGIN
  RETURN QUERY
    SELECT ' || l_base_select_query_cols || '
      FROM ' || l_schema || '.' || l_table_main || '
     WHERE ' || l_base_select_query_where || ';
END;
$' || '$ LANGUAGE ''plpgsql'';

-- POST api.gslans.net/rest/
CREATE OR REPLACE FUNCTION ' || l_schema || '.rest_' || p_entity_name || '_insert(' || l_base_edit_parms || ')
  RETURNS TABLE (
    ' || l_base_return || '
  ) AS $' || '$
BEGIN
  INSERT INTO ' || l_schema || '.' || l_table_main || '
         (' || l_base_insert_cols || ')
  VALUES (' || l_base_insert_values || ');
  
  RETURN QUERY
    SELECT * FROM ' || l_schema || '.rest_' || p_entity_name || '(' || l_base_return_parms || ');
END;
$' || '$ LANGUAGE ''plpgsql'';

-- PUT api.gslans.net/rest/
CREATE OR REPLACE FUNCTION ' || l_schema || '.rest_' || p_entity_name || '_update(' || l_base_edit_parms || ')
  RETURNS TABLE (
    ' || l_base_return || '
  ) AS $' || '$
BEGIN
  UPDATE ' || l_schema || '.' || l_table_main || '
     SET ' || l_base_update_cols || '
   WHERE ' || l_base_edit_where || ';
  
  RETURN QUERY
    SELECT * FROM ' || l_schema || '.rest_' || p_entity_name || '(' || l_base_return_parms || ');
END;
$' || '$ LANGUAGE ''plpgsql'';

-- DELETE api.gslans.net/rest/
CREATE OR REPLACE FUNCTION ' || l_schema || '.rest_' || p_entity_name || '_delete(' || l_base_delete_parms || ')
  RETURNS VOID $' || '$
BEGIN
  DELETE FROM ' || l_schema || '.' || l_table_main || '
   WHERE ' || l_base_edit_where || ';
END;
$' || '$ LANGUAGE ''plpgsql'';';

  l_api_dal := ''; -- TODO: Create DAL class code

  IF p_table_flags IS NOT NULL AND p_table_flag_values IS NOT NULL THEN
    NULL; -- TODO: Create flag table code
  END IF;

  RETURN QUERY
    SELECT l_api_main dbapi_main,
           l_api_flags dbapi_flags,
           l_api_dal dbapi_dal;
END;
$$ LANGUAGE 'plpgsql';