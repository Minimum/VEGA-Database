CREATE MATERIALIZED VIEW pl_access.mv_user_privileges_ext AS
/***********************************************************************************************************************
*  Purpose: Displays all privileges each user has access to.
*
*  Date        Author      Description
*  ----------  ----------  ---------------------------------------------------------------------------------------------
*  99/99/9999  MATTRO      Created! (VEGA-1)
***********************************************************************************************************************/
  SELECT u.dbuser,
         pri.dbprivilege
    FROM pl_user.users u
    JOIN pl_access.user_roles ur
      ON ur.dbuser = u.dbuser
    JOIN pl_access.roles r
      ON r.dbrole    = ur.dbrole
     AND r.dbdeleted = FALSE
    JOIN pl_access.role_permissions rp
      ON rp.dbrole = ur.dbrole
    JOIN pl_access.permissions per
      ON per.dbpermission = rp.dbpermission
     AND per.dbdeleted    = FALSE
    JOIN pl_access.permission_privileges pp
      ON pp.dbpermission = rp.dbpermission
    JOIN pl_access.privileges pri
      ON pri.dbprivilege = pp.dbprivilege
     AND pri.dbdeleted   = FALSE
   WHERE u.dbdeleted = FALSE
   GROUP BY u.dbuser,
            pri.dbprivilege;