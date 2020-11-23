ALTER TABLE pl_access.roles
    ADD CONSTRAINT roles_systems_fk FOREIGN KEY ( dbsystem )
        REFERENCES pl_system.systems ( dbsystem );