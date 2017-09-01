<%@ page language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page errorPage="errorPage.jsp" %>
 
<%
            String UserId = (String)session.getAttribute("UserID");
            if(UserId == null || UserId.trim().equals("")) {
                session.invalidate();
                %>
                <script language=javascript>
                    window.opener = top; window.opener.location.replace("sessiontimeout.jsp");
                </script>
                <% 
            }
            String Location = application.getRealPath(request.getServletPath());
            String dirpath = Location.substring(0,Location.lastIndexOf("\\"));
            String FPath = dirpath+"\\Downloads\\";
            String SearchType = "Author";
            String SearchData = UserId;
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
        <LEGEND>My Submissions</LEGEND><BR><BR><BR><BR><BR><BR>
        <table align=center width="60%">
            <thead>
                <tr class="row_title">
                    <th colspan=3>My Submissions</th>
                </tr>
            </thead>
        </table>
        <table align=center width="60%">
            <%
            int iMatchCount=0;
            while (rs.next()) {
                String KId = rs.getString("KId");
                String Title = rs.getString("Title");
                String Description = rs.getString("Description");
                String KTeamRating = rs.getString("KTeamRating");
                String ReviewerRating = rs.getString("ReviewerRating");
                String Author = rs.getString("Author");
                String FileName = rs.getString("FileName");
                iMatchCount++;
            %>
            <tr class=row_odd>
                <td><B>K-Id</B></td><td><%=KId%></td><td><B>Title</B></td><td><%=Title%></td>
            </tr>
            <tr class=row_odd>
                <td><B>Description</B></td><td colspan=3><%=Description%></td>
            </tr>
            <tr class=row_odd><td><B>KTeamRating</B></td><td><%=KTeamRating%></td><td><B>ReviewerRating</B></td><td><%=ReviewerRating%></td></tr>
            <tr class=row_odd>
                <%
                String Fullpath = FPath+""+FileName;
                %>
                <td><B>Author</B></td><td><%=Author%></td><th colspan=2><A HREF="FileDownloads.jsp?fileName=<%=Fullpath%>">Download</a></th>
            </tr>
            <%
            }
            if(iMatchCount==0){
            %>
            <tr class=row_odd>
                <td colspan=4 align=center>No submissions till date...</td>
            </tr>
            <%
            }
            %>
        </table>
        
        
    </FIELDSET>
</BODY>
