ALTER TABLE pl_access.role_permissions
    ADD CONSTRAINT role_permissions_roles_fk FOREIGN KEY ( dbrole )
        REFERENCES pl_access.roles ( dbrole );