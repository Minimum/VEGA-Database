ALTER TABLE pl_access.user_roles
    ADD CONSTRAINT user_roles_roles_fk FOREIGN KEY ( dbrole )
        REFERENCES pl_access.roles ( dbrole );