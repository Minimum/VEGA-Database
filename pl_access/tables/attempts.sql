/***********************************************************************************************************************
*  Purpose: User access attempts
*
*  Date        Author      Description
*  ----------  ----------  --------------------------------------------------------------------------------------------
*  99/99/9999  MATTRO      Created! (VEGA-1)
***********************************************************************************************************************/
CREATE TABLE pl_access.attempts (
    dbattempt           BIGINT NOT NULL,
    dbprivilege         BIGINT NOT NULL,
    dbsession           BIGINT NOT NULL,
    dbsuccess           BOOLEAN NOT NULL,
    dbtimestamp         TIMESTAMPTZ,
    dbaddress           INET,
    dbenvironment_info  VARCHAR(4096),
    dbmessage           VARCHAR(128)
);

ALTER TABLE pl_access.attempts ADD CONSTRAINT attempts_pk PRIMARY KEY ( dbattempt );