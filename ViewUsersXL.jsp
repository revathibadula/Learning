<%@ page language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>

<%@ page errorPage="errorPage.jsp" %>

<%@page contentType="application/vnd.ms-excel"%>
<%response.setHeader("Content-Disposition","attachment;filename=Report.xls");%>

<%@ page import="java.util.Vector"%>

<HEAD>


	<script LANGUAGE="Javascript" SRC="validate.js"></script>


<Style>
	.row_title {
		FONT-SIZE: 8pt; BACKGROUND-COLOR: #999966 ;FONT-WEIGHT: bold; FONT-FAMILY: Verdana,Arial,helvetica,sans-serif;
	}
	.row_odd {
		FONT-SIZE: 8pt; BACKGROUND-COLOR: #c8c8c8 ;FONT-WEIGHT: normal; FONT-FAMILY: Verdana,Arial,helvetica,sans-serif;
	}
	.row_even {
		FONT-SIZE: 8pt; BACKGROUND-COLOR: #E8E8E8 ;FONT-WEIGHT: normal; FONT-FAMILY: Verdana,Arial,helvetica,sans-serif;
	}
	TABLE.notebook {
	BORDER-RIGHT: 0px; BORDER-TOP: 0px; BORDER-LEFT: 0px; WIDTH: 90%; BORDER-BOTTOM: 0px
	}
	Body.SC {
         scrollbar-arrow-color:#00000;
         scrollbar-base-color:#c8c8c8;
         scrollbar-face-color:#e8e8e8;
         scrollbar-darkshadow-color:#b8b8b8;
	 BACKGROUND-COLOR: #E8E8E8;
	 FONT-WEIGHT: normal; FONT-SIZE: 10pt; FONT-FAMILY: Verdana,Arial,helvetica,sans-serif;
	}
</Style>

</HEAD>
<BODY class=SC>
<h3 align=center>Users</h3>

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
						<table class=notebook border=1>
							<tr class=row_title>
							<th class=row_title>UserId</th><th class=row_title>Auth</th>
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
