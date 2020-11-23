ALTER TABLE pl_user.user_flag_values
    ADD CONSTRAINT user_flag_values_users_fk FOREIGN KEY ( dbuser )
        REFERENCES pl_user.users ( dbuser );