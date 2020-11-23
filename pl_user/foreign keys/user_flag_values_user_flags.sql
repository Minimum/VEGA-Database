ALTER TABLE pl_user.user_flag_values
    ADD CONSTRAINT user_flag_values_user_flags_fk FOREIGN KEY ( dbflag )
        REFERENCES pl_user.user_flags ( dbflag );