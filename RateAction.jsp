<%@ page language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page errorPage="errorPage.jsp" %>   
<HEAD>
    <script LANGUAGE="Javascript" SRC="Images/AjaxCall.js"></script>
    <LINK href="styles/styles.css" type="text/css" rel="stylesheet">
    <script>
        function validate(){
           
            var frm = document.forms(0);
            var KID = frm.KID.value;
            var UserRating = frm.UserRating.value;
            var flag=false;
            URating = UserRating.value;
            URL = "RateAction.jsp?KID="+KID+"&UserRating="+URating;
            frm.action = URL;
            frm.submit();
            
        }
        
    </script>
</HEAD>
<BODY class=Main>
    <jsp:include page="CheckSession.jsp"/>  
    <BR><BR>
    <Fieldset class="custom">
        <LEGEND>Rate Submission</LEGEND><BR>
<%
    String KID = request.getParameter("KID");
    String UserRating = request.getParameter("UserRating");
    if(UserRating==null || UserRating.trim().equals("")){
        UserRating = "0";
    }
    int uRate = Integer.parseInt(UserRating);
    
    String Condition = " where KID = '"+KID+"'";
    String eRate = com.KBank.MyFunctions.getField("kbdata", "NoOfHits", Condition);
    System.out.println("[INFO] EXISTING RATING ->"+ eRate);
    int iRate = Integer.parseInt(eRate);
    int tRate = 0;
    tRate = uRate + iRate;
    String overallRating = tRate+"";
    System.out.println("[INFO] RATING ->"+ overallRating);
    int y = com.KBank.MyFunctions.updateField("kbdata", "NoOfHits", overallRating, Condition);
    if(y==0){
    %>
        <P class="BoldFont Center" style="color:red">Error in updating...Please try again</P>
        <P Align=center><a href="" onclick="window.close()">Close</a></P>
    <%
    }else{
     %>
        <P class="BoldFont Center" style="color:green">Document rated successfully for <%=KID%></P>
        <P Align=center><a href="" onclick="window.opener.location.reload();window.close()">Close</a></P>
     <%
    }
%>
    
    </FIELDSET>
</BODY>