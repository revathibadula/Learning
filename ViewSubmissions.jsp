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
            String sUser = request.getParameter("User");
            String Reviewer = "%";
            if(sUser==null || sUser.equals("")){
                Reviewer = "%";
            }else if(sUser.equals("Reviewer")){
               Reviewer = com.KBank.MyFunctions.getField("reviewerdetails", "ReviewerId", " where EmailId = '"+UserId+"'");
            }
            String Location = application.getRealPath(request.getServletPath());
            String dirpath = Location.substring(0,Location.lastIndexOf("\\"));
            String FPath = dirpath+"\\Downloads\\";
            String SearchType = "Status";
            String SearchData = "%";
            String Query = "Select * from kbdata where ReviewerId Like '%"+Reviewer+"%' and ";
            
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
                System.out.println("QUERY [INFO] "+Query);
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
        <LEGEND>Submissions</LEGEND><BR><BR><BR><BR><BR><BR>
        <table align=center width="90%">
           <tr class="row_title">
                    <th colspan=8>Submissions</th>
                </tr>
                <tr class=row_title>
                <th>K-Id</th>
                <th>Title</th>
                <th>Description</th>
                <th>KTeamRating</th>
                <th>ReviewerRating</th>
                <th>Author</th>
                <th>Status</th>
                <th>Document</th>
            </tr>
                    <%
            int iMatchCount=0;
            while (rs.next()) {
                String KId = rs.getString("KId");
                String Title = rs.getString("Title");
                String Description = rs.getString("Description");
                String KTeamRating = rs.getString("KTeamRating");
                String ReviewerRating = rs.getString("ReviewerRating");
                String Author = rs.getString("Author");
                String Status = rs.getString("Status");
                String FileName = rs.getString("FileName");
                String Fullpath = FPath+""+FileName;
                iMatchCount++;
            %>
            <tr class=row_odd>
                <td><%=KId%></td><td><%=Title%></td><td><%=Description%></td>
                <td><%=KTeamRating%></td><td><%=ReviewerRating%></td><td><%=Author%></td><td><%=Status%></td>
                <th><A HREF="FileDownloads.jsp?fileName=<%=Fullpath%>">Download</a></th>
            </tr>
            <%
            }
            if(iMatchCount==0){
            %>
            <tr class=row_odd>
                <td colspan=7 align=center>No submissions to validate...</td>
            </tr>
            <%
            }
            %>
        </table>
        
        
    </FIELDSET>
</BODY>
