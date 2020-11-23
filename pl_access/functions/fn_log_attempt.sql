CREATE OR REPLACE FUNCTION pl_access.fn_check_access(IN p_session          BIGINT,
                                                     IN p_privilege        BIGINT,
                                                     IN p_success          BOOLEAN,
                                                     IN p_address          INET,
                                                     IN p_environment_info VARCHAR,
                                                     IN p_message          VARCHAR)
  RETURNS BOOLEAN AS $$
/***********************************************************************************************************************
*  Purpose: Logs an access attempt.
*
*  Date        Author      Description
*  ----------  ----------  ---------------------------------------------------------------------------------------------
*  99/99/9999  MATTRO      Created! (VEGA-1)
***********************************************************************************************************************/
DECLARE
BEGIN
  INSERT INTO pl_user.access_attempts
         (dbattempt,
          dbprivilege,
          dbsession,
          dbsuccess,
          dbtimestamp,
          dbaddress,
          dbenvironment_info,
          dbmessage)
  VALUES (nextval('pl_access.seq_access_attempts'),
          p_privilege,
          p_session,
          p_success,
          CURRENT_TIMESTAMP,
          p_address,
          p_environment_info,
          p_message);
END;
$$ LANGUAGE plpgsql;