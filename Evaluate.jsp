<%@ page language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page errorPage="errorPage.jsp" %>
 
<%
           
            String Location = application.getRealPath(request.getServletPath());
            String dirpath = Location.substring(0,Location.lastIndexOf("\\"));
            String FPath = dirpath+"\\Downloads\\";
            String SearchType = "Status";
            String SearchData = "Submitted";
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
    <script LANGUAGE="Javascript" SRC="Images/AjaxCall.js"></script>
    <LINK href="styles/styles.css" type="text/css" rel="stylesheet">
    <script>
        function validate(){
           
            var frm = document.forms(0);
            var KID = frm.KID;
            var KTeamRating = frm.KTeamRating;
            var Status = frm.Status;
            var flag=false;
            if(KID.length == undefined ){
                
                if(KID.checked == true){
                    flag = true;
                    KIDValue = KID.value;
                    KRating = KTeamRating.value;
                    Status = Status.value;
                    URL = "EvaluateAction.jsp?KID="+KIDValue+"&KTeamRating="+KRating+"&Status="+Status;
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
                            KRating = KTeamRating[i].value;
                            Status = Status[i].value;
                            URL = "EvaluateAction.jsp?KID="+KIDValue+"&KTeamRating="+KRating+"&Status="+Status;
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
        <LEGEND>Evaluate</LEGEND><BR><BR><BR><BR><BR><BR>
        <FORM Action="" name="EForm">
        <table align=center width="80%">
            <thead>
                <tr class="row_title">
                    <th colspan=8>Submissions</th>
                </tr>
                <tr class=row_title>
                    
                <th>K-Id</th>
                <th>Title</th>
                <th>Description</th>
                <th>Author</th>
                <th>Document</th>
                <th>KTeam Rating</th>
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
                <th><select name="KTeamRating" class="ListBox">
                        <option value=0>0</option>
                        <option value=1>1</option><option value=2>2</option><option value=3>3</option>
                        <option value=4>4</option><option value=5>5</option><option value=6>6</option>
                        <option value=7>7</option><option value=8>8</option><option value=9>9</option>
                        <option value=10>10</option>
                </select></th>
                <TD><select name=Status class="ListBox"><option value=KTeam>KTeam</option><option value=Rejected>Rejected</option></select></TD>
            </tr>
            <%
            }
            if(iMatchCount==0){
            %>
            <tr class=row_odd>
                <td colspan=8 align=center>No submissions to Evaluate...</td>
            </tr>
            <%
            }else{
                %><td align=center colspan=8><input type="button" class="Button" value="Evaluate" onclick="validate()"><input type="button" class="Button" value="Reload" onclick="location.replace('Evaluate.jsp')"></td><%
            }
            %>
            
        </table>
    </FORM>
    <DIV id="DID"></DIV>
    </FIELDSET>
</BODY>
