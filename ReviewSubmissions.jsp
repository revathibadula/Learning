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
            String SearchData = "InReview";
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
    <script LANGUAGE="Javascript" SRC="Images/AjaxCall.js"></script>
    <LINK href="styles/styles.css" type="text/css" rel="stylesheet">
       <script>
        function validate(){
           
            var frm = document.forms(0);
            var KID = frm.KID;
            var ReviewerRating = frm.ReviewerRating;
            var Status = frm.Status;
            var Remarks = frm.Remarks;
            var flag=false;
            if(KID.length == undefined ){
                
                if(KID.checked == true){
                    flag = true;
                    KIDValue = KID.value;
                    RRating = ReviewerRating.value;
                    Stat = Status.value;
                    Rem = Remarks.value;
                    if(Stat=="Published" && RRating=="0"){
                        alert("[DATA ERROR] Rating can not be 0 for published documents.\n Please provide valid rating");
                        return false;
                    }
                    if(Stat=="Rejected" && RRating!="0"){
                                alert("[DATA ERROR] Rating must be 0 for rejected documents.\n Please provide valid rating");
                                return false;
                            }
                    if(Rem == ""){
                        alert("[DATA ERROR] Remarks can not be empty.\n Please provide valid remarks");
                        return false;
                    }
                    URL = "ReviewAction.jsp?KID="+KIDValue+"&ReviewerRating="+RRating+"&Status="+Stat+"&Remarks="+Rem;
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
                            RRating = ReviewerRating[i].value;
                            Stat = Status[i].value;
                            Rem = Remarks[i].value;
                            if(Stat=="Published" && RRating=="0"){
                                alert("[DATA ERROR] Rating can not be 0 for published documents.\n Please provide valid rating");
                                return false;
                            }
                            if(Stat=="Rejected" && RRating!="0"){
                                alert("[DATA ERROR] Rating must be 0 for rejected documents.\n Please provide valid rating");
                                return false;
                            }
                            if(Rem == ""){
                                alert("[DATA ERROR] Remarks can not be empty.\n Please provide valid remarks");
                                return false;
                            }
                            URL = "ReviewAction.jsp?KID="+KIDValue+"&ReviewerRating="+RRating+"&Status="+Stat+"&Remarks="+Rem;
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
        <LEGEND>Review Submissions</LEGEND><BR><BR><BR><BR><BR><BR>
        <FORM Action="" name="EForm">
        <table align=center width="90%">
           <tr class="row_title">
                    <th colspan=9>Submissions</th>
                </tr>
                <tr class=row_title>
                <th>K-Id</th>
                <th>Title</th>
                <th>Description</th>
                <th>KTeamRating</th>
                <th>Author</th>
                <th>ReviewerRating</th>
                <th>Status</th>
                <th>Remarks</th>
                <th>Document</th>
            </tr>
                    <%
            int iMatchCount=0;
            while (rs.next()) {
                String KId = rs.getString("KId");
                String Title = rs.getString("Title");
                String Description = rs.getString("Description");
                String KTeamRating = rs.getString("KTeamRating");
                String Author = rs.getString("Author");
                String FileName = rs.getString("FileName");
                String Fullpath = FPath+""+FileName;
                iMatchCount++;
            %>
            <tr class=row_odd>
                <td><input type="radio" name="KID" value="<%=KId%>"> <%=KId%></td><td><%=Title%></td><td><%=Description%></td>
                <td><%=KTeamRating%></td><td><%=Author%></td>
                <th><select name="ReviewerRating" class="ListBox">
                        <option value=0>0</option>
                        <option value=1>1</option><option value=2>2</option><option value=3>3</option>
                        <option value=4>4</option><option value=5>5</option><option value=6>6</option>
                        <option value=7>7</option><option value=8>8</option><option value=9>9</option>
                        <option value=10>10</option>
                </select></th>
                <TD><select name=Status class="ListBox"><option value=Published>Published</option><option value=Rejected>Rejected</option></select></TD>
               <TD><input type="Text" class="TextField Large Left" Name="Remarks"></TD>
               <th><A HREF="FileDownloads.jsp?fileName=<%=Fullpath%>">Download</a></th>
            
            </tr>
            <%
            }
            if(iMatchCount==0){
            %>
            <tr class=row_odd>
                <td colspan=9 align=center>No submissions to validate...</td>
            </tr>
            <%
            }
           else{
                %><td align=center colspan=9><input type="button" class="Button" value="Save Review" onclick="validate()"><input type="button" class="Button" value="Reload" onclick="location.replace('ReviewSubmissions.jsp?User=Reviewer')"></td><%
            }
            %>
        </table>
    </FORM>
    <DIV id="DID"></DIV>    
    </FIELDSET>
    
</BODY>
