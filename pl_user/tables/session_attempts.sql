/***********************************************************************************************************************
*  Purpose: User session failed attempts
*
*  Date        Author      Description
*  ----------  ----------  ---------------------------------------------------------------------------------------------
*  99/99/9999  MATTRO      Created! (VEGA-1)
***********************************************************************************************************************/
CREATE TABLE pl_user.session_attempts (
    dbattempt           BIGINT NOT NULL,
    dbsession           BIGINT NOT NULL,
    dbstatus            INTEGER,
    dbtimestamp         TIMESTAMPTZ,
    dbaddress           INET,
    dbenvironment_info  VARCHAR(4096)
);

ALTER TABLE pl_user.session_attempts ADD CONSTRAINT session_attempts_pk PRIMARY KEY ( dbattempt );