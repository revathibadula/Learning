<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<% String Userid=(String)session.getAttribute("UserID"); %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href='styles/styles.css' rel="stylesheet"/>
        <title>Information Treasury</title>
    </head>
    <body class="Main">
    <table class=noborder width="100%">
            <tr class=noborder>
                <td class=noborder align=left><img src="Images/Information Treasury2.jpg"/></td>
                <td class=noborder align=right>Welcome&nbsp;&nbsp; <font class=BoldFont><%=Userid%></Font> <BR> <a href='Logout.jsp' class='genlinks'>Logout</a></td>
            </tr>
    </table>
    </body>
</html>
