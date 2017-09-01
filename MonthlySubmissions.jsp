<%@ page language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page errorPage="errorPage.jsp" %>
 
<%
            String Year = request.getParameter("Year");
            String Month = request.getParameter("Month");
            String sDate = Year+"-"+Month;
            String Location = application.getRealPath(request.getServletPath());
            String dirpath = Location.substring(0,Location.lastIndexOf("\\"));
            String FPath = dirpath+"\\Downloads\\";
            String SearchType = "DateOfSubmission";
            String SearchData = sDate;
            String Query = "Select * from kbdata where ";
            String[] SearchDataArr = null;
            if (SearchData != null || SearchData.indexOf(",") != -1) {
                SearchDataArr = SearchData.split(",");
            }
            System.out.println("LENGTH : " + SearchDataArr.length);
            if (SearchDataArr.length <= 1) {
                Query += " `" + SearchType + "` Like '%" + SearchData + "%' ";
            } else {
                for (int i = 0; i < SearchDataArr.length; i++) {
                    Query += " `" + SearchType + "` Like '%" + SearchDataArr[i] + "%' or";
                }
                Query = Query.substring(0, Query.lastIndexOf("or"));
            }
            Connection con = null;
            Statement stmt = null;
            ResultSet rs = null;

            String UserID, Password;

            try {
                /*Getting the connection variable from session*/
                con = com.KBank.ConnectionPool.getConnection();
                stmt = con.createStatement();
                rs = stmt.executeQuery(Query);

            } catch (Exception e) {
                System.out.println("Exception" + e);
            }
%>
<HEAD>
    <script LANGUAGE="Javascript" SRC="validate.js"></script>
    <LINK href="styles/styles.css" type="text/css" rel="stylesheet">
</HEAD>
<BODY class=Main>
    <jsp:include page="CheckSession.jsp"/>  
    <BR><BR>
    <Fieldset class="custom">
        <LEGEND>Monthly Submissions</LEGEND><BR><BR><BR><BR><BR><BR>
        <form name="MSForm" action="GenericMonthlyReport.jsp" Method="POST">
        <table align=center width="30%">
            <tr class=row_title>
                <th>Year</th>
                <th>Month</th>
            </tr>
            <tr class=row_odd>
                <td>
                    <Select Name="Year" class="ListBox">
                        <script>
                            d = new Date().getFullYear();
                            for(i=d;i>=1980;i--){
                                document.writeln("<option value="+i+">"+i+"</option>");
                            }
                        </script>
                     </Select>
                </td>
                <td>
                    <Select Name="Month" class="ListBox">
                        <script>
                            for(i=1;i<=12;i++){
                                if(i>=10){
                                document.writeln("<option value="+i+">"+i+"</option>");
                                }else{
                                document.writeln("<option value=0"+i+">0"+i+"</option>");
                                }
                            }
                        </script>
                     </Select>
                    <input type=hidden name="ReportType" value="Submissions">
                </td>
                
            </tr>
            <tr class=row_odd>
                <td colspan=2 align=center><input type=submit name="submitbtn" value="Generate" class="Button"><input type=reset name="resetbtn" value="Clear"  class="Button"></td>
            </tr>
        </table>
        </form>
        
    </FIELDSET>
</BODY>
