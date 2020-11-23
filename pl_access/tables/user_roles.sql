/***********************************************************************************************************************
*  Purpose: Roles assigned to users
*
*  Date        Author      Description
*  ----------  ----------  --------------------------------------------------------------------------------------------
*  99/99/9999  MATTRO      Created! (VEGA-1)
***********************************************************************************************************************/
CREATE TABLE pl_access.user_roles (
    dbuser  BIGINT NOT NULL,
    dbrole  BIGINT NOT NULL
);

ALTER TABLE pl_access.user_roles ADD CONSTRAINT user_roles_pk PRIMARY KEY ( dbuser,
                                                                            dbrole );