<%@ page language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page errorPage="errorPage.jsp" %>
 
<%
            String ReportType = request.getParameter("ReportType");
            String Status="";
            if(ReportType.equals("Submissions")){
                Status = "Submitted";
            }else{
                Status = "Rejected";
            }
            String Year = request.getParameter("Year");
            String Month = request.getParameter("Month");
            String sDate = Year+"-"+Month;
            String Location = application.getRealPath(request.getServletPath());
            String dirpath = Location.substring(0,Location.lastIndexOf("\\"));
            String FPath = dirpath+"\\Downloads\\";
            String SearchType = "DateOfSubmission";
            String SearchData = sDate;
            String Query = "Select * from kbdata where status = '"+Status+"' and ";
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
                System.out.println("[Query]"+Query);
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
        <LEGEND>Monthly <%=ReportType%></LEGEND><BR><BR><BR><BR><BR><BR>
        <table align=center width="95%">
           <tr class="row_title">
                    <th colspan=8><%=ReportType%></th>
                </tr>
                <tr class=row_title>
                <th>K-Id</th>
                <th>Title</th>
                <th>Date of Submission</th>
                <th>Description</th>
                <th>KTeamRating</th>
                <th>ReviewerRating</th>
                <th>Author</th>
                <th>Document</th>
            </tr>
                    <%
            int iMatchCount=0;
            while (rs.next()) {
                String KId = rs.getString("KId");
                String Title = rs.getString("Title");
                String Description = rs.getString("Description");
                String KTeamRating = rs.getString("KTeamRating");
                String DateOfSubmission = rs.getString("DateOfSubmission");
                String ReviewerRating = rs.getString("ReviewerRating");
                String Author = rs.getString("Author");
                String FileName = rs.getString("FileName");
                String Fullpath = FPath+""+FileName;
                iMatchCount++;
            %>
            <tr class=row_odd>
                <td><%=KId%></td><td><%=Title%></td><td><%=DateOfSubmission%></td><td><%=Description%></td>
                <td><%=KTeamRating%></td><td><%=ReviewerRating%></td><td><%=Author%></td>
                <th><A HREF="FileDownloads.jsp?fileName=<%=Fullpath%>">Download</a></th>
            </tr>
            <%
            }
            if(iMatchCount==0){
            %>
            <tr class=row_odd>
                <td colspan=8 align=center>No submissions in the given month..</td>
            </tr>
            <%
            }
            %>
        </table>
        
        
    </FIELDSET>
</BODY>
