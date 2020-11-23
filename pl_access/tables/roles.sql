/***********************************************************************************************************************
*  Purpose: RBAC roles
*
*  Date        Author      Description
*  ----------  ----------  --------------------------------------------------------------------------------------------
*  99/99/9999  MATTRO      Created! (VEGA-1)
***********************************************************************************************************************/
CREATE TABLE pl_access.roles (
    dbrole     BIGINT NOT NULL,
    dbversion  BIGINT NOT NULL,
    dbdeleted  BOOLEAN NOT NULL,
    dbsystem   BIGINT NOT NULL,
    dbname     VARCHAR(32),
    dbdesc     VARCHAR(256)
);

ALTER TABLE pl_access.roles ADD CONSTRAINT roles_pk PRIMARY KEY ( dbrole );

ALTER TABLE pl_access.roles
    ADD CONSTRAINT roles_systems_fk FOREIGN KEY ( dbsystem )
        REFERENCES pl_system.systems ( dbsystem );