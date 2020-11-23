ALTER TABLE pl_access.user_roles
    ADD CONSTRAINT user_roles_users_fk FOREIGN KEY ( dbuser )
        REFERENCES pl_user.users ( dbuser );