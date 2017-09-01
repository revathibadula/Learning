<%@ page language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page errorPage="errorPage.jsp" %>
 
<%
           
            String Location = application.getRealPath(request.getServletPath());
            String dirpath = Location.substring(0,Location.lastIndexOf("\\"));
            String FPath = dirpath+"\\Downloads\\";
            String SearchType = "Status";
            String SearchData = "KTeam";
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
            ArrayList rList = com.KBank.MyFunctions.getPropList("EmailId", "reviewerdetails");
            ArrayList rIDList = com.KBank.MyFunctions.getPropList("ReviewerId", "reviewerdetails");
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
    <script>
        function validate(){
            var frm = document.forms(0);
            var KID = frm.KID;
            var RID = frm.ReviewerID;
            var Status = frm.Status;
            var flag=false;
            if(KID.length == undefined ){
                if(KID.checked == true){
                        flag = true;
                        KIDValue = KID.value;
                        RID = RID.value;
                        Status = Status.value;
                        URL = "AssignReviewerAction.jsp?KID="+KIDValue+"&RID="+RID+"&Status="+Status;
                        ajaxFunction(URL,document.getElementById("DID"));

                        return true;
                    }else{
                        flag = false;
                    }
            }else{
                for(i=0;i<KID.length;i++){

                    if(KID[i].checked == true){
                        flag = true;
                        KIDValue = KID[i].value;
                        RID = RID[i].value;
                        Status = Status[i].value;
                        URL = "AssignReviewerAction.jsp?KID="+KIDValue+"&RID="+RID+"&Status="+Status;
                        ajaxFunction(URL,document.getElementById("DID"));

                        return true;
                    }else{
                        flag = false;
                    }
                }
            }
            if(flag==false){
                alert("Please select an asset to continue...");
                return false;
            }else{
                return true;
            }
            
        }
        
    </script>
</HEAD>
<BODY class=Main>
    <jsp:include page="CheckSession.jsp"/>  
    <BR><BR>
    <Fieldset class="custom">
        <LEGEND>Assign Reviewer</LEGEND><BR><BR><BR><BR><BR><BR>
        <FORM Action="" name="ARForm">
        <table align=center width="80%">
            <thead>
                <tr class="row_title">
                    <th colspan=10>Submissions</th>
                </tr>
                <tr class=row_title>
                <th>K-Id</th>
                <th>Title</th>
                <th>Description</th>
                <th>Author</th>
                <th>Document</th>
                <th>KTeam Rating</th>
                <th>Reviewer</th>
                <th>Status</th>
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
                String FileName = rs.getString("FileName");
                String Fullpath = FPath+""+FileName;
                iMatchCount++;
            %>
            <tr class=row_odd>
                <td><input type="radio" name="KID" value="<%=KId%>"> <%=KId%></td>
                <td><%=Title%></td>
                <td><%=Description%></td>
                <td><%=Author%></td>
                <th><A HREF="FileDownloads.jsp?fileName=<%=Fullpath%>">Download</a></th>
                <td><%=KTeamRating%></td>
                <td>
                    <select class="ListBox" name="ReviewerID">
                    <%
                     Iterator rListItr = rList.iterator();
                     Iterator rIDListItr = rIDList.iterator();
                     
                     while(rListItr.hasNext()){
                       String reviewerName = (String)rListItr.next();
                       String RID = (String)rIDListItr.next();
                       %><option value="<%=RID%>"><%=reviewerName%></option><%
                     }
                    
                    %>
                    </select>
                </td>
                <TD><select name=Status class="ListBox"><option value=InReview>In Review</option><option value=Rejected>Rejected</option></select></TD>
            </tr>
            <%
            }
            if(iMatchCount==0){
            %>
            <tr class=row_odd>
                <td colspan=8 align=center>No submissions to assign reviewer...</td>
            </tr>
            <%
            }else{
                %><td align=center colspan=8><input type="button" class="Button" value="Assign Reviewer" onclick="validate()"><input type="button" class="Button" value="Reload" onclick="location.replace('AssignReviewer.jsp')"></td><%
            }
            %>
        </table>
    </FORM>
    <DIV id="DID"></DIV>
    </FIELDSET>
</BODY>
