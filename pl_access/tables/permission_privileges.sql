/***********************************************************************************************************************
*  Purpose: Privileges assigned to permissions
*
*  Date        Author      Description
*  ----------  ----------  --------------------------------------------------------------------------------------------
*  99/99/9999  MATTRO      Created! (VEGA-1)
***********************************************************************************************************************/
CREATE TABLE pl_access.permission_privileges (
    dbpermission  BIGINT NOT NULL,
    dbprivilege   BIGINT NOT NULL
);

ALTER TABLE pl_access.permission_privileges ADD CONSTRAINT permission_privileges_pk PRIMARY KEY ( dbpermission,
                                                                                                  dbprivilege );