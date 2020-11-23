/***********************************************************************************************************************
*  Purpose: User account types
*
*  Date        Author      Description
*  ----------  ----------  ---------------------------------------------------------------------------------------------
*  99/99/9999  MATTRO      Created! (VEGA-1)
***********************************************************************************************************************/
CREATE TABLE pl_user.user_types (
    dbuser_type  INTEGER NOT NULL,
    dbdesc       VARCHAR(32)
);

ALTER TABLE pl_user.user_types ADD CONSTRAINT user_types_pk PRIMARY KEY ( dbuser_type );