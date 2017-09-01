    

<%
    String KID = request.getParameter("KID");
    String KTeamRating = request.getParameter("KTeamRating");
    String Status = request.getParameter("Status");
    System.out.println(KID+"--"+KTeamRating+"--"+Status);
    String Condition = " where KID = '"+KID+"'";
    int x = com.KBank.MyFunctions.updateField("kbdata", "Status", Status, Condition);
    int y = com.KBank.MyFunctions.updateField("kbdata", "KTeamRating", KTeamRating, Condition);
    if(x==0 || y==0){
    %><P class="BoldFont Center" style="color:red">Error in updating...Please try again</P><%
    }else{
     %><P class="BoldFont Center" style="color:green">Document evaluated successfully for <%=KID%></P><%
    }
%>