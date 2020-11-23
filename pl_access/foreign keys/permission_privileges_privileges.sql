ALTER TABLE pl_access.permission_privileges
    ADD CONSTRAINT permission_privileges_privileges_fk FOREIGN KEY ( dbprivilege )
        REFERENCES pl_access."PRIVILEGES" ( dbprivilege );