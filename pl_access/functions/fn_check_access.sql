CREATE OR REPLACE FUNCTION pl_access.fn_check_access(IN p_user      BIGINT,
                                                     IN p_privilege BIGINT)
  RETURNS BOOLEAN AS $$
/***********************************************************************************************************************
*  Purpose: Checks if the given user has a specified privilege.
*
*  Date        Author      Description
*  ----------  ----------  ---------------------------------------------------------------------------------------------
*  99/99/9999  MATTRO      Created! (VEGA-1)
***********************************************************************************************************************/
DECLARE
  l_access BOOLEAN;
BEGIN
  SELECT COUNT(*) = 1
    INTO l_access
    FROM pl_access.mv_user_privileges_ext
   WHERE dbuser      = p_user
     AND dbprivilege = p_privilege;

  RETURN l_access;
END;
$$ LANGUAGE plpgsql;