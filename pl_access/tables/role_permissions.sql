/***********************************************************************************************************************
*  Purpose: Permissions assigned to roles
*
*  Date        Author      Description
*  ----------  ----------  --------------------------------------------------------------------------------------------
*  99/99/9999  MATTRO      Created! (VEGA-1)
***********************************************************************************************************************/
CREATE TABLE pl_access.role_permissions (
    dbrole        BIGINT NOT NULL,
    dbpermission  BIGINT NOT NULL
);

ALTER TABLE pl_access.role_permissions ADD CONSTRAINT role_permissions_pk PRIMARY KEY ( dbrole,
                                                                                        dbpermission );