ALTER TABLE pl_access."PRIVILEGES"
    ADD CONSTRAINT privileges_systems_fk FOREIGN KEY ( dbsystem )
        REFERENCES pl_system.systems ( dbsystem );