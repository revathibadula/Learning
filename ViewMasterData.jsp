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
<h3 align=center>Veiw Employees </h3>
<P><a href='ViewMasterDataXL.jsp'>Download Excel</a></P>

<%

	Connection con=null;
	ResultSet rs=null;
	Statement stmt=null;
	try{
			
                        con = com.KBank.ConnectionPool.getConnection();
                        
                        stmt =  con.createStatement();
			String Query = "Select * from masterdata order by `sno`";
			rs = stmt.executeQuery(Query);
			%>
						<table align="center" width="90%">
							<tr class=row_title>
							<th align="left">SNo</th>
                                                         <th align="left">EmpNo</th>
                                                         <th align="left">Name</th>
                                                         <th align="left">EmailId</th>
                                                         <th align="left">Project Code</th>
                                                         <th align="left">Client Name</th>
                                                         <th align="left">Project Manager</th>
                                                         <th align="left">Start Date</th>
                                                         <th align="left">End Date</th>
                                                         <th align="left">Current Location</th>
                                                         <th align="left">Base Location</th>
                                                         <th align="left">Joining Date</th>
                                                         <th align="left">Role</th>
                                                         <th align="left">Designation</th>
							</tr>
					<%
			int rCount=0;
			while(rs.next())
			{
					%>
					<tr class= '<%=(rCount%2!=0)? "row_even" : "row_odd"%>'>
						<td><%=rs.getString(1)%></td>
                                                 <td><%=rs.getString(2)%></td>
                                                 <td><%=rs.getString(3)%></td>
                                                 <td><%=rs.getString(4)%></td>
                                                 <td><%=rs.getString(5)%></td>
                                                 <td><%=rs.getString(6)%></td>
                                                 <td><%=rs.getString(7)%></td>
                                                 <td><%=rs.getString(8)%></td>
                                                 <td><%=rs.getString(9)%></td>
                                                 <td><%=rs.getString(10)%></td>
                                                 <td><%=rs.getString(11)%></td>
                                                 <td><%=rs.getString(12)%></td>
                                                 <td><%=rs.getString(13)%></td>
                                                 <td><%=rs.getString(14)%></td>
					</tr>
					<%
				rCount++;
			}
			if( rCount == 0)	{%><tr class= "row_even"><td colspan=15>Sorry No records Found</td></tr><% }
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

</PRE>