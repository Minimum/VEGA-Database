ALTER TABLE pl_access.role_permissions
    ADD CONSTRAINT role_permissions_permissions_fk FOREIGN KEY ( dbpermission )
        REFERENCES pl_access.permissions ( dbpermission );