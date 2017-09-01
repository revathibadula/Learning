<%@ page language="java" %>
<%@ page session="true" %>
<%@ page isErrorPage="true" %>
<HEAD>
	<LINK href="styles/styles.css" type="text/css" rel="stylesheet">
</HEAD>
<body class="SC">
<%
System.out.println("________________________________\nError:  "+exception.getMessage()+"\nFile Name:  "+request.getRequestURL()+"\nTime:  "+new java.sql.Timestamp(System.currentTimeMillis())+"\n________________________________\n");
System.out.println("______________STACK TRACE___________START_____________________________________\n");
exception.printStackTrace();
System.out.println("______________STACK TRACE____________END______________________________________\n");
// Generating Path
StringBuffer sReqURL = request.getRequestURL();
String ReqURL = sReqURL.toString();
ReqURL = ReqURL.substring(0,ReqURL.lastIndexOf("/"));
System.out.println("[ReqURL] "+ReqURL);
session.invalidate();

%>
     <P>&nbsp;</P>
    <P>&nbsp;</P>
    <P>&nbsp;</P>
    <P>&nbsp;</P>
    <P>&nbsp;</P>

     
            <BR> 
	
			<table width="40%" id="table1" align=center>
				<tr class="row_title">
                                     <th colspan=2><img src="Images/error.gif"></img><FONT face=verdana size=2>Error</FONT></th>
				</tr>
				<tr>
                                     <td width="28%"><FONT face=verdana size=2><B>Reason</B></Font></td>
					<td width="71%"><FONT face=verdana size=2><%=exception.toString()%></FONT></td>
				</tr>
				<tr>
                                     <td width="28%"><FONT face=verdana size=2><B>Remedy</B></Font></td>
					<td width="71%"><FONT face="verdana" size=2><a href="<%=ReqURL%>" target="_top" class="messagelink">click here</a> to login again</FONT>
        			</td>
				</tr>
			</table>
     <P>&nbsp;</P>
    <P>&nbsp;</P>
 
</body>


