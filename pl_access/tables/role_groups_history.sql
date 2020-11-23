/***********************************************************************************************************************
*  Purpose: RBAC role group history
*
*  Date        Author      Description
*  ----------  ----------  --------------------------------------------------------------------------------------------
*  99/99/9999  MATTRO      Created! (VEGA-1)
***********************************************************************************************************************/
CREATE TABLE pl_access.role_groups_history (
    dbrole_group    INTEGER NOT NULL,
    dbversion       BIGINT NOT NULL,
    dbdeleted       BOOLEAN NOT NULL,
    dbhistory_time  TIMESTAMPTZ,
    dbhistory_user  BIGINT,
    dbname          VARCHAR(64),
    dbdesc          VARCHAR(256)
);

ALTER TABLE pl_access.role_groups_history ADD CONSTRAINT role_groups_history_pk PRIMARY KEY ( dbrole_group,
                                                                                              dbversion );