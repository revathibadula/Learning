
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE> New Document </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="">
<META NAME="Keywords" CONTENT="">
<META NAME="Description" CONTENT="">
<LINK href="styles/styles.css" type="text/css" rel="stylesheet">
</HEAD>
<%
System.out.println("INVALIDATING SESSION IN SESSION TIMED OUT PAGE");
// Generating Path
StringBuffer sReqURL = request.getRequestURL();
String ReqURL = sReqURL.toString();
ReqURL = ReqURL.substring(0,ReqURL.lastIndexOf("/"));
System.out.println("[ReqURL] "+ReqURL);

session.invalidate();
%>
<BODY class=SC>
    <P>&nbsp;</P>
    <P>&nbsp;</P>
    <P>&nbsp;</P>
    <P>&nbsp;</P>
     
            <BR> 
	
			<table width="40%" id="table1" align=center>
				<tr class='row_title'>
                                     <th colspan=2><img src="Images/error.gif"></img><FONT face=verdana size=2>Session Expired</FONT></th>
				</tr>
				<tr>
                                     <td width="28%"><FONT face=verdana size=2><B>Reason</B></Font></td>
					<td width="71%"><FONT face=verdana size=2>Your Session has expired </FONT></td>
				</tr>
				<tr>
                                     <td width="28%"><FONT face=verdana size=2><B>Remedy</B></Font></td>
					<td width="71%"><FONT face="verdana" size=2><a href="<%=ReqURL%>" target="_top" class="messagelink">click here</a> to login again</FONT>
        			</td>
				</tr>
			</table>
</BODY>
</HTML>