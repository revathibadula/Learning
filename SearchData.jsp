<%@ page language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page errorPage="errorPage.jsp" %>
<%
            String Location = application.getRealPath(request.getServletPath());
            String dirpath = Location.substring(0,Location.lastIndexOf("\\"));
            String FPath = dirpath+"\\Downloads\\";
            String SearchType = request.getParameter("SearchType");
            String SearchData = request.getParameter("SearchData");
            String Query = "Select * from kbdata where Status='Published' ";
            String[] SearchDataArr = null;
            if (SearchData != null || SearchData.indexOf(",") != -1) {
                SearchDataArr = SearchData.split(",");
            }
            
            System.out.println("LENGTH : " + SearchDataArr.length);
            if (SearchDataArr.length <= 1) {
                Query += " and (`" + SearchType + "` Like '%" + SearchData + "%' ";
            } else {
                Query += " and (";
                for (int i = 0; i < SearchDataArr.length; i++) {
                    Query += " `" + SearchType + "` Like '%" + SearchDataArr[i] + "%' or";
                }
                Query = Query.substring(0, Query.lastIndexOf("or"));
            }
            Query = Query+" )";
            System.out.println(Query+"[Query]");
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
    <script LANGUAGE="Javascript" SRC="Images/AjaxCall.js"></script>
    <LINK href="styles/styles.css" type="text/css" rel="stylesheet">
    <Script language = "Javascript">
        
    </Script>
</HEAD>
<BODY class=Main>
    <jsp:include page="CheckSession.jsp"/>  
    <BR><BR>
    <Fieldset class="custom">
        <LEGEND>Search Solution</LEGEND><BR><BR><BR>
        <table align=center width="90%">
            <thead>
                <tr class="row_title">
                    <th colspan=3>Search K-Database for solutions</th>
                </tr>
            </thead>
            <tbody>
                <tr  class="row_title">
                    <td align=left><B>Results by </B> <%=SearchType%>&nbsp; : &nbsp;<%=SearchData%></td>
                </tr>
            </tbody>
        </table>
        <table align=center width="90%">
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
                String NoOfHits = rs.getString("NoOfHits");
                iMatchCount++;
            %>
            <tr class=row_odd>
                <td><B>K-Id</B></td><td><%=KId%></td><td><B>Title</B></td><td><%=Title%></td>
            </tr>
            <tr class=row_odd>
                <td><B>Description</B></td><td><%=Description%></td>
                <td><B>User Rating</B></td><td><%=NoOfHits%></td>
            </tr>
            <tr class=row_odd><td><B>KTeamRating</B></td><td><%=KTeamRating%></td><td><B>ReviewerRating</B></td><td><%=ReviewerRating%></td></tr>
            <tr class=row_odd>
                <%
                String Fullpath = FPath+""+FileName;
                %>
                <td><B>Author</B></td><td><%=Author%></td><th><A Class="genlinks" onclick="fnPopUp('Rate.jsp?KId=<%=KId%>',300,400);">Rate this</a></th><th><A HREF="FileDownloads.jsp?fileName=<%=Fullpath%>">Download</a></th>
            </tr>
            <%
            }
            if(iMatchCount==0){
            %>
            <tr class=row_odd>
                <td colspan=4 align=center>No match found...Please refine your search criteria</td>
            </tr>
            <%
            }
            %>
        </table>
        <table align=center width="90%">
            <tr>
                <td align=center><input type=Button class="Button" value="Back" onclick="location.replace('Search.jsp')"></td>
            </tr>
        </table>
        
    </FIELDSET>
</BODY>
