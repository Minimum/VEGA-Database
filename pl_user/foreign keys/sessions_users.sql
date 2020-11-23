ALTER TABLE pl_user.sessions
    ADD CONSTRAINT sessions_users_fk FOREIGN KEY ( dbuser )
        REFERENCES pl_user.users ( dbuser );