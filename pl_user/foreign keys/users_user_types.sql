ALTER TABLE pl_user.users
    ADD CONSTRAINT users_user_types_fk FOREIGN KEY ( dbuser_type )
        REFERENCES pl_user.user_types ( dbuser_type );