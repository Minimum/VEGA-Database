CREATE OR REPLACE FUNCTION pl_user.fn_set_session(p_session_id    BIGINT,
                                                  p_session_token UUID)
  RETURNS TABLE (
    dbsession_id         BIGINT,
    dbsession_token      UUID,
    dbsession_expiration TIMESTAMPTZ,
    dbuser               BIGINT
  ) AS $$
/**********************************************************************************************************************
*  Purpose: Sets the current transaction's session
*
*  Date        Author      Description
*  ----------  ----------  --------------------------------------------------------------------------------------------
*  99/99/9999  MATTRO      Created! (VEGA-1)
***********************************************************************************************************************/
DECLARE
  l_session_valid      BOOLEAN := FALSE;
  l_session_id         BIGINT  := p_session_id;
  l_session_token      UUID    := p_session_token;
  l_true_session_token UUID;
  l_expiration         TIMESTAMPTZ;
  l_expired            BOOLEAN;
  l_attempt_status     INTEGER;
  l_user               BIGINT := NULL;
BEGIN
  IF p_session_id IS NOT NULL THEN
    BEGIN
      SELECT dbtoken,
             dbexpired,
             dbexpiration,
             dbuser
        INTO l_true_session_token,
             l_expired,
             l_expiration,
             l_user
        FROM pl_user.sessions
       WHERE dbsession = p_session_id
         FOR UPDATE;
       
      CASE
        WHEN l_true_session_token != p_session_token THEN
          l_attempt_status := 2;
        WHEN l_expired THEN
          l_attempt_status := 3;
        WHEN l_expiration <= CURRENT_TIMESTAMP THEN
          l_attempt_status := 3;

          UPDATE pl_user.sessions
             SET dbexpired = TRUE
           WHERE dbsession = p_session;
        ELSE
          l_session_id    := p_session_id;
          l_session_valid := true;

          UPDATE pl_user.sessions
             SET dblast_active = CURRENT_TIMESTAMP
           WHERE dbsession = p_session_id;
      END CASE;
    EXCEPTION
      WHEN OTHERS THEN
        l_attempt_status := 1;
    END;

    IF NOT l_session_valid THEN
      INSERT INTO pl_user.session_attempts
             (dbattempt,
              dbsession,
              dbstatus,
              dbtimestamp,
              dbaddress,
              dbenvironment_info)
      VALUES (nextval('pl_user.seq_session_attempts'),
              p_session_id,
              l_attempt_status,
              CURRENT_TIMESTAMP,
              p_address,
              p_environment_info);
    END IF;
  END IF;

  IF NOT l_session_valid THEN
    l_session_id    := nextval('pl_user.seq_sessions');
    l_session_token := gen_random_uuid();
    l_expiration    := CURRENT_TIMESTAMP + interval '14 days';

    INSERT INTO pl_user.sessions
           (dbsession,
            dbtime_created,
            dbexpired,
            dbexpiration,
            dbtoken)
    VALUES (l_session_id,
            CURRENT_TIMESTAMP,
            FALSE,
            l_expiration,
            l_session_token);
  END IF;

  RETURN QUERY 
    SELECT l_session_id    dbsession_id,
           l_session_token dbsession_token,
           l_expiration    dbsession_expiration,
           l_user          dbuser;
END;
$$ LANGUAGE 'plpgsql';