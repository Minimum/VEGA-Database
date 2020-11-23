/***********************************************************************************************************************
*  Purpose: RBAC role groups
*
*  Date        Author      Description
*  ----------  ----------  --------------------------------------------------------------------------------------------
*  99/99/9999  MATTRO      Created! (VEGA-1)
***********************************************************************************************************************/
CREATE TABLE pl_access.role_groups (
    dbrole_group  INTEGER NOT NULL,
    dbversion     BIGINT NOT NULL,
    dbdeleted     BOOLEAN,
    dbname        VARCHAR(64),
    dbdesc        VARCHAR(256)
);

ALTER TABLE pl_access.role_groups ADD CONSTRAINT role_groups_pk PRIMARY KEY ( dbrole_group );