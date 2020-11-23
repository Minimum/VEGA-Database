/***********************************************************************************************************************
*  Purpose: User accounts
*
*  Date        Author      Description
*  ----------  ----------  ---------------------------------------------------------------------------------------------
*  99/99/9999  MATTRO      Created! (VEGA-1)
***********************************************************************************************************************/
CREATE TABLE pl_user.users (
    dbuser       BIGINT NOT NULL,
    dbuser_type  INTEGER NOT NULL,
    dbdeleted    BOOLEAN NOT NULL
);

ALTER TABLE pl_user.users ADD CONSTRAINT users_pk PRIMARY KEY ( dbuser );