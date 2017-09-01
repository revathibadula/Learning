<%@ page language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>

<%@ page errorPage="errorPage.jsp" %>


<%@ page import="java.util.Vector"%>
<jsp:include page="CheckSession.jsp"/> 
<HEAD>


	<script LANGUAGE="Javascript" SRC="validate.js"></script>



	<LINK href="styles/styles.css" type="text/css" rel="stylesheet">

</HEAD>
<BODY class=SC>
<BR><BR>
<h3 align=center>View Users</h3>
<P><a href='ViewUsersXL.jsp'>Download Excel</a></P>

<%

	Connection con=null;
	ResultSet rs=null;
	Statement stmt=null;
	try{
			
                        con = com.KBank.ConnectionPool.getConnection();
                        
                        stmt =  con.createStatement();
			String Query = "Select * from login order by `userid`";
			rs = stmt.executeQuery(Query);
			%>
						<table align="center" width="60%">
							<tr class=row_title>
							<th align="left">UserId</th><th align="left">Role</th>
							</tr>
					<%
			int rCount=0;
			while(rs.next())
			{
					%>
					<tr class= '<%=(rCount%2!=0)? "row_even" : "row_odd"%>'>
						<td><%=rs.getString(1)%></td><td><%=rs.getString(3)%></td>
					</tr>
					<%
				rCount++;
			}
			if( rCount == 0)	{%><tr class= "row_even"><td colspan=3>Sorry No records Found</td></tr><% }
			rs.close();
			stmt.close();
			con.close();
		}catch(Exception e){
			//rs.close();
			stmt.close();
			con.close();
			throw new Exception(e);
		}
	
%>
</BODY>
