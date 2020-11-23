/***********************************************************************************************************************
*  Purpose: User account flag values
*
*  Date        Author      Description
*  ----------  ----------  ---------------------------------------------------------------------------------------------
*  99/99/9999  MATTRO      Created! (VEGA-1)
***********************************************************************************************************************/
CREATE TABLE pl_user.user_flag_values (
    dbuser   BIGINT NOT NULL,
    dbflag   INTEGER NOT NULL,
    dbvalue  BOOLEAN NOT NULL
);

ALTER TABLE pl_user.user_flag_values ADD CONSTRAINT user_flag_values_pk PRIMARY KEY ( dbuser,
                                                                                      dbflag );