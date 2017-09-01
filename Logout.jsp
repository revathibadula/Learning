<html>
<%@ page language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*"%>

<%@ page errorPage="errorPage.jsp" %>


<%  
try{
		session.invalidate();
}catch(IllegalStateException ise){
	System.out.println("Caught illigal state exception");
	throw new Exception(ise);
}
catch(Exception e){
		throw new Exception(e);
}
%>
<Head>
	<LINK href="styles.css" type="text/css" rel="stylesheet">
<SCRIPT LANGUAGE="JavaScript">
<!--
history.go(+1);
function CatchUnload(){
	window.opener=top;
         window.opener.close();
         window.opener.location.replace("about:home");
}
//-->
</SCRIPT>
<Title>Logout</Title>
<BODY  Class=SC onload="alert('successfully logged out.');CatchUnload();">


</BODY>
</html>