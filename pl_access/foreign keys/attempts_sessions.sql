ALTER TABLE pl_access.attempts
    ADD CONSTRAINT attempts_sessions_fk FOREIGN KEY ( dbsession )
        REFERENCES pl_user.sessions ( dbsession );