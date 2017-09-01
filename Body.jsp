<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="styles/styles.css" rel="stylesheet"/>
    </head>
    <body class=SC>
        <BR><BR><BR>
        <P align=right><A href="ChangePassword1.jsp" class="genlinks">Change Password</A></P>
        <BR><BR><BR>
            <%
            String UserId = (String)session.getAttribute("UserID");
            UserId = UserId.toUpperCase();
            %>
            
        
 
   
    </body>
</html>
