/***********************************************************************************************************************
*  Purpose: RBAC privileges
*
*  Date        Author      Description
*  ----------  ----------  --------------------------------------------------------------------------------------------
*  99/99/9999  MATTRO      Created! (VEGA-1)
***********************************************************************************************************************/
CREATE TABLE pl_access."PRIVILEGES" (
    dbprivilege  BIGINT NOT NULL,
    dbsystem     BIGINT NOT NULL,
    dbdeleted    BOOLEAN NOT NULL,
    dbversion    BIGINT NOT NULL,
    dbname       VARCHAR(32),
    dbdesc       VARCHAR(256)
);

ALTER TABLE pl_access."PRIVILEGES" ADD CONSTRAINT privileges_pk PRIMARY KEY ( dbprivilege );