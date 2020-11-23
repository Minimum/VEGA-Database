/***********************************************************************************************************************
*  Purpose: VEGA systems
*
*  Date        Author      Description
*  ----------  ----------  --------------------------------------------------------------------------------------------
*  99/99/9999  MATTRO      Created! (VEGA-1)
***********************************************************************************************************************/
CREATE TABLE pl_system.systems (
    dbsystem   BIGINT NOT NULL,
    dbversion  BIGINT NOT NULL,
    dbdeleted  BOOLEAN NOT NULL,
    dbname     VARCHAR(32),
    dbdesc     VARCHAR(256)
);

ALTER TABLE pl_system.systems ADD CONSTRAINT systems_pk PRIMARY KEY ( dbsystem );