/***********************************************************************************************************************
*  Purpose: User privilege quick access external table
*
*  Date        Author      Description
*  ----------  ----------  --------------------------------------------------------------------------------------------
*  99/99/9999  MATTRO      Created! (VEGA-1)
***********************************************************************************************************************/
CREATE TABLE pl_access.user_privileges_ext (
    dbuser       BIGINT NOT NULL,
    dbprivilege  BIGINT NOT NULL
);

ALTER TABLE pl_access.user_privileges_ext ADD CONSTRAINT user_privileges_ext_pk PRIMARY KEY ( dbuser,
                                                                                              dbprivilege );