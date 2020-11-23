/***********************************************************************************************************************
*  Purpose: VEGA system history
*
*  Date        Author      Description
*  ----------  ----------  --------------------------------------------------------------------------------------------
*  99/99/9999  MATTRO      Created! (VEGA-1)
***********************************************************************************************************************/
CREATE TABLE pl_system.systems_history (
    dbsystem        BIGINT NOT NULL,
    dbversion       BIGINT NOT NULL,
    dbdeleted       BOOLEAN NOT NULL,
    dbhistory_time  TIMESTAMPTZ,
    dbhistory_user  BIGINT,
    dbname          VARCHAR(32),
    dbdesc          VARCHAR(256)
);

ALTER TABLE pl_system.systems_history ADD CONSTRAINT systems_history_pk PRIMARY KEY ( dbsystem,
                                                                                      dbversion );