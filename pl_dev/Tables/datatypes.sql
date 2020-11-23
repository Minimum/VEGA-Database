CREATE TABLE pl_dev.datatypes (
    dbdatatype  INTEGER NOT NULL,
    dbudt_name  VARCHAR(64),
    dbcode      VARCHAR(64)
);

ALTER TABLE pl_dev.datatypes ADD CONSTRAINT datatypes_pk PRIMARY KEY ( dbdatatype );