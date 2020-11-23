/***********************************************************************************************************************
*  Purpose: User sessions
*
*  Date        Author      Description
*  ----------  ----------  ---------------------------------------------------------------------------------------------
*  99/99/9999  MATTRO      Created! (VEGA-1)
***********************************************************************************************************************/
CREATE TABLE pl_user.sessions (
    dbsession       BIGINT NOT NULL,
    dbtoken         UUID NOT NULL,
    dbexpired       BOOLEAN,
    dbtime_created  TIMESTAMPTZ,
    dblast_active   TIMESTAMPTZ,
    dbexpiration    TIMESTAMPTZ,
    dbuser          BIGINT
);

ALTER TABLE pl_user.sessions ADD CONSTRAINT sessions_pk PRIMARY KEY ( dbsession );