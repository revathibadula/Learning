
package com.KBank;


import java.sql.*;
import java.util.Vector;

// Referenced classes of package ims.du1.EET:
//            NewConnectionPool

public class GetMenuItems
{

    public GetMenuItems()
    {
    }

    public Vector processRequest(String MenuId, String AuthGroup)
    {
        
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        Vector vData = new Vector();
        try
        {
            int i = 0;
            int iCnt = 0;
            String sql = "select  b.childmenuid ,a.Label,d.TargetFrame,d.Executable   from menu_base a, menuitem_relationship b,menu_role_relationship c,menu_frame_executable_mapping d   where  b.childMenuId=a.menuid   and c.role='" + AuthGroup + "'" + "  and b.childmenuid  = c.menurelationshipid " + "  and b.childmenuid  = d.menurelationshipid " + "  and b.parentmenuid = " + MenuId + "  order by a.menuid";
            String menuid[] = new String[50];
            String label[] = new String[50];
            String targetFrame[] = new String[50];
            String executable[] = new String[50];
            System.out.println("sql-->" + sql);
            try
            {
                con = ConnectionPool.getConnection();
                stmt = con.createStatement();
                for(rs = stmt.executeQuery(sql); rs.next();)
                {
                    menuid[i] = rs.getString(1);
                    label[i] = rs.getString(2);
                    targetFrame[i] = rs.getString(3);
                    executable[i] = rs.getString(4);
                    i++;
                    iCnt++;
                }

                if(iCnt > 0)
                {
                    vData.add(menuid);
                    vData.add(label);
                    vData.add(targetFrame);
                    vData.add(executable);
                    vData.add(iCnt + "");
                }
                //rs.close();
                //stmt.close();
                //con.close();
            }
            catch(Exception e)
            {
                throw new Exception(e);
            }
        }
        catch(Exception xe)
        {
            System.out.println("Exception--> Xe" + xe);
        }
        finally
        {
            
        }
        return vData;
    }
}
