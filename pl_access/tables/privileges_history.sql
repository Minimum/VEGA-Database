/***********************************************************************************************************************
*  Purpose: RBAC privilege history
*
*  Date        Author      Description
*  ----------  ----------  --------------------------------------------------------------------------------------------
*  99/99/9999  MATTRO      Created! (VEGA-1)
***********************************************************************************************************************/
CREATE TABLE pl_access.privileges_history (
    dbprivilege     BIGINT NOT NULL,
    dbversion       BIGINT NOT NULL,
    dbdeleted       BOOLEAN NOT NULL,
    dbhistory_time  TIMESTAMPTZ,
    dbhistory_user  BIGINT,
    dbsystem        BIGINT,
    dbname          VARCHAR(32),
    dbdesc          VARCHAR(256)
);

ALTER TABLE pl_access.privileges_history ADD CONSTRAINT privileges_history_pk PRIMARY KEY ( dbprivilege,
                                                                                            dbversion );