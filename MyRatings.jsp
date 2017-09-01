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
            
            String EmailId = UserId;
            String Query = "select kid,title,kteamrating,reviewerrating,noofhits from kbdata where author = '"+EmailId+"' and status='Published' union select '<B>Total</B>','',sum(kteamrating),sum(reviewerrating),sum(noofhits) from kbdata where author = '"+EmailId+"' and status='Published'";
            
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
        <LEGEND>My Ratings</LEGEND><BR><BR><BR><BR><BR><BR>
        <table align=center width="60%">
            <thead>
                <tr class="row_title">
                    <th colspan=3>View My Ratings</th>
                </tr>
            </thead>
        </table>
        <table align=center width="60%">
         <tr class=row_title>
                <th>K-Id</th>
                <th>Title</th>
                <th>K-Team Rating</th>
                <th>Reviewer Rating</th>
                <th>User Rating</th>
           </tr>
            <%
            int iMatchCount=0;
            while (rs.next()){
                iMatchCount++;
            }
            if(iMatchCount<=1){
            %>
            <tr class=row_odd>
                <td colspan=5 align=center>No submissions till date...</td>
            </tr>
            <%
            }else{
            rs.beforeFirst();
            while (rs.next()) {
                String KId = rs.getString("KId");
                String Title = rs.getString("Title");
                String KTeamRating = rs.getString("KTeamRating");
                if(KTeamRating==null || KTeamRating.equals("")){
                    KTeamRating = "0";
                }
                String ReviewerRating = rs.getString("ReviewerRating");
                if(ReviewerRating==null || ReviewerRating.equals("")){
                    ReviewerRating ="0";
                }
                String NoOfHits = rs.getString("noofhits");
                if(NoOfHits==null || NoOfHits.equals("")){
                    NoOfHits = "0";
                }
                
            %>
            <tr class=row_odd>
                <td><%=KId%></td>
                <td><%=Title%></td>
                <td><%=KTeamRating%></td>
                <td><%=ReviewerRating%></td>
                <td><%=NoOfHits%></td>
           </tr>
            <%
            }
            }
            %>
        </table>
        
        
    </FIELDSET>
</BODY>
