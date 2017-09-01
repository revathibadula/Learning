package com.KBank;

import java.io.*;
import javax.servlet.*;
import java.sql.*;
import java.util.*;
import java.text.SimpleDateFormat;

public class MyFunctions {

    public MyFunctions() {
    }
    private static Connection conn = null;
    private static Statement stmt = null,  stmt1 = null;
    private static ResultSet rs = null;

    public static Connection openConnection() throws Exception {
        conn = ConnectionPool.getConnection();
        return conn;
    }

    public static void closeConnection() throws Exception {
        conn.close();
    }
    //Function to generate Next ID for primary key in a db table
    public static String genNextID(String TableName, String IDName,
            String Pattern) {
        String MaxID = "", NextID = Pattern;
        int MaxNum = 0;
        int L = Pattern.length();

        try {
            openConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = null;
            String Query = "select max(`" + IDName + "`) from `" + TableName +
                    "`";
            String Q2 = "Select max(CAST(SUBSTRING(" + IDName + "," + (L + 1) +
                    ",BIT_LENGTH(" + IDName + ")) AS UNSIGNED)) from  " +
                    TableName;
            //System.out.println(Q2);
            rs = stmt.executeQuery(Q2);
            if (rs == null) {
                return Pattern + "1";
            }
            if (rs.next()) {
                MaxID = rs.getString(1);
            }

            MaxNum = Integer.parseInt(MaxID);
            //System.out.println(MaxNum);
            MaxNum++;
            NextID += MaxNum;
            closeConnection();
            if (MaxNum != 0) {
                return NextID;
            } else {
                return Pattern + "1";
            }

        } catch (Exception e) {
            System.out.println("Exception in genNextID" + e);
            return Pattern + "1";
        }
    }

    public static String[] MyTokenizer(String S, String P) {
        StringTokenizer st = new StringTokenizer(S, P);
        int count = st.countTokens(), i = 0;
        String[] Tokens = new String[count];
        while (st.hasMoreTokens()) {
            Tokens[i] = st.nextToken();
            i++;
        }
        return Tokens;
    }

    public static ArrayList getPropList(String PropertyName, String TableName)
            throws Exception {
        String Sel_Prop = "Select distinct `" + PropertyName + "` from `" +
                TableName + "`";
        System.out.println(Sel_Prop);
        String str = "";
        ArrayList PropList = new ArrayList();
        try {
            openConnection();
            Statement stmt = conn.createStatement();

            rs = stmt.executeQuery(Sel_Prop);
            System.out.println("RESULTSET:" + rs);
            if (rs != null) {
                while (rs.next()) {
                    str = rs.getString(1);
                    PropList.add(str);
                }
            } else {
                System.out.println("result is null");
            }

            closeConnection();
        } catch (Exception e) {
            System.out.println("Exception in getPropList" + e);
            return null;
        }
        return PropList;
    }

    public static int compareDates(Calendar C1, Calendar C2) {
        int result = 0;

        if (C1.before(C2)) {
            result = 1;
        } else if (C1.after(C2)) {
            result = -1;
        } else {
            result = 0;
        }
        return result;
    }

    public static String formatDate(Calendar rawdate, String pattern) {
        String dateFormat = "";
        SimpleDateFormat sdf = new SimpleDateFormat(pattern);
        dateFormat = sdf.format(rawdate.getTime());
        return dateFormat;
    }

    public static Calendar getUpdatedDate(Calendar curDate, int D, int M,
            int Y) {
        Calendar newDate = curDate;
        //Updating the calendar
        newDate.set(curDate.get(Calendar.YEAR) + Y,
                curDate.get(Calendar.MONTH) + M, curDate.get(Calendar.DATE) + D);
        //Returning the new calendar object
        return newDate;
    }

    public static String getCode(String TableName, String InColumn,
            String InValue, String OutValue) {

        try {
            openConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = null;
            String Query = "select `" + OutValue + "` from `" + TableName +
                    "` where `" + InColumn + "` = '" + InValue + "'";
            System.out.println("Query--" + Query);
            rs = stmt.executeQuery(Query);

            if (rs == null) {
                closeConnection();
                return "NA";
            }
            if (rs.next()) {
                OutValue = rs.getString(1);
            }
            closeConnection();
            return OutValue;

        } catch (Exception e) {
            System.out.println("Exception in getCode" + e);
            return "NA";
        }
    }

    public static String getField(String TableName, String InColumn,
            String Condition) {
        String OutValue = "NA";
        try {
            openConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = null;
            String Query =
                    "select " + InColumn + " from `" + TableName + "`" +
                    Condition;
            System.out.println("Query--" + Query);
            rs = stmt.executeQuery(Query);

            if (rs == null) {
                closeConnection();
                return "NA";
            }
            if (rs.next()) {
                OutValue = rs.getString(1);
            }
            closeConnection();
            return OutValue;

        } catch (Exception e) {
            System.out.println("Exception in getCode" + e);
            return "NA";
        }
    }

    public static int updateField(String TableName, String Column,
            String Value, String Condition) {

        try {
            openConnection();
            Statement stmt = conn.createStatement();
            int result = 0;
            String Query =
                    "update `" + TableName + "` set `" + Column + "`= '" + Value +
                    "' " + Condition;
            System.out.println("Query--" + Query);
            result = stmt.executeUpdate(Query);
            closeConnection();
            return result;


        } catch (Exception e) {
            System.out.println("Exception in updateField" + e);
            return 0;
        }
    }

    public static String getStartDate() {
        Calendar today = Calendar.getInstance();
        Calendar April1 = Calendar.getInstance();
        Calendar April2 = Calendar.getInstance();
        Calendar Oct1 = Calendar.getInstance();
        Calendar Oct2 = Calendar.getInstance();
        April1.set(today.get(Calendar.YEAR), Calendar.APRIL, 1);
        April2.set(today.get(Calendar.YEAR), Calendar.APRIL, 15);
        int result1 = com.KBank.MyFunctions.compareDates(today,
                April1);
        int result2 = com.KBank.MyFunctions.compareDates(today,
                April2);
        Oct1.set(today.get(Calendar.YEAR), Calendar.OCTOBER, 1);
        Oct2.set(today.get(Calendar.YEAR), Calendar.OCTOBER, 15);
        int result3 =
                com.KBank.MyFunctions.compareDates(today, Oct1);
        int result4 =
                com.KBank.MyFunctions.compareDates(today, Oct2);
        int sum1 = result1 + result2;
        int sum2 = result3 + result4;
        String StartDate = "";
        if ((sum1 >= -1 && sum1 <= 1) == true) {
            StartDate = com.KBank.MyFunctions.formatDate(April1,
                    "yyyy-MM-dd");
        } else if ((sum2 >= -1 && sum2 <= 1) == true) {
            StartDate = com.KBank.MyFunctions.formatDate(Oct1,
                    "yyyy-MM-dd");
        }
        return StartDate;
    }

    public static String getEndDate() {
        Calendar today = Calendar.getInstance();
        Calendar April1 = Calendar.getInstance();
        Calendar April2 = Calendar.getInstance();
        Calendar Oct1 = Calendar.getInstance();
        Calendar Oct2 = Calendar.getInstance();
        April1.set(today.get(Calendar.YEAR), Calendar.APRIL, 1);
        April2.set(today.get(Calendar.YEAR), Calendar.APRIL, 15);
        int result1 = com.KBank.MyFunctions.compareDates(today,
                April1);
        int result2 = com.KBank.MyFunctions.compareDates(today,
                April2);
        Oct1.set(today.get(Calendar.YEAR), Calendar.OCTOBER, 1);
        Oct2.set(today.get(Calendar.YEAR), Calendar.OCTOBER, 15);
        int result3 =
                com.KBank.MyFunctions.compareDates(today, Oct1);
        int result4 =
                com.KBank.MyFunctions.compareDates(today, Oct2);
        int sum1 = result1 + result2;
        int sum2 = result3 + result4;
        String EndDate = "";
        if ((sum1 >= -1 && sum1 <= 1) == true) {
            EndDate = com.KBank.MyFunctions.formatDate(Oct1,
                    "yyyy-MM-dd");
        } else if ((sum2 >= -1 && sum2 <= 1) == true) {
            Calendar NewApril1 =
                    com.KBank.MyFunctions.getUpdatedDate(April1, 0,
                    0, 1);
            System.out.println(NewApril1.getTime().toString());
            EndDate = com.KBank.MyFunctions.formatDate(NewApril1,
                    "yyyy-MM-dd");
        }
        return EndDate;
    }

    public static String getCurrentAppraisalId(String EmpNo) {
        String AppraisalId = "";
        String StartDate = getStartDate();
        AppraisalId = "A" + EmpNo + "-" + StartDate;
        return AppraisalId;
    }

    public static String getCurrentAppraisalPeriod() {
        Calendar today = Calendar.getInstance();
        String StartDate = StartDate = com.KBank.MyFunctions.formatDate(today, "yyyy-MM-dd");
        System.out.println(StartDate + "----");
        String StartYear = "";
        if (StartDate.length() > 0) {
            StartYear = StartDate.substring(0, 4);
        } else {
            return "NA";
        }
        String EndYear = StartYear;
        int ed = Integer.parseInt(EndYear);
        ed++;
        EndYear = new Integer(ed).toString();
        
        System.out.println(StartYear + "----" + EndYear);
        String AppraisalPeriod = StartYear + "-" + EndYear;
        return AppraisalPeriod;
    }

    public static String getLastAppraisalPeriod() {
        Calendar today = Calendar.getInstance();
        String StartDate = com.KBank.MyFunctions.formatDate(today, "yyyy-MM-dd");
        System.out.println(StartDate + "----");
        String StartYear = "";
        if (StartDate.length() > 0) {
            StartYear = StartDate.substring(0, 4);
        } else {
            return "NA";
        }

        String EndYear = "";
        EndYear = StartYear;
        int sd = Integer.parseInt(StartYear);
        sd--;
        StartYear = new Integer(sd).toString();
        System.out.println(StartYear + "----" + EndYear);
        String AppraisalPeriod = StartYear + "-" + EndYear;
        return AppraisalPeriod;
    }
}
