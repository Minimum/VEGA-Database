ALTER TABLE pl_access.permission_privileges
    ADD CONSTRAINT permission_privileges_permissions_fk FOREIGN KEY ( dbpermission )
        REFERENCES pl_access.permissions ( dbpermission );