<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

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
%>
