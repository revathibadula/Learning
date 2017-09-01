<HTML>

<%@ page language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*,java.io.*,java.util.Random"%>
<%@ page errorPage="errorPage.jsp" %>
<jsp:include page="CheckSession.jsp"/>  
<head>
<LINK href="styles/styles.css" type="text/css" rel="stylesheet">
<SCRIPT LANGUAGE="JavaScript">
<!--
history.go(+1);

//-->
</SCRIPT>
</head>

<body Class="SC">
<center>

<FONT FACE="Century Gothic">

<!--Declaration of varaibles-->

<%! String errormsg ;%>
<%! String disluserid ;%>
<%! String dislpwd ;%>
<%! String dislnewpwd ;%>
    

<% 
   /*Retreiving user id and password*/

    disluserid = request.getParameter("UserID");
    if(disluserid == null)
    disluserid = "";
    dislpwd = request.getParameter("Password");
    if(dislpwd == null)
    dislpwd = "";
	dislnewpwd = request.getParameter("newPassword");
	if(dislnewpwd == null)
	dislnewpwd="";
	//System.out.println(disluserid+dislnewpwd+dislpwd);

%>

<%

/*Declaration of variables*/

Connection con=null;
Statement stmt=null;
ResultSet rs=null;

String UserID,Password;

try
{

	/*Getting the connection variable from session*/

	con = com.KBank.ConnectionPool.getConnection();
	stmt =  con.createStatement();

	String Query = "SELECT * from Login where UserID = \'"+disluserid+
		"\' and Password =\'"+dislpwd+"\'";
	//System.out.println(Query);
	rs = stmt.executeQuery(Query);
		
}
catch(Exception e)
{
	System.out.println("Exception"+e);
}
/* If user provides valid username & password then update the new password to database*/
if(rs!=null)
{
String UpdateQuery = 
"Update Login set Password = \'"+dislnewpwd+"\' where UserID= \'"+disluserid+"\' and Password=\'"+dislpwd+"\'";
//System.out.println(UpdateQuery);
	int rowsAffected=stmt.executeUpdate(UpdateQuery);		
	//System.out.println("Rows Affected = " + rowsAffected);
if(rowsAffected==1)
	{%>
	<br><br><br>
		<H5 align="center" > Password Updated Successfully</H5>
	<BR>
    <center>
		<A href="Body.jsp" class=genlinks> Home </A>
	</center>

	<%}
/* If user provides invalid password or username*/
else{%>
	<script>
		for(i=1;i<=6;i++) document.write("<br>");
	</script>
		<H5 align="center" >UserName/Password Invalid Please Try again </H5>
	<BR>
	<center>
		<A href="ChangePassword1.jsp" class=genlinks> Back </A>
	</center>
<%
}
}
%>


</BODY>
</HTML>




