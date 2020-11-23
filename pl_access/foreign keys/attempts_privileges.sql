ALTER TABLE pl_access.attempts
    ADD CONSTRAINT attempts_privileges_fk FOREIGN KEY ( dbprivilege )
        REFERENCES pl_access."PRIVILEGES" ( dbprivilege );