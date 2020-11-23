/***********************************************************************************************************************
*  Purpose: User account flags
*
*  Date        Author      Description
*  ----------  ----------  ---------------------------------------------------------------------------------------------
*  99/99/9999  MATTRO      Created! (VEGA-1)
***********************************************************************************************************************/
CREATE TABLE pl_user.user_flags (
    dbflag  INTEGER NOT NULL,
    dbdesc  VARCHAR(32)
);

ALTER TABLE pl_user.user_flags ADD CONSTRAINT user_flags_pk PRIMARY KEY ( dbflag );