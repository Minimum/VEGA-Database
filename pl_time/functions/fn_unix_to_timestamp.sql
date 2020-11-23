CREATE OR REPLACE FUNCTION pl_time.fn_unix_to_timestamp(IN p_timestamp BIGINT)
  RETURNS TIMESTAMPTZ AS $$
/**********************************************************************************************************************
*  Purpose: Converts a unix timestamp to a PGSQL timestamp
*
*  Date        Author      Description
*  ----------  ----------  --------------------------------------------------------------------------------------------
*  99/99/9999  MATTRO      Created! (VEGA-1)
***********************************************************************************************************************/
DECLARE
  l_timestamp TIMESTAMPTZ;
BEGIN
  SELECT TIMESTAMPTZ 'epoch' + p_timestamp * INTERVAL '1 second'
    INTO l_timestamp;

  RETURN l_timestamp;
END;
$$ LANGUAGE plpgsql;