    

<%
    String KID = request.getParameter("KID");
    String ReviewerID = request.getParameter("RID");
    String Status = request.getParameter("Status");
    System.out.println(KID+"--"+ReviewerID+"--"+Status);
    String Condition = " where KID = '"+KID+"'";
    int x = com.KBank.MyFunctions.updateField("kbdata", "Status", Status, Condition);
    int y = com.KBank.MyFunctions.updateField("kbdata", "ReviewerID", ReviewerID, Condition);
    if(x==0 || y==0){
    %><P class="BoldFont Center" style="color:red">Error in updating...Please try again</P><%
    }else{
     %><P class="BoldFont Center" style="color:green">Reviewer assigned successfully for <%=KID%></P><%
    }
%>