<%@ page language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ page errorPage="errorPage.jsp" %>
<HEAD>
<script LANGUAGE="Javascript" SRC="validate.js"></script>
<LINK href="styles/styles.css" type="text/css" rel="stylesheet">
</HEAD>
<BODY class=SC>
<jsp:include page="CheckSession.jsp"/>  
<BR><BR>
 <Fieldset class="custom">
            <LEGEND>Reviewers</LEGEND><BR><BR><BR><BR><BR><BR>
<P><a href='ViewReviewersXL.jsp'>Download Excel</a></P>

<%

	Connection con=null;
	ResultSet rs=null;
	Statement stmt=null;
	try{
			
                        con = com.KBank.ConnectionPool.getConnection();
                        
                        stmt =  con.createStatement();
			String Query = "Select * from reviewerdetails order by `ReviewerId`";
			rs = stmt.executeQuery(Query);
			%>
						<table align="center" width="80%">
							<tr class=row_title>
							<th align="left">Reviewer Id</th><th align="left">Name</th><th align="left">EmailId</th><th align="left">Skillset</th><th align="left">Experience</th>
							</tr>
					<%
			int rCount=0;
			while(rs.next())
			{
					%>
					<tr class= '<%=(rCount%2!=0)? "row_even" : "row_odd"%>'>
						<td><%=rs.getString(1)%></td><td><%=rs.getString(2)%></td><td><%=rs.getString(3)%></td><td><%=rs.getString(4)%></td><td><%=rs.getString(5)%></td>
					</tr>
					<%
				rCount++;
			}
			if( rCount == 0)	{%><tr class= "row_even"><td colspan=5>Sorry No records Found</td></tr><% }
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
</FIELDSET>
</BODY>
