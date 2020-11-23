CREATE OR REPLACE FUNCTION pl_system.fn_is_production()
  RETURNS BOOLEAN AS $$
/**********************************************************************************************************************
*  Purpose: Returns if the system is in production or not.
*
*  Date        Author      Description
*  ----------  ----------  --------------------------------------------------------------------------------------------
*  99/99/9999  MATTRO      Created! (VEGA-1)
***********************************************************************************************************************/
BEGIN
  RETURN COALESCE(pl_setting.fn_get_boolean(1, 1, 1), FALSE);
END;
$$ LANGUAGE 'plpgsql';