    

<%
    String KID = request.getParameter("KID");
    String ReviewerRating = request.getParameter("ReviewerRating");
    String Status = request.getParameter("Status");
    System.out.println(KID+"--"+ReviewerRating+"--"+Status);
    String Condition = " where KID = '"+KID+"'";
    int x = com.KBank.MyFunctions.updateField("kbdata", "Status", Status, Condition);
    int y = com.KBank.MyFunctions.updateField("kbdata", "ReviewerRating", ReviewerRating, Condition);
    if(x==0 || y==0){
    %><P class="BoldFont Center" style="color:red">Error in updating...Please try again</P><%
    }else{
     %><P class="BoldFont Center" style="color:green">Document reviewed successfully for <%=KID%></P><%
    }
%>