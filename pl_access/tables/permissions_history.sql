/***********************************************************************************************************************
*  Purpose: RBAC permission history
*
*  Date        Author      Description
*  ----------  ----------  --------------------------------------------------------------------------------------------
*  99/99/9999  MATTRO      Created! (VEGA-1)
***********************************************************************************************************************/
CREATE TABLE pl_access.permissions_history (
    dbpermission    BIGINT NOT NULL,
    dbversion       BIGINT NOT NULL,
    dbdeleted       BOOLEAN NOT NULL,
    dbhistory_time  TIMESTAMPTZ,
    dbhistory_user  BIGINT,
    dbsystem        BIGINT,
    dbname          VARCHAR(32),
    dbdesc          VARCHAR(256)
);

ALTER TABLE pl_access.permissions_history ADD CONSTRAINT permissions_history_pk PRIMARY KEY ( dbpermission,
                                                                                              dbversion );