CREATE OR REPLACE FUNCTION pl_system.fn_start_transaction(IN p_session_id       BIGINT,
                                                          IN p_session_token    UUID,
                                                          IN p_address          INET,
                                                          IN p_environment_info VARCHAR,
                                                          IN p_require_auth     BOOLEAN DEFAULT TRUE,
                                                          IN p_auth_system      BIGINT DEFAULT NULL,
                                                          IN p_auth_privilege   BIGINT DEFAULT NULL)
  RETURNS TABLE (
    dbsession_id    BIGINT,
    dbsession_token UUID,
    dbsuccess       BOOLEAN
  ) AS $$
/***********************************************************************************************************************
*  Purpose: Initializes the current transaction
*
*  Date        Author      Description
*  ----------  ----------  ---------------------------------------------------------------------------------------------
*  99/99/9999  MATTRO      Created! (VEGA-1)
***********************************************************************************************************************/
DECLARE
  l_session_id         BIGINT  := p_session_id;
  l_session_token      UUID    := p_session_token;
  l_success            BOOLEAN := TRUE;
  l_session_expiration TIMESTAMPTZ;
  l_user               BIGINT;
BEGIN
  SELECT s.dbsession_id,
         s.dbsession_token,
         s.dbsession_expiration,
         s.dbuser
    INTO l_session_id,
         l_session_token,
         l_session_expiration,
         l_user
    FROM pl_user.fn_set_session(l_session_id, l_session_token) s;

  l_success := NOT (p_require_auth AND 
                    (l_user IS NULL OR (p_auth_schema IS NOT NULL AND
                                        NOT pl_access.fn_check_access(l_user, p_auth_system, p_auth_permission, FALSE, TRUE))));

  RETURN QUERY 
    SELECT l_session_id         dbsession_id,
           l_session_token      dbsession_token,
           l_session_expiration dbsession_expiration,
           l_success            dbsuccess;
END;
$$ LANGUAGE 'plpgsql';