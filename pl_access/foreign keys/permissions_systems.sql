ALTER TABLE pl_access.permissions
    ADD CONSTRAINT permissions_systems_fk FOREIGN KEY ( dbsystem )
        REFERENCES pl_system.systems ( dbsystem );